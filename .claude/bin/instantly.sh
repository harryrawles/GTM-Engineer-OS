#!/usr/bin/env bash

# =============================================================================
# instantly.sh - per-client Instantly API v2 caller
# =============================================================================
# The OS talks to each client's Instantly workspace by calling the REST API v2
# directly (https://developer.instantly.ai/) with THAT client's API key. There
# is one API key per client, stored in the git-ignored file
# clients/{slug}/secrets/credentials.md. This wrapper is the ONLY sanctioned way
# to make those calls.
#
# WHY A WRAPPER (not raw curl):
#   1. Isolation - it loads only the ACTIVE client's key (or an inline
#      --client override). One key in memory at a time; no cross-client bleed.
#   2. Security - the key is read from the file INSIDE this script and handed to
#      curl via a stdin config (`curl -K -`). The key therefore never appears in
#      the command line, the process list (`ps`), the chat transcript, or the
#      .claude/sessions/*.jsonl audit trail. Raw curl to api.instantly.ai is
#      blocked by safety-guard.sh precisely so the key can never leak that way.
#   3. Safety - safety-guard.sh gates THIS wrapper by HTTP verb: GET (and the
#      read-only `POST /leads/list`) run automatically; every other verb
#      (POST/PATCH/PUT/DELETE = a mutation or send) is blocked pending the GTME's
#      explicit approval, per CLAUDE.md → Safety Guard.
#
# USAGE (what Claude types via the Bash tool):
#   .claude/bin/instantly.sh GET  /campaigns
#   .claude/bin/instantly.sh GET  /campaigns/CAMPAIGN_ID/analytics
#   .claude/bin/instantly.sh POST /leads/list '{"campaign_id":"..."}'      # read
#   .claude/bin/instantly.sh POST /campaigns/CAMPAIGN_ID/activate          # WRITE - gated
#   .claude/bin/instantly.sh --client acme GET /campaigns                  # inline override
#
# Endpoint reference + read/write map: sops/instantly-api.md
# =============================================================================

set -uo pipefail

BASE_URL="https://api.instantly.ai/api/v2"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

die() { printf 'instantly.sh ERROR: %s\n' "$1" >&2; exit 1; }

# --- Args: [--client SLUG] METHOD PATH [JSON_BODY] ---------------------------
CLIENT_OVERRIDE=""
if [ "${1:-}" = "--client" ]; then
  CLIENT_OVERRIDE="${2:-}"
  shift 2 || die "--client needs a slug"
fi

METHOD="$(printf '%s' "${1:-}" | tr '[:lower:]' '[:upper:]')"
API_PATH="${2:-}"
BODY="${3:-}"

[ -n "$METHOD" ]   || die "usage: instantly.sh [--client SLUG] METHOD PATH [JSON_BODY]"
[ -n "$API_PATH" ] || die "usage: instantly.sh [--client SLUG] METHOD PATH [JSON_BODY]"
case "$API_PATH" in
  /*) : ;;
  *)  die "PATH must start with '/' (e.g. /campaigns), got: $API_PATH" ;;
esac
case "$METHOD" in
  GET|POST|PATCH|PUT|DELETE) : ;;
  *) die "unsupported METHOD: $METHOD" ;;
esac

# --- Resolve the active client (or inline override) --------------------------
if [ -n "$CLIENT_OVERRIDE" ]; then
  SLUG="$CLIENT_OVERRIDE"
elif [ -f "$REPO_ROOT/_state/active-client" ]; then
  SLUG="$(tr -d ' \t\r\n' < "$REPO_ROOT/_state/active-client" 2>/dev/null || true)"
else
  SLUG=""
fi
[ -n "$SLUG" ] || die "no active client set (_state/active-client empty) and no --client override. Run 'switch to {client}' first."

CRED="$REPO_ROOT/clients/$SLUG/secrets/credentials.md"
[ -f "$CRED" ] || die "no credentials file for '$SLUG' ($CRED). Onboard the client first."

# --- Extract the key from the markdown table (value never printed) -----------
# Row shape: | `instantly_api_key` | VALUE |   → take field 3, strip spaces/backticks.
KEY="$(grep -i 'instantly_api_key' "$CRED" 2>/dev/null | head -1 | awk -F'|' '{print $3}' | tr -d '[:space:]`' || true)"
[ -n "$KEY" ] || die "instantly_api_key not found or empty in $CRED"
case "$KEY" in
  *'{{'*|*'}}'*) die "instantly_api_key in $CRED is still a placeholder ({{...}}). Fill in the real key (git-ignored)." ;;
esac

# --- Call the API ------------------------------------------------------------
# The Authorization header (with the key) is passed via stdin config so it is
# NOT visible in argv / ps. The request body is not secret and goes on argv.
CURL_ARGS=( -sS -X "$METHOD" -H "Content-Type: application/json" -H "Accept: application/json" )
[ -n "$BODY" ] && CURL_ARGS+=( --data "$BODY" )
CURL_ARGS+=( -w $'\n[HTTP %{http_code}]\n' "$BASE_URL$API_PATH" )

printf 'header = "Authorization: Bearer %s"\n' "$KEY" | curl -K - "${CURL_ARGS[@]}"
