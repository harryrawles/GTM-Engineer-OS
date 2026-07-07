#!/bin/bash

# =============================================================================
# Session Start Context - SessionStart Hook
# =============================================================================
# Deterministically reminds the model to run the Session Start Protocol -
# specifically to resolve the active client and run pattern-detector FIRST -
# so the auto-improvement loop is not left to chance. Wired for the "startup"
# source only (not resume/clear) in .claude/settings.json.
#
# Mechanism: SessionStart hooks add context by printing a JSON object with
# hookSpecificOutput.additionalContext to stdout, then exiting 0. The string
# below is fixed (no interpolation), so there is no injection risk.
# =============================================================================

cat > /dev/null 2>&1   # consume stdin (hook input JSON); we don't need it

cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"GTM Engineer OS - Session Start Protocol: (1) read _state/active-client and state the active client (if none and the task is client-specific, ask which client); (2) run gtm-skills/pattern-detector.md FIRST per CLAUDE.md before routing the request; (3) assemble context, then route via the Skill Routing Table."}}
JSON

exit 0
