#!/usr/bin/env bash
# =============================================================================
# check-secrets.sh — isolation & secret-tracking guard
# =============================================================================
# Fails CI if the repo ever starts tracking a client's secrets, a real
# credentials file, or anything that looks like an API key / private key.
# Enforces the spec's "never commit secrets" + full client isolation rules.
# =============================================================================
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 1

fail=0

# 1. Nothing under any client's secrets/ may be tracked.
leak=$(git ls-files 'clients/*/secrets/*')
if [ -n "$leak" ]; then
  echo "TRACKED CLIENT SECRETS:"; echo "$leak"; fail=1
fi

# 2. The only tracked credentials file is the shape-only template.
cred=$(git ls-files '*credentials.md')   # matches real credentials.md, NOT credentials.template.md
if [ -n "$cred" ]; then
  echo "TRACKED credentials.md (should never be committed):"; echo "$cred"; fail=1
fi

# 3. No obvious key material in any tracked file (CHANGELOG excluded as noise-free history).
if git grep -nIE '(sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|gh[oprs]_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----)' \
     -- ':(exclude)CHANGELOG.md' ':(exclude)tests/ci/check-secrets.sh' > /tmp/secret-hits 2>/dev/null; then
  echo "POSSIBLE KEY MATERIAL IN TRACKED FILES:"; cat /tmp/secret-hits; fail=1
fi

if [ "$fail" -eq 0 ]; then
  echo "secret-scan: no tracked secrets, credentials, or key material ✓"
fi
exit "$fail"
