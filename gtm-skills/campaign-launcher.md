---
name: campaign-launcher
description: Pre-flight launch checklist for new campaigns. Validates copy, sequence loaded correctly, infrastructure ready, lead list verified, tracking working, stop conditions defined. Blocks launch if any item fails. Logs successful launches to decision-log.
triggers:
  - "Launch the {{campaign}}"
  - "Run pre-flight check"
  - "Ready to launch {{campaign}}"
  - "Final check before going live"
reads:
  - "wiki/_skill-context.md"
  - "company/campaign-state.md"
  - "gtm-skills/pre-launch-check.md"
writes:
  - "company/campaign-state.md (marks campaign Active)"
  - "company/decision-log.md (logs launch decision)"
---

# Skill: Campaign Launcher

**Trigger:** "Launch the [campaign]", "Run pre-flight check", "Ready to launch", "Final check before going live"

**Context:** A gate. Verifies every piece is ready before a campaign turns on. Blocks launch on any blocker. Logs the launch to the decision log so future-Claude knows when and why.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

- `company/campaign-state.md` — current infrastructure
- `gtm-skills/pre-launch-check.md` — placeholder validation (invoked as sub-step)

---

## PRE-FLIGHT CHECKLIST

Run every item. Each must pass before launch.

### 1. OS Setup Validation

**Invoke `gtm-skills/pre-launch-check.md`.**
- Verdict must be `READY` (no blocking issues)
- All `{{PLACEHOLDER}}` resolved
- `company/_config.md` complete

**If FAIL:** stop. Output the pre-launch-check error report. Do not proceed.

### 2. Copy Approved by Client

- [ ] Client has reviewed Email 1, 2, 3 (and 4 if applicable)
- [ ] Approval logged with: who approved, when, link to approval (email / Slack / Notion)
- [ ] Copy stored in `company/campaign-state.md` under the campaign's "Sequence" table
- [ ] No `[TBD]` or open questions remain in the copy

**Ask Harry:** paste the approval link or confirmation message.

### 3. Sequence Configuration in Instantly

- [ ] Sequence loaded in Instantly with correct step timing (Day 0, 3, 7, etc.)
- [ ] Subject lines match approved copy exactly
- [ ] Body text matches approved copy exactly (verify via Instantly preview)
- [ ] Threading correct (Email 2 threaded, Email 3 new thread, etc.)
- [ ] Liquid syntax / spintax variables tested (send a test email and verify rendering)
- [ ] Plain text mode confirmed (no HTML formatting in body)
- [ ] No links in Email 1 body (allowed in Email 3+ if needed)

**Action:** request a test send to Harry's own email. Verify rendering before approving.

### 4. Sending Infrastructure

From `company/campaign-state.md` and Instantly MCP:
- [ ] Sending domains assigned to campaign
- [ ] Mailboxes warmed (warmup status green per mailbox)
- [ ] Send volume per mailbox <50/day
- [ ] Custom tracking domain configured per sending domain
- [ ] SPF / DKIM / DMARC verified (run `gtm-skills/deliverability-doctor.md` if unsure)

### 5. Lead List

- [ ] Lead list verified within last 30 days (run `gtm-skills/list-builder.md` if older)
- [ ] Bounce rate baseline < 2% (from verification report)
- [ ] List size appropriate for sequence capacity (sends/mailbox/day × duration)
- [ ] No duplicates against prior campaigns or suppression list
- [ ] ICP-fit check: spot-check 5 random leads — do they match `company/icp.md`?

### 6. Send Schedule

- [ ] Send times match recipient timezone (US clients: 9-11am EST or 1-3pm EST; UK clients: 9-11am GMT)
- [ ] Random delays configured (30-120 seconds between sends)
- [ ] Day-of-week appropriate (avoid Mondays for B2B, never weekends)
- [ ] Daily send rate within mailbox limits

### 7. Reply Handling Setup

- [ ] Reply alerts routed correctly (Slack, email, or Instantly inbox)
- [ ] Harry knows where to find replies (Instantly Unibox vs forwarded inbox)
- [ ] `gtm-skills/reply-handler.md` familiar and ready to invoke
- [ ] Calendar link / booking flow tested

### 8. Tracking and Reporting

- [ ] Instantly MCP can pull campaign data (test query: list this campaign)
- [ ] Custom tracking domain working (CNAME verified)
- [ ] Reply categorisation enabled in Instantly (positive / negative / OOO)

