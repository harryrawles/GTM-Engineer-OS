#!/usr/bin/env bash
# =============================================================================
# check-secrets.sh - isolation & secret-tracking guard
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

# 4. Instantly has no single documented key prefix, so also catch a real-looking
#    value sitting in the field meant to hold it - i.e. `instantly_api_key` (or
#    similar) followed by something that isn't a `{{PLACEHOLDER}}`. Vendored
#    third-party packages are excluded (same reasoning as check-em-dash.sh -
#    build artefacts/SRI hashes in there produce noise, not real leaks).
if git grep -nIE '(instantly_api_key|instantly_workspace_id)[^{]{0,10}[A-Za-z0-9_-]{20,}' \
     -- ':(exclude)CHANGELOG.md' ':(exclude)tests/ci/check-secrets.sh' ':(exclude).claude/skills/**' > /tmp/secret-hits-2 2>/dev/null; then
  echo "POSSIBLE REAL INSTANTLY KEY/WORKSPACE ID IN TRACKED FILES:"; cat /tmp/secret-hits-2; fail=1
fi

# 5. Generic high-entropy patterns other key-shape checks miss: JWTs and
#    embedded connection-string credentials (user:password@host).
if git grep -nIE '(eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}|(postgres|postgresql|mysql|mongodb\+srv|mongodb)://[^:@/[:space:]]+:[^@/[:space:]]+@)' \
     -- ':(exclude)CHANGELOG.md' ':(exclude)tests/ci/check-secrets.sh' ':(exclude).claude/skills/**' > /tmp/secret-hits-3 2>/dev/null; then
  echo "POSSIBLE JWT / CONNECTION-STRING CREDENTIAL IN TRACKED FILES:"; cat /tmp/secret-hits-3; fail=1
fi

if [ "$fail" -eq 0 ]; then
  echo "secret-scan: no tracked secrets, credentials, or key material ✓"
fi
exit "$fail"
