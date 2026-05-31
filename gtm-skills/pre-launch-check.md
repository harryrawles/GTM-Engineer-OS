---
name: pre-launch-check
description: Pre-flight gate that validates the client OS is complete and consistent before campaigns launch. Scans for unresolved placeholders, missing files, incomplete sections, and config drift. Invoked by cold-email-writer and campaign-launcher before producing output.
triggers:
  - "Run pre-launch check"
  - "Verify OS is ready"
  - "Check setup status"
  - "Is this client ready to launch"
reads:
  - "CLAUDE.md"
  - "company/_config.md"
  - "company/*.md"
writes:
  - "company/_config.md (updates setup_complete flag)"
---

# Skill: Pre-Launch Check

**Trigger:** "Run pre-launch check", "Verify OS is ready", "Check setup status", "Is this client ready to launch"

**Context:** A gate. Validates the client OS is complete and consistent before letting campaigns launch. Other skills (cold-email-writer, campaign-launcher, weekly-reviewer) invoke this before producing client-facing output.

**Why this exists:** if the onboarder missed a placeholder, copy can go out with `Hey {{firstName}}, I'm Harry from {{CLIENT_NAME}}` in the body. This skill catches that.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## STEP 0 — Log Invocation (mandatory)

Before any other step, append one row to `company/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end — captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt — no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## CHECKS PERFORMED

### Block-level (CRITICAL — fail = stop)

1. **No unresolved `{{PLACEHOLDER}}` strings** in:
   - `CLAUDE.md`
   - `company/_config.md`
   - `company/overview.md`
   - `company/icp.md`
   - `company/offer.md`
   - `company/voice.md`

2. **No unresolved `{{TO CONFIRM}}` markers** anywhere in `company/*.md`.

3. **`company/_config.md` has all required fields filled:**
   - `client_name`
   - `industry`
   - `primary_contact_name`
   - `primary_contact_email`
   - `instantly_workspace_url`
   - `template_version`

4. **Instantly MCP connection verified** (`mcp_connected: true` in config).

### Warn-level (HIGH — fail = warn, can override)

5. **`company/offer.md` has at least:**
   - One named case study with a specific number
   - At least 3 approved claims listed
   - Risk reversal / guarantee defined

6. **`company/icp.md` has at least:**
   - 1 priority signal defined
   - 2+ decision-maker titles
   - Lead filter criteria block populated
   - Avoid list with at least one entry

7. **`company/voice.md` has at least:**
   - Tone defined
   - Banned words list (even if empty, must be confirmed)
   - Spelling default explicitly set (UK / US)

8. **`company/campaign-state.md` has:**
   - At least one campaign or planning entry
   - Infrastructure section filled (domains, mailboxes, warmup status)

### Soft-level (LOW — informational)

9. `company/decision-log.md` exists (even if empty — should have header)
10. `company/comms-log.md` exists
11. `company/copy-library.md` exists
12. `company/test-log.md` exists
13. SLA defined in `company/overview.md`
14. Success criteria defined in `company/overview.md`

---

## OUTPUT FORMAT

```
=== Pre-Launch Check — {{CLIENT_NAME}} — {{date}} ===

BLOCKING ISSUES: {{n}}
[ ] / [X] No unresolved {{PLACEHOLDER}} strings  | Found: {{file:line}}
[ ] / [X] No unresolved {{TO CONFIRM}} markers   | Found: {{file:line}}
[ ] / [X] _config.md fully populated             | Missing: {{field}}
[ ] / [X] Instantly MCP connected                | Status: {{...}}

WARNINGS: {{n}}
[ ] / [!] offer.md has named case study + number
[ ] / [!] icp.md has signals + DMs + filters + avoid list
[ ] / [!] voice.md has tone + banned words + spelling
[ ] / [!] campaign-state.md has infrastructure section

SOFT ISSUES: {{n}}
[ ] / [.] decision-log.md exists
[ ] / [.] SLA defined
[ ] / [.] Success criteria defined

VERDICT: {{READY / NOT READY}}
```

---

## VERDICT RULES

- **READY:** zero blocking issues. Warnings may exist but do not stop launch.
- **NOT READY:** any blocking issue present. Output the exact files and fields to fix.

If READY, update `company/_config.md`:
```
setup_complete: true
last_pre_launch_check: {{YYYY-MM-DD}}
```

---

## RULES

- **Never run silently.** Always output the full check result to Harry.
- **Be specific about failures.** "Missing in icp.md" is not enough. "icp.md line 23: '{{Geography}}' is unresolved."
- **Do not auto-fix.** Surfacing the issue is the job. The fix is Harry's call.
- **If invoked by another skill,** return a structured status the calling skill can act on:
  - `verdict: READY` → proceed
  - `verdict: NOT READY` → calling skill must STOP and instruct Harry to fix.
- **Log every run** to `company/decision-log.md` as a "Setup verification" entry if verdict changes (e.g. went from NOT READY to READY).

---

## EXAMPLES

### Example — pre-launch check during campaign launch

```
Harry: Run pre-launch check before launching the hiring campaign

Claude:
=== Pre-Launch Check — {{CLIENT_NAME}} — 2026-05-29 ===

BLOCKING ISSUES: 1
[X] No unresolved {{PLACEHOLDER}} strings  | Found: company/voice.md:14 "{{Tone}}"
[ ] No unresolved {{TO CONFIRM}} markers
[ ] _config.md fully populated
[ ] Instantly MCP connected

WARNINGS: 0

SOFT ISSUES: 1
[.] SLA not yet defined in company/overview.md

VERDICT: NOT READY

Fix needed:
- company/voice.md line 14: tone field still has placeholder. Run client-onboarder Phase 4 or fill manually.

After fix, re-run pre-launch check before launching the campaign.
```