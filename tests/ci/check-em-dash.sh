#!/usr/bin/env bash
# =============================================================================
# check-em-dash.sh - enforce the no-em-dash writing rule
# =============================================================================
# Harry's rule (CLAUDE.md -> Behaviour Rules): never use an em dash (that long
# dash character) anywhere in the OS. Use a hyphen, comma, colon, or period
# instead. This scans every tracked text file for the character and fails CI
# if one slipped through. git grep -I skips binary files automatically.
# =============================================================================
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 1

EM_DASH=$(printf '\xe2\x80\x94')

matches=$(git grep -InF "$EM_DASH" -- . 2>/dev/null || true)

if [ -n "$matches" ]; then
  echo "EM DASH FOUND (Harry's rule: never use one; use a hyphen, comma, colon, or period):"
  echo "$matches"
  exit 1
fi

echo "em-dash-check: no em dashes found ✓"
exit 0
