#!/bin/bash

# =============================================================================
# Safety Guard - PreToolUse Hook
# =============================================================================
# Blocks dangerous tool calls before they execute. Reads the tool call from
# stdin (JSON), checks against the blocklist, exits 2 to block or 0 to allow.
#
# Exit codes: 0 = allow | 2 = block (Claude shows the block message to user)
#
# MATCHING MODEL: MCP tool names are "mcp__<server>__<operation>". We match on
# the OPERATION (everything after the last "__"), NOT the full name, so the
# guard is namespace-agnostic - it fires regardless of which Instantly/Slack
# workspace the MCP server is mounted under (e.g. mcp__claude_ai_DPS_Instantly__,
# mcp__claude_ai_Verity_Instantly_account__, mcp__claude_ai_Slack__). Reads
# (list_/get_/analytics_/count_/search_/*_status) are never in the blocklist, so
# they stay automatic per CLAUDE.md. Add a new mutating operation by listing its
# operation name (no namespace) in BLOCKED_OPS below.
#
# jq is used when present but is OPTIONAL: if jq is missing (common on Windows)
# the guard falls back to a regex extract of the raw JSON rather than failing
# open. It never silently allows a mutation just because jq is absent.
# =============================================================================

INPUT=$(cat)

# jq-optional parsing - must NOT fail open if jq is unavailable.
if command -v jq >/dev/null 2>&1; then
  TOOL_NAME=$(printf '%s' "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)
  TOOL_INPUT=$(printf '%s' "$INPUT" | jq -c '.tool_input // {}' 2>/dev/null)
else
  TOOL_NAME=$(printf '%s' "$INPUT" | grep -oE '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/')
  TOOL_INPUT="$INPUT"
fi

# Operation = substring after the final "__" (full name if there is no "__").
OP="${TOOL_NAME##*__}"

BLOCKED_OPS=(

  # ---------------------------------------------------------------------------
  # 1. INSTANTLY - campaign / lead / account / sequence / workspace MUTATIONS
  #    Require the GTME's explicit approval before executing (spec Safety Guard #2).
  #    Reads (list_/get_/analytics_/count_/search_/*_status) are NOT listed and
  #    therefore always pass.
  # ---------------------------------------------------------------------------
  "activate_campaign"
  "pause_campaign"
  "delete_campaign"
  "update_campaign"
  "create_campaign"
  "campaigns_bulk-activate"
  "campaigns_bulk-pause"
  "campaigns_duplicate"
  "create_lead"
  "update_lead"
  "delete_lead"
  "leads_bulk_delete"
  "leads_bulk_assign"
  "leads_merge"
  "move_leads_to_campaign_or_list"
  "add_leads_to_campaign_or_list_bulk"
  "leads_update_interest_status"
  "leads_subsequence_move"
  "leads_remove_from_subsequence"
  "create_lead_list"
  "update_lead_list"
  "delete_lead_list"
  "create_account"
  "update_account"
  "delete_account"
  "accounts_pause"
  "accounts_resume"
  "accounts_warmup_enable"
  "accounts_warmup_disable"
  "manage_account_state"
  "blocklist_create"
  "blocklist_update"
  "blocklist_delete"
  "subsequences_create"
  "subsequences_update"
  "subsequences_delete"
  "subsequences_pause"
  "subsequences_resume"
  "subsequences_duplicate"
  "sales_flow_create"
  "sales_flow_update"
  "sales_flow_delete"
  "email_templates_create"
  "email_templates_delete"
  "api_keys_create"
  "api_keys_delete"
  "webhooks_create"
  "webhooks_update"
  "webhooks_delete"
  "webhooks_resume"
  "workspace_update"
  "workspace_change-owner"
  "workspace_members_create"
  "workspace_members_update"
  "workspace_members_delete"
  "enrichment_create"
  "enrichment_enrich"
  "enrichment_run"
  "dfy_orders_create"
  "dfy_orders_cancel"
  "verify_email"

  # ---------------------------------------------------------------------------
  # 2. EXTERNAL MESSAGING - never send/forward/reply without explicit approval
  #    (spec Safety Guard #1). Covers Slack, Gmail, and Instantly inbox sends.
  # ---------------------------------------------------------------------------
  "slack_send_message"
  "slack_send_message_draft"
  "slack_schedule_message"
  "slack_post_message"
  "slack_reply_to_thread"
  "send_email"
  "send_draft"
  "create_draft"
  "reply_to_email"
  "email_forward"
  "email_update"
  "email_delete"

  # ---------------------------------------------------------------------------
  # 3. FINANCIAL OPERATIONS (spec Safety Guard #4)
  # ---------------------------------------------------------------------------
  "create_invoice"
  "finalize_invoice"
  "create_refund"
  "create_payment_link"
  "create_charge"
  "create_subscription"

  # ---------------------------------------------------------------------------
  # 4. DESTRUCTIVE DATA OPERATIONS (other connected tools)
  # ---------------------------------------------------------------------------
  "delete_records"
  "delete_block"
  "delete_page"
  "delete_contact"

  # ---------------------------------------------------------------------------
  # 5. GITHUB MUTATIONS
  # ---------------------------------------------------------------------------
  "push_files"
  "create_or_update_file"
  "merge_pull_request"
)

for blocked in "${BLOCKED_OPS[@]}"; do
  [[ "$blocked" == \#* ]] && continue
  if [ "$OP" = "$blocked" ]; then
    case "$OP" in
      activate_campaign|campaigns_bulk-activate)  CATEGORY="Instantly - activating campaign (live sends)" ;;
      pause_campaign|campaigns_bulk-pause)        CATEGORY="Instantly - pausing campaign" ;;
      delete_campaign)                            CATEGORY="Instantly - deleting campaign (irreversible)" ;;
      *lead*)                                     CATEGORY="Instantly - lead mutation (may be irreversible)" ;;
      blocklist_*)                                CATEGORY="Instantly - suppression list change" ;;
      subsequences_*|sales_flow_*|update_campaign|create_campaign|campaigns_duplicate|*account*|email_templates_*|*_email|email_*|api_keys_*|webhooks_*|workspace_*|enrichment_*|dfy_orders_*)
                                                  CATEGORY="Instantly - modifying sequence / account / workspace" ;;
      slack_*|send_email|send_draft|create_draft) CATEGORY="External messaging" ;;
      create_invoice|finalize_invoice|create_refund|create_payment_link|create_charge|create_subscription)
                                                  CATEGORY="Financial operation" ;;
      delete_*)                                   CATEGORY="Destructive delete" ;;
      push_files|create_or_update_file|merge_pull_request)
                                                  CATEGORY="GitHub mutation" ;;
      *)                                          CATEGORY="Blocked operation" ;;
    esac
    if command -v jq >/dev/null 2>&1; then
      DETAILS=$(printf '%s' "$TOOL_INPUT" | jq -c '.' 2>/dev/null | head -c 300)
    else
      DETAILS=$(printf '%s' "$TOOL_INPUT" | tr -d '\n' | head -c 300)
    fi
    echo "SAFETY GUARD BLOCKED: $CATEGORY"
    echo "Tool: $TOOL_NAME"
    echo "Details: $DETAILS"
    echo ""
    echo "State exactly what you were about to do, name the client/workspace, then ask the GTME for explicit approval before retrying."
    exit 2
  fi
