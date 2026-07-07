#!/bin/bash

# =============================================================================
# Session Logger - Claude Code Event Logger
# =============================================================================
# Two independent outputs:
#
# 1. Raw JSONL audit trail → .claude/sessions/<session_id>.jsonl (one JSON
#    object per event). Requires jq for safe string escaping; skipped cleanly
#    if jq is unavailable (no malformed lines are ever written).
#
# 2. Deterministic compounding BACKSTOP (see pattern-detector.md): on
#    UserPromptSubmit, appends one redacted "via:hook" row to the active
#    client's clients/{slug}/session-log.md so pattern-detector keeps a signal
#    even if a skill forgets its STEP-0 row. This works WITH OR WITHOUT jq.
#    Skill rows remain the richer record; pattern-detector dedupes the two.
#
# jq install (recommended): brew install jq / choco install jq / apt install jq
# =============================================================================

INPUT=$(cat)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DIR="$SCRIPT_DIR/../sessions"
mkdir -p "$LOG_DIR"

HAVE_JQ=0
command -v jq >/dev/null 2>&1 && HAVE_JQ=1

# --- field extraction (jq-optional) ---
if [ "$HAVE_JQ" -eq 1 ]; then
  SESSION_ID=$(printf '%s' "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)
  EVENT=$(printf '%s' "$INPUT" | jq -r '.hook_event_name // "unknown"' 2>/dev/null)
  TOOL_NAME=$(printf '%s' "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
else
  SESSION_ID=$(printf '%s' "$INPUT" | grep -oE '"session_id"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/')
  [ -z "$SESSION_ID" ] && SESSION_ID="unknown"
  EVENT=$(printf '%s' "$INPUT" | grep -oE '"hook_event_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/')
  [ -z "$EVENT" ] && EVENT="unknown"
  TOOL_NAME=$(printf '%s' "$INPUT" | grep -oE '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/')
fi
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
TRANSCRIPT="$LOG_DIR/${SESSION_ID}.jsonl"

# ── Deterministic compounding backstop (runs with or without jq) ─────────────
# Only fires when an active client is set AND its log already exists (the
# onboarder creates it). Never creates folders; silent no-op otherwise.
if [ "$EVENT" = "UserPromptSubmit" ]; then
  if [ "$HAVE_JQ" -eq 1 ]; then
    PROMPT=$(printf '%s' "$INPUT" | jq -r '.prompt // empty' 2>/dev/null | head -c 2000)
  else
    PROMPT=$(printf '%s' "$INPUT" | grep -oE '"prompt"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/' | head -c 2000)
  fi

  SLUG=$(tr -d '\r\n' < "$REPO_ROOT/_state/active-client" 2>/dev/null | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')
  CLIENT_LOG="$REPO_ROOT/clients/$SLUG/session-log.md"
  if [ -n "$SLUG" ] && [ -f "$CLIENT_LOG" ]; then
    # Redact: drop email addresses, strip pipes/newlines, collapse spaces, cap 60 chars.
    SUMMARY=$(printf '%s' "$PROMPT" \
      | tr '\n\t' '  ' \
      | sed -E 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/[email]/g' \
      | sed 's/|/\//g' \
      | sed -E 's/[[:space:]]+/ /g; s/^ +//; s/ +$//' \
      | cut -c1-60)
    [ -z "$SUMMARY" ] && SUMMARY="(prompt)"
    MD_TS=$(date -u +"%Y-%m-%d %H:%M")
    ROW="| $MD_TS | $SUMMARY | via:hook | (auto-captured; deterministic backstop) |"
    # Insert as the first data row of the Active Log table (newest first).
    awk -v row="$ROW" '
      BEGIN { sect=0; done=0 }
      /^## Active Log/ { sect=1 }
      { print }
      (sect==1 && done==0 && /^\|-{3,}/) { print row; done=1 }
    ' "$CLIENT_LOG" > "$CLIENT_LOG.tmp" 2>/dev/null && mv "$CLIENT_LOG.tmp" "$CLIENT_LOG" 2>/dev/null
  fi
fi

# ── Raw JSONL audit trail (requires jq for safe escaping) ────────────────────
if [ "$HAVE_JQ" -eq 0 ]; then
  exit 0
fi

case "$EVENT" in
  UserPromptSubmit)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"user_prompt\",\"sid\":\"$SESSION_ID\",\"prompt\":$(echo "$PROMPT" | jq -Rs .)}" >> "$TRANSCRIPT"
    ;;
  PreToolUse)
    TOOL_INPUT=$(echo "$INPUT" | jq -c '.tool_input // {}' 2>/dev/null | head -c 1000)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"tool_start\",\"sid\":\"$SESSION_ID\",\"tool\":\"$TOOL_NAME\",\"input\":$TOOL_INPUT}" >> "$TRANSCRIPT"
    ;;
  PostToolUse)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"tool_done\",\"sid\":\"$SESSION_ID\",\"tool\":\"$TOOL_NAME\"}" >> "$TRANSCRIPT"
    ;;
  PostToolUseFailure)
    STDERR=$(echo "$INPUT" | jq -r '.tool_error // empty' 2>/dev/null | head -c 500)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"tool_fail\",\"sid\":\"$SESSION_ID\",\"tool\":\"$TOOL_NAME\",\"error\":$(echo "$STDERR" | jq -Rs .)}" >> "$TRANSCRIPT"
    ;;
  Stop)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"response_complete\",\"sid\":\"$SESSION_ID\"}" >> "$TRANSCRIPT"
    ;;
  PreCompact)
    PROMPT_COUNT=$(grep -c '"user_prompt"' "$TRANSCRIPT" 2>/dev/null) || PROMPT_COUNT=0
    TOOL_COUNT=$(grep -c '"tool_start"' "$TRANSCRIPT" 2>/dev/null) || TOOL_COUNT=0
    FAIL_COUNT=$(grep -c '"tool_fail"' "$TRANSCRIPT" 2>/dev/null) || FAIL_COUNT=0
    LAST_PROMPT=$(grep '"user_prompt"' "$TRANSCRIPT" 2>/dev/null | tail -1 | jq -r '.prompt // ""' 2>/dev/null | head -c 300)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"compaction\",\"sid\":\"$SESSION_ID\",\"snapshot\":{\"prompts\":$PROMPT_COUNT,\"tools\":$TOOL_COUNT,\"failures\":$FAIL_COUNT,\"last_prompt\":$(echo "$LAST_PROMPT" | jq -Rs .)}}" >> "$TRANSCRIPT"
    ;;
  SessionEnd)
    PROMPT_COUNT=$(grep -c '"user_prompt"' "$TRANSCRIPT" 2>/dev/null) || PROMPT_COUNT=0
    TOOL_COUNT=$(grep -c '"tool_start"' "$TRANSCRIPT" 2>/dev/null) || TOOL_COUNT=0
    FAIL_COUNT=$(grep -c '"tool_fail"' "$TRANSCRIPT" 2>/dev/null) || FAIL_COUNT=0
    COMPACT_COUNT=$(grep -c '"compaction"' "$TRANSCRIPT" 2>/dev/null) || COMPACT_COUNT=0
    FIRST_TS=$(head -1 "$TRANSCRIPT" 2>/dev/null | jq -r '.ts // ""' 2>/dev/null)
    TOP_TOOLS=$(grep '"tool_start"' "$TRANSCRIPT" 2>/dev/null | jq -r '.tool' 2>/dev/null | sort | uniq -c | sort -rn | head -5 | awk '{print $2"("$1")"}' | tr '\n' ',' | sed 's/,$//')
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"session_end\",\"sid\":\"$SESSION_ID\",\"summary\":{\"started\":\"$FIRST_TS\",\"prompts\":$PROMPT_COUNT,\"tools\":$TOOL_COUNT,\"failures\":$FAIL_COUNT,\"compactions\":$COMPACT_COUNT,\"top_tools\":\"$TOP_TOOLS\"}}" >> "$TRANSCRIPT"
    ;;
  *)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"$EVENT\",\"sid\":\"$SESSION_ID\"}" >> "$TRANSCRIPT"
    ;;
esac

exit 0
