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
  - "clients/{slug}/_config.md"
  - "clients/{slug}/*.md"
writes:
  - "clients/{slug}/_config.md (updates setup_complete flag)"
---

# Skill: Pre-Launch Check

**Trigger:** "Run pre-launch check", "Verify OS is ready", "Check setup status", "Is this client ready to launch"

**Context:** A gate. Validates the client OS is complete and consistent before letting campaigns launch. Other skills (cold-email-writer, campaign-launcher, weekly-reviewer) invoke this before producing client-facing output.

**Why this exists:** if the onboarder missed a placeholder, copy can go out with `Hey {{firstName}}, I'm Harry from {{CLIENT_NAME}}` in the body. This skill catches that.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end - captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt - no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## CHECKS PERFORMED

### Block-level (CRITICAL - fail = stop)

1. **No unresolved `{{PLACEHOLDER}}` strings** in:
   - `CLAUDE.md`
   - `clients/{slug}/_config.md`
   - `clients/{slug}/overview.md`
   - `clients/{slug}/icp.md`
   - `clients/{slug}/offer.md`
   - `clients/{slug}/voice.md`

2. **No unresolved `{{TO CONFIRM}}` markers** anywhere in `clients/{slug}/*.md`.

3. **`clients/{slug}/_config.md` has all required fields filled:**
   - `client_name`
   - `industry`
   - `primary_contact_name`
   - `primary_contact_email`
   - `instantly_workspace_url`
   - `template_version`

4. **Instantly API key configured** (`instantly_api_configured: true` in config; test: `.claude/bin/instantly.sh GET /campaigns`).

### Warn-level (HIGH - fail = warn, can override)

5. **`clients/{slug}/offer.md` has at least:**
   - One named case study with a specific number
   - At least 3 approved claims listed
   - Risk reversal / guarantee defined

6. **`clients/{slug}/icp.md` has at least:**
   - 1 priority signal defined
   - 2+ decision-maker titles
   - Lead filter criteria block populated
   - Avoid list with at least one entry

7. **`clients/{slug}/voice.md` has at least:**
   - Tone defined
   - Banned words list (even if empty, must be confirmed)
   - Spelling default explicitly set (UK / US)

8. **`clients/{slug}/campaign-state.md` has:**
   - At least one campaign or planning entry
   - Infrastructure section filled (domains, mailboxes, warmup status)

### Soft-level (LOW - informational)

9. `clients/{slug}/decision-log.md` exists (even if empty - should have header)
10. `clients/{slug}/comms-log.md` exists
11. `clients/{slug}/copy-library.md` exists
12. `clients/{slug}/test-log.md` exists
13. SLA defined in `clients/{slug}/overview.md`
14. Success criteria defined in `clients/{slug}/overview.md`

---

## OUTPUT FORMAT

```
=== Pre-Launch Check - {{CLIENT_NAME}} - {{date}} ===

BLOCKING ISSUES: {{n}}
[ ] / [X] No unresolved {{PLACEHOLDER}} strings  | Found: {{file:line}}
[ ] / [X] No unresolved {{TO CONFIRM}} markers   | Found: {{file:line}}
[ ] / [X] _config.md fully populated             | Missing: {{field}}
[ ] / [X] Instantly API configured               | Status: {{...}}

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

If READY, update `clients/{slug}/_config.md`:
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
- **Log every run** to `clients/{slug}/decision-log.md` as a "Setup verification" entry if verdict changes (e.g. went from NOT READY to READY).

---

## EXAMPLES

### Example - pre-launch check during campaign launch

```
Harry: Run pre-launch check before launching the hiring campaign

Claude:
=== Pre-Launch Check - {{CLIENT_NAME}} - 2026-05-29 ===

BLOCKING ISSUES: 1
[X] No unresolved {{PLACEHOLDER}} strings  | Found: clients/{slug}/voice.md:14 "{{Tone}}"
[ ] No unresolved {{TO CONFIRM}} markers
[ ] _config.md fully populated
[ ] Instantly API configured

WARNINGS: 0

SOFT ISSUES: 1
[.] SLA not yet defined in clients/{slug}/overview.md

VERDICT: NOT READY

Fix needed:
- clients/{slug}/voice.md line 14: tone field still has placeholder. Run client-onboarder Phase 4 or fill manually.

After fix, re-run pre-launch check before launching the campaign.
```