### 9. Stop Conditions

Define BEFORE launch — not in the heat of the moment.

- [ ] Bounce rate threshold: stop if > {{X}}% (default: 4%)
- [ ] PRR floor: stop if < {{X}}% after {{n}} sends (default: 0.3% after 500 sends)
- [ ] Spam complaint threshold: stop if > 0.3%
- [ ] Negative reply threshold: pause if > 20% of replies (audit copy)
- [ ] Other client-specific conditions: {{list}}

Write these explicitly into `company/campaign-state.md` under the campaign entry.

### 10. Communication and Sign-off

- [ ] Client notified of go-live date and what to expect (use client-report-writer template)
- [ ] First-week metric expectations communicated
- [ ] Harry confirms launch readiness explicitly

---

## VERDICT

After all checks:

```
=== Campaign Launch Check — {{campaign_name}} — {{date}} ===

PASS / FAIL — by category:

1. OS Setup Validation        | PASS / FAIL
2. Copy Approval              | PASS / FAIL
3. Sequence Configuration     | PASS / FAIL
4. Sending Infrastructure     | PASS / FAIL
5. Lead List                  | PASS / FAIL
6. Send Schedule              | PASS / FAIL
7. Reply Handling             | PASS / FAIL
8. Tracking and Reporting     | PASS / FAIL
9. Stop Conditions            | PASS / FAIL (defined)
10. Communication             | PASS / FAIL

OVERALL: READY TO LAUNCH / NOT READY

If NOT READY:
- [list of failed items with specific fixes needed]

If READY:
- Click launch in Instantly
- I'll log to company/decision-log.md and update campaign-state.md
```

---

## ON LAUNCH (after Harry clicks)

1. Update `company/campaign-state.md`:
   - Set status to "Active"
   - Set launch date
   - Set initial health to "Green (new — monitoring)"

2. Write to `company/decision-log.md`:
```
### {{date}} — Launched campaign: {{campaign_name}}

**Context:**
- Signal: {{signal}}
- Target ICP slice: {{description}}
- Sequence: {{n}}-step
- List size: {{n}} leads
- Stop conditions: {{summary}}

**Decision:**
Launched after pre-flight check (all 10 categories passed).

**Why:**
- {{Why this specific signal / ICP / offer combination was chosen}}
- {{Reference any prior winners from copy-library that informed the choice}}

**Approved by:** client on {{date}}
**Expected outcome:** PRR target {{X}}%, meetings target {{n}}/week

**Outcome (to update):**
{{Filled in after 30 days}}
```

3. Schedule first checkpoint: 48 hours post-launch — quick sanity check on opens, bounces, complaints.

4. Inform Harry: "Campaign live. First checkpoint in 48 hours. Weekly review will pick it up Friday."

---

## RULES

- **No launch without pre-launch-check verdict = READY.**
- **No launch without explicit client approval.** Verbal in a call is not enough — must be written (email, Slack, Notion comment).
- **Stop conditions are mandatory.** A campaign without explicit stop conditions is a campaign that drifts into harm.
- **Block, do not workaround.** If something fails, fix it. Do not "ship anyway and fix later" — cold email has no take-backs.
- **Log every launch.** Even if Harry remembers, future-Claude does not.

---

## EXAMPLES

### Example — failed launch (placeholder remaining)

```
Harry: Launch the hiring campaign for Recruitcha

Claude:
Running pre-flight check...

=== Campaign Launch Check — Recruitcha Hiring v1 — 2026-05-29 ===

1. OS Setup Validation        | FAIL — company/voice.md line 22 has unresolved {{Tone}}
2. Copy Approval              | PASS
3. Sequence Configuration     | PASS
4. Sending Infrastructure     | PASS
5. Lead List                  | WARN — list verified 31 days ago (just over 30-day limit)
6. Send Schedule              | PASS
7. Reply Handling             | PASS
8. Tracking and Reporting     | PASS
9. Stop Conditions            | FAIL — not defined yet
10. Communication             | PASS

OVERALL: NOT READY

Fix needed:
1. Resolve {{Tone}} in company/voice.md (run client-onboarder Phase 4)
2. Define stop conditions for this campaign in company/campaign-state.md
3. Recommend: re-verify lead list (just over 30 day threshold)

After fixes, re-run "Launch the hiring campaign" and I'll re-check.
```