#!/usr/bin/env bash
# =============================================================================
# test-safety-guard.sh - allow/block matrix for the PreToolUse safety guard
# =============================================================================
# Feeds synthetic tool-call payloads to .claude/hooks/safety-guard.sh and
# asserts the exit code (2 = block, 0 = allow). Covers both connected Instantly
# namespaces (DPS + Verity), Slack, Stripe, the default-deny fallthrough for
# unreviewed operations, and the read/write edge cases so the guard cannot
# silently go inert again (the original H3 finding, and the later stale-
# blocklist finding from the pre-onboarding review).
# =============================================================================
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 1

GUARD=".claude/hooks/safety-guard.sh"
fail=0

run() {
  local code
  printf '{"tool_name":"%s","tool_input":{}}' "$1" | bash "$GUARD" >/dev/null 2>&1
  code=$?
  printf '%s' "$code"
}

expect() {
  local name="$1" want="$2" code
  code=$(run "$name")
  if [ "$want" = "block" ] && [ "$code" != "2" ]; then
    echo "FAIL expected BLOCK, got exit $code: $name"; fail=1
  elif [ "$want" = "allow" ] && [ "$code" != "0" ]; then
    echo "FAIL expected ALLOW, got exit $code: $name"; fail=1
  fi
}

# --- must BLOCK (mutations / comms / financial across namespaces) ---
expect "mcp__claude_ai_DPS_Instantly__activate_campaign"            block
expect "mcp__claude_ai_Verity_Instantly_account__pause_campaign"    block
expect "mcp__claude_ai_DPS_Instantly__delete_lead"                  block
expect "mcp__claude_ai_DPS_Instantly__update_campaign"              block
expect "mcp__claude_ai_DPS_Instantly__leads_update_interest_status" block
expect "mcp__claude_ai_DPS_Instantly__move_leads_to_campaign_or_list" block
expect "mcp__claude_ai_DPS_Instantly__blocklist_create"            block
expect "mcp__claude_ai_Slack__slack_send_message"                  block
expect "mcp__stripe__create_refund"                                block

# --- previously-missed write operations (the stale-blocklist finding) ---
expect "mcp__claude_ai_DPS_Instantly__custom_tags_create"          block
expect "mcp__claude_ai_DPS_Instantly__custom_tags_delete"          block
expect "mcp__claude_ai_DPS_Instantly__custom_tags_update"          block
expect "mcp__claude_ai_DPS_Instantly__custom_tags_toggle"          block
expect "mcp__claude_ai_DPS_Instantly__custom_prompt_templates_create" block
expect "mcp__claude_ai_DPS_Instantly__custom_prompt_templates_delete" block
expect "mcp__claude_ai_DPS_Instantly__lead_labels_create"          block
expect "mcp__claude_ai_DPS_Instantly__lead_labels_delete"          block
expect "mcp__claude_ai_DPS_Instantly__lead_labels_update"          block
expect "mcp__claude_ai_DPS_Instantly__inbox_placement_create"      block
expect "mcp__claude_ai_DPS_Instantly__inbox_placement_delete"      block
expect "mcp__claude_ai_DPS_Instantly__inbox_placement_update"      block
expect "mcp__claude_ai_DPS_Instantly__workspace_group_members_create" block
expect "mcp__claude_ai_DPS_Instantly__workspace_group_members_delete" block
expect "mcp__claude_ai_DPS_Instantly__workspace_whitelabel-create" block
expect "mcp__claude_ai_DPS_Instantly__workspace_whitelabel-delete" block
expect "mcp__claude_ai_DPS_Instantly__crm_actions_delete-phone-number" block
expect "mcp__claude_ai_DPS_Instantly__enrichment_ai"               block
expect "mcp__claude_ai_DPS_Instantly__enrichment_update-settings"  block
expect "mcp__claude_ai_DPS_Instantly__accounts_mark-fixed"         block
expect "mcp__claude_ai_DPS_Instantly__accounts_test_vitals"        block
expect "mcp__claude_ai_DPS_Instantly__webhooks_test"               block
expect "mcp__claude_ai_DPS_Instantly__lead_labels_test_ai"         block
expect "mcp__claude_ai_DPS_Instantly__mark_thread_as_read"         block

