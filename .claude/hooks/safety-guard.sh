#!/bin/bash

# =============================================================================
# Safety Guard — PreToolUse Hook
# =============================================================================
# Blocks dangerous tool calls before they execute. Reads the tool call from
# stdin (JSON), checks against the blocklist, exits 2 to block or 0 to allow.
#
# Exit codes: 0 = allow | 2 = block (Claude shows the block message to user)
#
# CUSTOMISE: replace mcp__instantly__* tool names to match your Instantly MCP.
# Run: ask Claude Code "list available Instantly MCP tools" to find exact names.
# =============================================================================

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)
TOOL_INPUT=$(echo "$INPUT" | jq -c '.tool_input // {}' 2>/dev/null)

BLOCKED_TOOLS=(

  # ---------------------------------------------------------------------------
  # 1. INSTANTLY — campaign and lead mutations
  #    Require Harry's explicit approval before executing.
  #    Confirm exact tool names: ask Claude "list available Instantly MCP tools"
  # ---------------------------------------------------------------------------
  "mcp__instantly__activate_campaign"
  "mcp__instantly__pause_campaign"
  "mcp__instantly__resume_campaign"
  "mcp__instantly__delete_campaign"
  "mcp__instantly__update_campaign"
  "mcp__instantly__update_sequence"
  "mcp__instantly__delete_sequence"
  "mcp__instantly__update_sequence_step"
  "mcp__instantly__delete_sequence_step"
  "mcp__instantly__move_leads_to_campaign"
  "mcp__instantly__delete_lead"
  "mcp__instantly__delete_leads"
  "mcp__instantly__mark_as_unsubscribed"
  "mcp__instantly__add_to_blocklist"
  "mcp__instantly__update_email_account"
  "mcp__instantly__delete_email_account"
  "mcp__instantly__update_workspace"

  # ---------------------------------------------------------------------------
  # 2. EXTERNAL MESSAGING — never send without Harry's explicit approval
  # ---------------------------------------------------------------------------
  "mcp__gmail__send_email"
  "mcp__gmail__send_draft"
  "mcp__gmail__create_draft"
  "mcp__slack__slack_post_message"
  "mcp__slack__slack_send_message"
  "mcp__slack__slack_schedule_message"
  "mcp__slack__slack_reply_to_thread"

  # ---------------------------------------------------------------------------
  # 3. FINANCIAL OPERATIONS
  # ---------------------------------------------------------------------------
  "mcp__stripe__create_invoice"
  "mcp__stripe__finalize_invoice"
  "mcp__stripe__create_refund"
  "mcp__stripe__create_payment_link"

  # ---------------------------------------------------------------------------
  # 4. DESTRUCTIVE DATA OPERATIONS
  # ---------------------------------------------------------------------------
  "mcp__airtable__delete_records"
  "mcp__notion__delete_block"
  "mcp__hubspot__delete_contact"

  # ---------------------------------------------------------------------------
  # 5. GITHUB MUTATIONS
  # ---------------------------------------------------------------------------
  "mcp__github__push_files"
  "mcp__github__create_or_update_file"
  "mcp__github__merge_pull_request"
)

for blocked in "${BLOCKED_TOOLS[@]}"; do
  [[ "$blocked" == \#* ]] && continue
  if [ "$TOOL_NAME" = "$blocked" ]; then
    case "$TOOL_NAME" in
      *instantly*activate*|*instantly*resume*)  CATEGORY="Instantly — activating campaign (live sends)" ;;
      *instantly*pause*)                        CATEGORY="Instantly — pausing campaign" ;;
      *instantly*delete*campaign*)              CATEGORY="Instantly — deleting campaign (irreversible)" ;;
      *instantly*delete*lead*|*instantly*bulk*) CATEGORY="Instantly — deleting leads (irreversible)" ;;
      *instantly*update*|*instantly*sequence*)  CATEGORY="Instantly — modifying sequence or account" ;;
      *instantly*blocklist*|*unsubscribe*)      CATEGORY="Instantly — suppression list change" ;;
      *send*|*post*|*reply*|*draft*)            CATEGORY="External messaging" ;;
      *stripe*|*invoice*|*refund*)              CATEGORY="Financial operation" ;;
      *delete*)                                 CATEGORY="Destructive delete" ;;
      *push*|*merge*)                           CATEGORY="GitHub mutation" ;;
      *)                                        CATEGORY="Blocked operation" ;;
    esac
    DETAILS=$(echo "$TOOL_INPUT" | jq -c '.' 2>/dev/null | head -c 300)
    echo "SAFETY GUARD BLOCKED: $CATEGORY"
    echo "Tool: $TOOL_NAME"
    echo "Details: $DETAILS"
    echo ""
    echo "State exactly what you were about to do, then ask Harry for explicit approval before retrying."
    exit 2
  fi
done

# ─── Dangerous bash patterns ──────────────────────────────────────────────────
if [ "$TOOL_NAME" = "Bash" ]; then
  CMD=$(echo "$TOOL_INPUT" | jq -r '.command // ""' 2>/dev/null)

  if echo "$CMD" | grep -qE '\bgit\s+push\s+.*(-f|--force)\b'; then
    echo "SAFETY GUARD BLOCKED: git push --force rewrites remote history. Ask Harry for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\bgit\s+push\s+.*\b(origin\s+)?(main|master)\b'; then
    echo "SAFETY GUARD BLOCKED: git push to main/master bypasses review. Ask Harry for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\bgit\s+reset\s+--hard\b'; then
    echo "SAFETY GUARD BLOCKED: git reset --hard discards uncommitted work permanently. Ask Harry for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\brm\s+-(rf|fr)\b'; then
    echo "SAFETY GUARD BLOCKED: rm -rf is irreversible. Ask Harry for approval."; exit 2
  fi
  if echo "$CMD" | grep -qiE '\b(DROP\s+(TABLE|DATABASE|SCHEMA)|TRUNCATE\s+TABLE)\b'; then
    echo "SAFETY GUARD BLOCKED: Destructive SQL. Ask Harry for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '(curl|wget)\s.*\|\s*(ba)?sh'; then
    echo "SAFETY GUARD BLOCKED: Remote code execution (curl|sh). Ask Harry for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\brm\s.*\.(env|pem|key|credentials|secret)'; then
    echo "SAFETY GUARD BLOCKED: Deleting a credentials/secrets file. Ask Harry for approval."; exit 2
  fi
fi

exit 0
