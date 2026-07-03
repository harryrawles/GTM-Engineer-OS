#!/bin/bash

# =============================================================================
# Session Logger — Claude Code Event Logger
# =============================================================================
# Logs every Claude Code hook event to a per-session JSONL file.
# Output: .claude/sessions/<session_id>.jsonl (one JSON object per line)
#
# Distinct from clients/{slug}/session-log.md (the per-client AI-readable skill
# invocation log read by pattern-detector). This file is the raw system
# audit trail — unconditional, cannot be skipped by a skill.
#
# Requires: jq (brew install jq / choco install jq / apt install jq)
# =============================================================================

INPUT=$(cat)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../sessions"
mkdir -p "$LOG_DIR"

SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "unknown"' 2>/dev/null)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
TRANSCRIPT="$LOG_DIR/${SESSION_ID}.jsonl"

case "$EVENT" in
  UserPromptSubmit)
    PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty' 2>/dev/null | head -c 2000)
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