# --- must ALLOW (reads stay automatic) ---
expect "mcp__claude_ai_DPS_Instantly__list_campaigns"              allow
expect "mcp__claude_ai_DPS_Instantly__get_campaign_analytics"      allow
expect "mcp__claude_ai_DPS_Instantly__analytics_campaign_overview" allow
expect "mcp__claude_ai_DPS_Instantly__email_verification_status"   allow
expect "mcp__claude_ai_DPS_Instantly__campaigns_sending-status"    allow
expect "mcp__claude_ai_DPS_Instantly__count_unread_emails"         allow
expect "mcp__claude_ai_Verity_Instantly_account__list_leads"       allow
expect "mcp__claude_ai_Verity_Instantly_account__workspace_get"    allow
expect "mcp__claude_ai_Slack__slack_read_channel"                  allow
expect "mcp__claude_ai_Slack__slack_search_users"                  allow

# --- default-deny fallthrough: an operation on neither list must BLOCK, ---
# --- not silently pass through just because it's unrecognized ---
expect "mcp__claude_ai_DPS_Instantly__some_future_write_endpoint"  block
expect "mcp__claude_ai_Notion__delete_database"                    block

# --- dangerous Bash still blocked ---
if ! printf '{"tool_name":"Bash","tool_input":{"command":"rm -rf /tmp/x"}}' | bash "$GUARD" >/dev/null 2>&1; then
  : # exit 2 -> non-zero -> blocked (expected)
else
  echo "FAIL expected BLOCK for 'rm -rf' Bash command"; fail=1
fi

# --- native Claude Code tools never go through the MCP allow/block logic ---
if printf '{"tool_name":"Read","tool_input":{"file_path":"CLAUDE.md"}}' | bash "$GUARD" >/dev/null 2>&1; then
  : # exit 0 -> allowed (expected)
else
  echo "FAIL expected ALLOW for native tool 'Read'"; fail=1
fi
if printf '{"tool_name":"Grep","tool_input":{"pattern":"x"}}' | bash "$GUARD" >/dev/null 2>&1; then
  :
else
  echo "FAIL expected ALLOW for native tool 'Grep'"; fail=1
fi

# --- Instantly API wrapper: verb-gated (commands carry no double-quotes) ---
bash_run() {   # command -> exit code
  local code
  printf '{"tool_name":"Bash","tool_input":{"command":"%s"}}' "$1" | bash "$GUARD" >/dev/null 2>&1
  code=$?
  printf '%s' "$code"
}
bash_expect() {   # desc, command, block|allow
  local desc="$1" cmd="$2" want="$3" code
  code=$(bash_run "$cmd")
  if [ "$want" = "block" ] && [ "$code" != "2" ]; then
    echo "FAIL expected BLOCK, got exit $code: $desc"; fail=1
  elif [ "$want" = "allow" ] && [ "$code" != "0" ]; then
    echo "FAIL expected ALLOW, got exit $code: $desc"; fail=1
  fi
}

# reads - allow
bash_expect "wrapper GET campaigns"        ".claude/bin/instantly.sh GET /campaigns"                       allow
bash_expect "wrapper GET analytics"        ".claude/bin/instantly.sh GET /campaigns/abc/analytics"         allow
bash_expect "wrapper POST leads/list read" ".claude/bin/instantly.sh POST /leads/list '{}'"                allow
bash_expect "wrapper --client GET"         ".claude/bin/instantly.sh --client acme GET /campaigns"         allow

# writes / sends - block
bash_expect "wrapper POST activate"        ".claude/bin/instantly.sh POST /campaigns/abc/activate"         block
bash_expect "wrapper POST pause"           ".claude/bin/instantly.sh POST /campaigns/abc/pause"            block
bash_expect "wrapper PATCH campaign"       ".claude/bin/instantly.sh PATCH /campaigns/abc"                 block
bash_expect "wrapper DELETE lead"          ".claude/bin/instantly.sh DELETE /leads/abc"                    block
bash_expect "wrapper POST create lead"     ".claude/bin/instantly.sh POST /leads '{}'"                     block
bash_expect "wrapper --client POST write"  ".claude/bin/instantly.sh --client acme POST /campaigns/x/activate" block

# raw HTTP to the API - block (key-leak protection; forces the wrapper)
bash_expect "raw curl to API"              "curl https://api.instantly.ai/api/v2/campaigns"                block
bash_expect "raw curl POST to API"         "curl -X POST https://api.instantly.ai/api/v2/campaigns/x/activate" block

# printing a real credentials file - block (key-leak protection)
bash_expect "cat credentials"              "cat clients/acme/secrets/credentials.md"                       block
bash_expect "grep credentials"             "grep instantly_api_key clients/acme/secrets/credentials.md"    block

if [ "$fail" -eq 0 ]; then
  echo "safety-guard: allow/block matrix passed ✓"
fi
exit "$fail"