done

# ─── Dangerous bash patterns ──────────────────────────────────────────────────
if [ "$TOOL_NAME" = "Bash" ]; then
  if command -v jq >/dev/null 2>&1; then
    CMD=$(printf '%s' "$TOOL_INPUT" | jq -r '.command // ""' 2>/dev/null)
  else
    CMD=$(printf '%s' "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/')
  fi

  # ─── Instantly API - per-client keys via .claude/bin/instantly.sh ───────────
  # Raw curl/wget to the API is blocked outright: it would put the key in argv
  # (and therefore in logs). All Instantly access must go through the wrapper.
  if echo "$CMD" | grep -qiE '(curl|wget)\b[^|]*api\.instantly\.ai'; then
    echo "SAFETY GUARD BLOCKED: raw HTTP call to api.instantly.ai."
    echo "Use .claude/bin/instantly.sh - it loads the active client's key from the git-ignored"
    echo "secrets file and keeps it out of argv/logs. If a mutation is intended, state the action"
    echo "and workspace, then ask the GTME for explicit approval."
    exit 2
  fi
  # Gate the wrapper by HTTP verb. GET and the read-only 'POST /leads/list' run
  # automatically; POST/PATCH/PUT/DELETE are mutations/sends and need approval
  # (CLAUDE.md → Safety Guard #2). A bare mention (e.g. cat'ing the script, no
  # verb) is ignored - only an actual verbed invocation is gated.
  if echo "$CMD" | grep -qE 'instantly\.sh[[:space:]]'; then
    VERB=$(echo "$CMD" | sed -nE 's|.*instantly\.sh[[:space:]]+(--client[[:space:]]+[^[:space:]]+[[:space:]]+)?([A-Za-z]+).*|\2|p' | tr '[:lower:]' '[:upper:]')
    case "$VERB" in
      POST|PATCH|PUT|DELETE)
        if echo "$CMD" | grep -qE 'instantly\.sh([[:space:]]+--client[[:space:]]+[^[:space:]]+)?[[:space:]]+[Pp][Oo][Ss][Tt][[:space:]]+/leads/list([[:space:]]|$)'; then
          : # read-only list endpoint (POST by API design) - allow
        else
          echo "SAFETY GUARD BLOCKED: Instantly API mutation via instantly.sh (verb: $VERB)."
          echo "Details: $(printf '%s' "$CMD" | tr -d '\n' | head -c 200)"
          echo ""
          echo "State exactly what you were about to do, name the client/workspace, then ask the GTME for explicit approval before retrying."
          exit 2
        fi
        ;;
      *) : ;;  # GET (or no clear verb) - reads are automatic
    esac
  fi

  # ─── Never print a real per-client credentials file (would leak the key) ────
  if echo "$CMD" | grep -qE '(cat|less|more|head|tail|bat|nl|xxd|od|strings|grep|egrep|awk|sed|cut|tr|rev|tac|sort|printf|echo)\b[^|]*clients/[^[:space:]]*/secrets/credentials\.md'; then
    echo "SAFETY GUARD BLOCKED: printing a client's credentials.md would expose the API key in logs."
    echo "The key is read internally by .claude/bin/instantly.sh - you never need to display it."
    exit 2
  fi

  if echo "$CMD" | grep -qE '\bgit\s+push\s+.*(-f|--force)\b'; then
    echo "SAFETY GUARD BLOCKED: git push --force rewrites remote history. Ask the GTME for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\bgit\s+push\s+.*\b(origin\s+)?(main|master)\b'; then
    echo "SAFETY GUARD BLOCKED: git push to main/master bypasses review. Ask the GTME for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\bgit\s+reset\s+--hard\b'; then
    echo "SAFETY GUARD BLOCKED: git reset --hard discards uncommitted work permanently. Ask the GTME for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\brm\s+-(rf|fr)\b'; then
    echo "SAFETY GUARD BLOCKED: rm -rf is irreversible. Ask the GTME for approval."; exit 2
  fi
  if echo "$CMD" | grep -qiE '\b(DROP\s+(TABLE|DATABASE|SCHEMA)|TRUNCATE\s+TABLE)\b'; then
    echo "SAFETY GUARD BLOCKED: Destructive SQL. Ask the GTME for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '(curl|wget)\s.*\|\s*(ba)?sh'; then
    echo "SAFETY GUARD BLOCKED: Remote code execution (curl|sh). Ask the GTME for approval."; exit 2
  fi
  if echo "$CMD" | grep -qE '\brm\s.*\.(env|pem|key|credentials|secret)'; then
    echo "SAFETY GUARD BLOCKED: Deleting a credentials/secrets file. Ask the GTME for approval."; exit 2
  fi
fi

exit 0
