---
name: deliverability-doctor
description: Triages and diagnoses deliverability problems (bounce, blacklist, warmup, spam) before they kill a campaign, and runs recovery protocols. Hands infrastructure-level execution to the AM. Triage/diagnosis entry point - see incident-responder.md for confirmed-Critical situations.
triggers:
  - "My emails are going to spam"
  - "bounce rate is climbing"
  - "open rate dropped"
  - "domain is blacklisted"
  - "deliverability issue"
  - "DNS not working"
  - "warmup is failing"
  - "red flame in Instantly"
reads:
  - "wiki/_skill-context.md"
  - "wiki/deliverability.md, email-benchmarks.md"
  - "clients/{slug}/campaign-state.md"
writes:
  - "clients/{slug}/campaign-state.md (document infrastructure changes)"
---

# Skill: Deliverability Doctor

**Trigger:** "My emails are going to spam", "bounce rate is climbing", "open rate dropped", "domain is blacklisted", "deliverability issue", "DNS not working", "warmup is failing", "red flame in Instantly"

**Context:** Deliverability is upstream of every metric. If emails are not landing, nothing else matters. This skill diagnoses and recovers deliverability problems before they kill a campaign.

**vs. `gtm-skills/incident-responder.md`:** the two share overlapping triggers ("blacklisted," "bounce spike"). This skill is for triage and diagnosis - use it while severity is still being assessed, or once it's confirmed as High/Medium/Low. The moment a situation is already confirmed Critical (blacklist confirmed live, bounce already over 5%, platform-wide outage), go straight to `gtm-skills/incident-responder.md` instead - it owns severity-gated client notification and post-mortem, this skill doesn't.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `wiki/deliverability.md` - benchmarks, symptom-to-cause diagnosis, list verification, and what to flag the AM for
- `wiki/email-benchmarks.md` - what deliverability metrics should look like
- `clients/{slug}/campaign-state.md` - current infrastructure status

---

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

## TRIAGE - Run This First

Pull from the Instantly API for the active client (via `.claude/bin/instantly.sh` - see `sops/instantly-api.md`):
- Current bounce rate (last 7 days)
- Spam complaint rate
- Open rate trend (last 30 days vs prior 30)
- Raw reply rate trend (the one deliverability exception to PRR, see `wiki/deliverability.md`)
- Warmup status (red / amber / green per mailbox)

Ask Harry to paste if MCP unavailable.

### Severity assessment

| Severity | Trigger | Action |
|----------|--------|--------|
| **Critical** | Bounce over 5%, warmup disabled, blacklisted | Pause campaigns immediately. Recover before resuming. |
| **High** | Bounce 3-5%, complaint over 0.3%, open rate fell over 20% | Pause, run diagnostics, fix before next send. |
| **Medium** | Bounce 2-3%, complaint 0.1-0.3% | Investigate this week, monitor daily. |
| **Low** | All metrics within target, occasional bounce spike | Monitor, no action. |

---

## DIAGNOSIS DECISION TREE

### Step 1 - Is it infrastructure?

Check:
- DNS records: SPF, DKIM, DMARC (use mail-tester.com)
- Domain age and warmup status
- Custom tracking domain (CNAME pointing correctly)
- Blacklists (MXToolbox, MultiRBL)

If any fail → fix infrastructure first.

### Step 2 - Is it list quality?

Check:
- When was the list last verified?
- Bounce rate breakdown (which campaign / mailbox is bouncing?)
- Catch-all percentage
- Role-based addresses present

If list is older than 30 days → re-verify before any more sends.

### Step 3 - Is it volume / pacing?

Check:
- Sends per mailbox per day (over 50 = risk)
- Number of active campaigns per mailbox
- Warmup running alongside?

If pushing volume too hard → throttle to 30-40/day and reactivate warmup.

### Step 4 - Is it content?

Check:
- Plain text only? (HTML triggers spam filters)
- Links in body? (Should be zero in cold email)
- Spam trigger words in subject?
- Raw reply rate (over 5% protects deliverability)

---

## RECOVERY PROTOCOLS

Domain-level and platform-infrastructure fixes (blacklist removal, DNS-level changes, workspace/throttling
issues) are AM-owned, not GTME-owned (`sops/am-gtme-responsibility-split.md`). The protocols below are the
reference runbook for what needs to happen, diagnose and flag to the AM to execute rather than running them
solo by default. List-quality and volume/pacing fixes (Protocol B, and the volume-throttle step generally)
stay GTME's, they're campaign decisions, not infrastructure ones.

### Protocol A - Domain blacklisted

1. Identify which blacklist (MXToolbox shows all)
2. Flag the AM to submit the removal request per blacklist (execution is AM-owned, see
   `sops/am-gtme-responsibility-split.md`)
3. Pause campaigns from that domain
4. Run warmup only for 7 days minimum
5. Resume at 5-10 cold per mailbox per day
6. Build back up over 2-3 weeks

### Protocol B - Bounce rate over 5%

1. Pause all campaigns from affected mailboxes immediately
2. Re-verify remaining list with ZeroBounce or NeverBounce
3. Identify list source - flag for review or remove entirely
4. Pause new sends for 7 days, warmup only at 10-20/day
5. Resume slowly at 5-10 cold per mailbox per day
6. Monitor daily until back under 2% (the healthy target, `wiki/deliverability.md`)

### Protocol C - Warmup disabled (red flame in Instantly)

1. Run "Test domain setup" in Instantly - fix any red items
2. Verify SPF, DKIM, DMARC correctly configured
3. Check domain against blacklists
4. Click red flame → request reactivation code
5. Enter code → warmup re-enables
6. Run warmup-only for 7 days before resuming cold

### Protocol D - Open rate dropped sharply

1. Check sender reputation (Google Postmaster Tools, Microsoft SNDS)
2. Check subject lines for spam triggers
3. Check whether tracking pixel is causing issues (try disabling for a test batch)
4. A/B test plain text vs minimal HTML
5. Verify custom tracking domain is healthy

---

## RULES

- **Always check deliverability before touching copy.** Bad deliverability looks identical to bad copy.
- **Bounce rate first.** Over 5% = stop the campaign now, per the Critical row in the severity table above.
- **Plain text only.** Always. No HTML for cold outreach. Ever.
- **Never stop warmup.** 10-20/day per mailbox even during active campaigns.
- **Re-verify lists every 30 days.** Email decays 2.1% per month.
- **Document infrastructure changes** in `clients/{slug}/campaign-state.md` so future-Harry knows what changed.

---

## QA CHECKLIST

Before handing the diagnosis to Harry:

- [ ] Severity assessment matches the actual pulled data, not an assumption?
- [ ] Every recommended step is labelled GTME-owned or AM-owned (`sops/am-gtme-responsibility-split.md`)?
- [ ] If any step is AM-owned, it's framed as "flag to the AM," not "do this yourself"?
- [ ] Root cause (infrastructure / list quality / volume / content) is stated, not just symptoms?
- [ ] If severity is Critical, campaigns are paused before anything else is recommended?