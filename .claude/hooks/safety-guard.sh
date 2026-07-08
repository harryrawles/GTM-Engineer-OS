#!/bin/bash

# =============================================================================
# Safety Guard - PreToolUse Hook
# =============================================================================
# Blocks dangerous tool calls before they execute. Reads the tool call from
# stdin (JSON), checks against the allow/block lists, exits 2 to block or 0
# to allow.
#
# Exit codes: 0 = allow | 2 = block (Claude shows the block message to user)
#
# MATCHING MODEL (default-deny): MCP tool names are "mcp__<server>__<operation>".
# We match on the OPERATION (everything after the last "__"), NOT the full
# name, so the guard is namespace-agnostic - it fires regardless of which
# Instantly/Slack workspace the MCP server is mounted under (e.g.
# mcp__claude_ai_DPS_Instantly__, mcp__claude_ai_Verity_Instantly_account__,
# mcp__claude_ai_Slack__).
#
# For any MCP tool call (tool name starts with "mcp__"):
#   1. OP in ALLOWED_READS  -> allow (curated, exact-match list of known-safe
#      reads - built from the actual connected tool inventory, not a prefix
#      guess. Naming isn't consistent enough for prefix/suffix heuristics to
#      be safe: e.g. "move_leads_to_campaign_or_list" ENDS in "_list" but is a
#      mutation, and "leads_update_interest_status" ENDS in "_status" but is a
#      mutation. Only exact names vetted below are trusted.)
#   2. OP in BLOCKED_OPS    -> block, with a specific categorized message.
#   3. Anything else        -> block by default (unreviewed/future/unknown
#      operation). This is the actual default-deny behaviour: a new Instantly
#      endpoint, or any other connected MCP tool's write, is blocked until
#      someone deliberately adds it to one of the two lists below.
#
# Native Claude Code tools (Read, Edit, Write, Bash, Grep, Glob, WebFetch,
# Task, ...) never go through this MCP allow/block logic at all - they don't
# start with "mcp__". Bash gets its own dangerous-pattern checks further down,
# unchanged by this model.
#
# jq is used when present but is OPTIONAL: if jq is missing (common on
# Windows) the guard falls back to a regex extract of the raw JSON rather than
# failing open. It never silently allows a mutation just because jq is absent.
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

# ─── Known-safe reads (exact match only - see MATCHING MODEL above) ─────────
ALLOWED_READS=(
  # Instantly - analytics / status / list / get / count / search
  "account_mappings_get"
  "accounts_ctd-status"
  "analytics_campaign_overview"
  "analytics_campaign_steps"
  "analytics_daily_account"
  "api_keys_list"
  "audit_logs_list"
  "blocklist_get"
  "blocklist_list"
  "campaigns_count-launched"
  "campaigns_sending-status"
  "count_unread_emails"
  "crm_actions_list-phone-numbers"
  "custom_prompt_templates_get"
  "custom_prompt_templates_list"
  "custom_tag_mappings_list"
  "custom_tags_get"
  "custom_tags_list"
  "dfy_orders_check_domains"
  "dfy_orders_list"
  "dfy_orders_list_accounts"
  "dfy_orders_pre_warmed"
  "dfy_orders_similar_domains"
  "email_templates_list"
  "email_verification_status"
  "enrichment_ai-progress"
  "enrichment_count"
  "enrichment_get"
  "enrichment_history"
  "enrichment_preview"
  "get_account"
  "get_background_job"
  "get_campaign"
  "get_campaign_analytics"
  "get_daily_campaign_analytics"
  "get_email"
  "get_lead"
  "get_server_info"
  "get_verification_stats_for_lead_list"
  "get_warmup_analytics"
  "inbox_placement_analytics_get"
  "inbox_placement_analytics_insights"
  "inbox_placement_analytics_list"
  "inbox_placement_analytics_stats_by_date"
  "inbox_placement_analytics_stats_by_test"
  "inbox_placement_esp-options"
  "inbox_placement_get"
  "inbox_placement_list"
  "inbox_placement_reports_get"
  "inbox_placement_reports_list"
  "lead_labels_get"
  "lead_labels_list"
  "lead_lists_get"
  "list_accounts"
  "list_background_jobs"
  "list_campaigns"
  "list_emails"
  "list_lead_lists"
  "list_leads"
  "sales_flow_list"
  "search_campaigns_by_contact"
  "subsequences_list"
  "subsequences_sending_status"
  "webhook_events_get"
  "webhook_events_list"
  "webhook_events_summary"
  "webhook_events_summary-by-date"
  "webhooks_event_types"
  "webhooks_get"
  "webhooks_list"
  "workspace_billing_plan-details"
  "workspace_billing_subscription-details"
  "workspace_get"
  "workspace_group_members_get"
  "workspace_group_members_get-admin"
  "workspace_group_members_list"
  "workspace_members_get"
  "workspace_members_list"
  "workspace_whitelabel-get"

  # Slack - read-only
  "slack_get_reactions"
  "slack_list_channel_members"
  "slack_read_canvas"
  "slack_read_channel"
  "slack_read_file"
  "slack_read_thread"
  "slack_read_user_profile"
  "slack_search_channels"
  "slack_search_emojis"
  "slack_search_public"
  "slack_search_public_and_private"
  "slack_search_users"
)

