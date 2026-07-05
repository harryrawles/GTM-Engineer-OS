#!/usr/bin/env bash
# =============================================================================
# test-safety-guard.sh — block/allow matrix for the PreToolUse safety guard
# =============================================================================
# Feeds synthetic tool-call payloads to .claude/hooks/safety-guard.sh and
# asserts the exit code (2 = block, 0 = allow). Covers both connected Instantly
# namespaces (DPS + Verity), Slack, Stripe, and the read/write edge cases so
# the guard cannot silently go inert again (the original H3 finding).
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
expect "mcp__claude_ai_DPS_Instantly__blocklist_create"            block
expect "mcp__claude_ai_Slack__slack_send_message"                  block
expect "mcp__stripe__create_refund"                                block

# --- must ALLOW (reads stay automatic) ---
expect "mcp__claude_ai_DPS_Instantly__list_campaigns"              allow
expect "mcp__claude_ai_DPS_Instantly__get_campaign_analytics"      allow
expect "mcp__claude_ai_DPS_Instantly__analytics_campaign_overview" allow
expect "mcp__claude_ai_DPS_Instantly__email_verification_status"   allow
expect "mcp__claude_ai_DPS_Instantly__campaigns_sending-status"    allow
expect "mcp__claude_ai_DPS_Instantly__count_unread_emails"         allow

# --- dangerous Bash still blocked ---
if ! printf '{"tool_name":"Bash","tool_input":{"command":"rm -rf /tmp/x"}}' | bash "$GUARD" >/dev/null 2>&1; then
  : # exit 2 -> non-zero -> blocked (expected)
else
  echo "FAIL expected BLOCK for 'rm -rf' Bash command"; fail=1
fi

if [ "$fail" -eq 0 ]; then
  echo "safety-guard: block/allow matrix passed ✓"
fi
exit "$fail"
