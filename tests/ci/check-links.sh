#!/usr/bin/env bash
# =============================================================================
# check-links.sh — shared-brain reference integrity
# =============================================================================
# Asserts that every repo-relative *.md path referenced from a skill, chain,
# wiki page, or top-level doc actually resolves to a real file. This is the
# automated version of the manual audit that found the frameworks/ drift:
# if a skill ever references gtm-skills/foo.md or wiki/bar.md that does not
# exist, CI fails.
#
# Scope: all tracked *.md files EXCEPT CHANGELOG.md (a historical log that
# intentionally names files that have since been renamed or removed).
# Templated paths (containing { or }) such as clients/{slug}/... or
# gtm-skills/forged-{name}.md are skipped — they are patterns, not real files.
# =============================================================================
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 1

SHARED_DIRS='gtm-skills|wiki|frameworks|sops|best-practices|templates|examples|tests|raw|assets'
fail=0

mapfile -t files < <(git ls-files '*.md' | grep -vx 'CHANGELOG.md')

refs=$(grep -hoE "(${SHARED_DIRS})/[A-Za-z0-9_./-]+\.md" "${files[@]}" 2>/dev/null | sort -u)

while IFS= read -r ref; do
  [ -z "$ref" ] && continue
  case "$ref" in
    *"{"*|*"}"*) continue ;;   # templated patterns (clients/{slug}/…, forged-{name}.md)
    *forged-*)   continue ;;   # forged-*.md skills are created on demand by skill-forge
  esac
  if [ ! -f "$ref" ]; then
    echo "BROKEN REF: $ref"
    fail=1
  fi
done <<< "$refs"

if [ "$fail" -eq 0 ]; then
  echo "link-check: all .md references resolve ✓"
fi
exit "$fail"