BLOCKED_OPS=(

  # ---------------------------------------------------------------------------
  # 1. INSTANTLY - campaign / lead / account / sequence / workspace MUTATIONS
  #    Require the GTME's explicit approval before executing (spec Safety Guard #2).
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
  "accounts_mark-fixed"
  "accounts_test_vitals"
  "manage_account_state"
  "mark_thread_as_read"
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
  "custom_prompt_templates_create"
  "custom_prompt_templates_update"
  "custom_prompt_templates_delete"
  "custom_tags_create"
  "custom_tags_update"
  "custom_tags_delete"
  "custom_tags_toggle"
  "lead_labels_create"
  "lead_labels_update"
  "lead_labels_delete"
  "lead_labels_test_ai"
  "inbox_placement_create"
  "inbox_placement_update"
  "inbox_placement_delete"
  "crm_actions_delete-phone-number"
  "enrichment_ai"
  "enrichment_create"
  "enrichment_enrich"
  "enrichment_run"
  "enrichment_update-settings"
  "dfy_orders_create"
  "dfy_orders_cancel"
  "verify_email"
  "api_keys_create"
  "api_keys_delete"
  "webhooks_create"
  "webhooks_update"
  "webhooks_delete"
  "webhooks_resume"
  "webhooks_test"
  "workspace_update"
  "workspace_change-owner"
  "workspace_members_create"
  "workspace_members_update"
  "workspace_members_delete"
  "workspace_group_members_create"
  "workspace_group_members_delete"
  "workspace_whitelabel-create"
  "workspace_whitelabel-delete"

  # ---------------------------------------------------------------------------
  # 2. EXTERNAL MESSAGING - never send/forward/reply without explicit approval
  #    (spec Safety Guard #1). Covers Slack, Gmail, and Instantly inbox sends.
  # ---------------------------------------------------------------------------
  "slack_send_message"
  "slack_send_message_draft"
  "slack_schedule_message"
  "slack_post_message"
  "slack_reply_to_thread"
  "slack_create_conversation"
  "slack_create_canvas"
  "slack_update_canvas"
  "slack_add_reaction"
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

if [[ "$TOOL_NAME" == mcp__* ]]; then
  for allowed in "${ALLOWED_READS[@]}"; do
    if [ "$OP" = "$allowed" ]; then
      exit 0
    fi
  done

  for blocked in "${BLOCKED_OPS[@]}"; do
    if [ "$OP" = "$blocked" ]; then
      case "$OP" in
        activate_campaign|campaigns_bulk-activate)  CATEGORY="Instantly - activating campaign (live sends)" ;;
        pause_campaign|campaigns_bulk-pause)        CATEGORY="Instantly - pausing campaign" ;;
        delete_campaign)                            CATEGORY="Instantly - deleting campaign (irreversible)" ;;
        *lead*)                                     CATEGORY="Instantly - lead mutation (may be irreversible)" ;;
        blocklist_*)                                CATEGORY="Instantly - suppression list change" ;;
        accounts_*|manage_account_state|mark_thread_as_read|subsequences_*|sales_flow_*|update_campaign|create_campaign|campaigns_duplicate|email_templates_*|custom_prompt_templates_*|custom_tags_*|inbox_placement_*|crm_actions_*|enrichment_*|dfy_orders_*|verify_email|api_keys_*|webhooks_*|workspace_*|*_email|email_*)
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

  # Default-deny: an MCP operation that matched neither list is unreviewed.
  # Block rather than guess - this is what closes the class of gap where a new
  # Instantly/Slack endpoint (or any other connected tool's write) would
  # otherwise pass through silently just because nobody added it to a list yet.
  echo "SAFETY GUARD BLOCKED: unrecognized operation \"$OP\" - not on the reviewed read list, defaulting to block."
  echo "Tool: $TOOL_NAME"
  echo ""
  echo "If this is genuinely a read, ask the GTME to review it and add it to ALLOWED_READS in"
  echo "safety-guard.sh. Otherwise, state exactly what you were about to do, name the"
  echo "client/workspace, then ask the GTME for explicit approval before retrying."
  exit 2
fi

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
