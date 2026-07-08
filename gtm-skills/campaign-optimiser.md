---
name: campaign-optimiser
description: Diagnoses underperforming campaigns via an 8-check decision tree (deliverability, list quality, signal, offer, copy, sequence, personalisation, volume/pacing), stopping at the first confirmed root cause, then routes to the right specialist skill or recommends the next split test.
triggers:
  - "Diagnose this campaign"
  - "optimise this campaign"
  - "why is PRR low"
  - "what should I test next"
  - "campaign is underperforming"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/campaign-state.md, icp.md, offer.md, copy-library.md, test-log.md"
  - "wiki/scientific-method.md, copywriting-101.md, email-benchmarks.md"
writes:
  - "clients/{slug}/test-log.md (logged test result after completion)"
---

# Skill: Campaign Optimiser

**Trigger:** "Diagnose this campaign", "optimise this campaign", "why is PRR low", "what should I test next", "campaign is underperforming"

**Context:** Diagnosing underperforming campaigns and recommending the highest-leverage fix. Always follow the scientific method - one variable at a time.

If the problem spans more than one campaign or looks like a whole-motion stall rather than a single
underperforming sequence, use `wiki/acquisition-systems-theory.md` Section 5 (bottleneck identification via
sub-conversion rates) to find which sub-system is actually broken before running the single-campaign
funnel below.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `clients/{slug}/campaign-state.md` - live campaign status and benchmarks
- `clients/{slug}/icp.md` - ICP and signal accuracy check
- `clients/{slug}/offer.md` - offer and proof point check
- `wiki/scientific-method.md` - test methodology
- `wiki/copywriting-101.md` - copy hard rules and formula
- `clients/{slug}/copy-library.md` - winning variants and graveyard
- `clients/{slug}/test-log.md` - what has already been tested

**REFERENCE (consult when needed):**
- `wiki/email-benchmarks.md` - symptom-to-cause diagnostic table and benchmark calibration
- `sops/campaign-performance-standards.md` - the authoritative PRR tiers, and the escalation path at 1,000+ sends per positive reply
- `sops/solving-campaign-issues.md` - the tactical fix playbook once a root cause is found below (low-risk CTA plays, deliverability recovery, ICP-miss recovery including the lookalike play)
- `wiki/deliverability.md` - for any bounce / open rate / spam issues
- `wiki/copywriting-frameworks.md` - alternative frameworks if the default formula has plateaued
- `wiki/signal-sourcing.md` - for signal freshness and list quality issues

**Skills to invoke if needed:**
- `gtm-skills/deliverability-doctor.md` - if the root cause is infrastructure. This is the "technical
  fault, loop in the AM" branch of `sops/am-gtme-responsibility-split.md`: GTME still owns the diagnosis,
  the AM owns the infrastructure-level fix once diagnosed.
- `gtm-skills/list-builder.md` - if the root cause is list quality
- `gtm-skills/signal-sourcer.md` - if the root cause is signal saturation

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

## BEFORE YOU DIAGNOSE

Pull from the Instantly API for the active client (via `.claude/bin/instantly.sh` - see `sops/instantly-api.md`):
- Campaign sends, PRR, bounce rate (last 30 days)
- Per-step breakdown: which email step is generating replies
- Subject line performance breakdown

Ask the GTME to paste metrics if the Instantly API can't be reached (missing/invalid key).

Cross-check against `wiki/email-benchmarks.md` to set expectations before diagnosing.

---

## DIAGNOSIS FRAMEWORK

Work through these in order. Stop at the first confirmed root cause and recommend a fix before moving on.

### 1. Deliverability check (always first)

- Bounce rate over 5%? → Route to `gtm-skills/deliverability-doctor.md`. Fix before touching copy.
- Are emails landing in spam? Check sending domain health, SPF/DKIM/DMARC.
- Are mailboxes properly warmed? Minimum 20 days warmup before any campaign.

**If deliverability is broken, stop here. Fix it first.**

### 2. List quality check

- Are leads matching the ICP in `clients/{slug}/icp.md`?
- Is the signal still firing correctly?
- What percentage of leads are hitting the target titles?
- Are there false positives in the signal?

If list quality is the root cause → route to `gtm-skills/list-builder.md`.

### 3. Signal check

- Is the signal still fresh (see freshness rules in `wiki/signal-sourcing.md`)?
- Is the signal saturated (every competitor targeting it)?
- Has the signal been over-leveraged on the same TAM?

If signal is the root cause → route to `gtm-skills/signal-sourcer.md` to identify alternatives.

### 4. Offer check

- Is Part 3 of the formula specific enough? (Outcome + timeframe + risk reversal)
- Is the offer differentiated? Would they get this pitch from 10 other senders?
- Does it use proof points from `clients/{slug}/offer.md`?
- Does the value prop match the decision-maker role (check `clients/{slug}/icp.md` and `wiki/atl-btl-messaging.md`)?

### 5. Copy check

- Is every email under 100 words?
- Is Part 1 genuinely relevant to the signal - or generic?
- Does Part 2 use "I" and a specific number?
- Is the CTA one binary yes/no question?
- Does it pass the bar test?
- Are there question marks outside the CTA?
- Is the register right (ATL for VPs, BTL for ICs)? See `wiki/atl-btl-messaging.md`.

### 6. Sequence check

- Are all 3 value props represented across the sequence?
- Does each follow-up test a different cognitive mechanism?
- Is Email 3 on a new thread (not threaded to Email 2)?
- If Email 2/3 outperforms Email 1, the Email 1 offer needs work.

### 7. Personalisation check (if applicable)

- Is the personalisation the right tier for the volume / deal size?
- Is the AI-generated component fitting grammatically into the static template?
- Does the personalisation feel relevant - or sweeping?

### 8. Volume / pacing check

- Sends per mailbox per day - over 50 is risk territory, see `wiki/email-benchmarks.md` Volume Benchmarks
  (30-50/day recommended, 50-100 max).
- Is the active lead list large enough to sustain the current send rate without exhausting it mid-sequence?
- Was warmup turned off or throttled down too early relative to sending volume?
- Is the campaign pushing volume faster than the list or the mailbox reputation can support, independent
  of copy or targeting quality?

If pacing is the root cause, this is a campaign-config decision, not an infrastructure fix or a list-quality
issue - recommend the specific volume/throttle change directly rather than routing to
`gtm-skills/deliverability-doctor.md` or `gtm-skills/list-builder.md`.

---

## QUICK DIAGNOSTICS - Symptom to Cause

From `wiki/email-benchmarks.md`:

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Low opens (under 30%) | Subject line or deliverability | A/B test subjects, check spam score |
| Opens but no replies | Message relevance | More personalisation, shorter copy |
| Replies but no meetings | Weak CTA or poor qualification | Clearer ask, better targeting |
| High unsubscribe | Too aggressive or wrong ICP | Reduce frequency, refine targeting |
| Bounce climbing | List quality or domain reputation | Re-verify list, check blacklists |
| PRR declining over time | List fatigue or burned signal | Refresh ICP, change signal type |

---

## DIAGNOSIS OUTPUT FORMAT

State the root cause, confidence level, and recommended fix:

**Root cause:** {{What is actually wrong}}
**Confidence:** High / Medium / Low
**Evidence:** {{Specific data point or observation that confirms this}}
**Fix:** {{One specific change - one variable}}
**Expected impact:** {{What PRR improvement you expect and why}}
**Test approach:** {{How to isolate this variable and measure it cleanly}}

---

## WHAT TO TEST NEXT

If the campaign is not in crisis (PRR above 0.2%, per `sops/campaign-performance-standards.md`), recommend the next split test.

Priority order (from `wiki/scientific-method.md`):
1. Offer (Part 3 of formula)
2. ICP / targeting
3. Icebreaker / personalisation angle
4. CTA phrasing
5. Subject line

Check `clients/{slug}/test-log.md` before recommending - do not re-test what has already been learned.

If the default formula has plateaued: recommend switching to a named framework from `wiki/copywriting-frameworks.md` (Do the Math, Pattern Interrupt, Upfront Value).

---

## OPTIMISER RULES

- Never recommend changing more than one variable at a time.
- Minimum 300 sends before drawing any conclusion.
- Bounce rate is always the first check - deliverability beats copy.
- If PRR is above 1%, do not change copy. Scale instead.
- If PRR is close to KPI (within 0.3 points, e.g. 0.7-0.9%), consider scaling rather than iterating.
- If sends per positive reply is at or above 1,000 (PRR under 0.1%), escalate immediately per `sops/campaign-performance-standards.md` rather than continuing to iterate solo.
- Log every test result in `clients/{slug}/test-log.md` after completion.

---

## ACTIVE-TEST ENFORCEMENT

Before modifying a campaign or its sequence, check `clients/{slug}/campaign-state.md` for a `TEST ACTIVE` flag and apply the rules in `wiki/_active-test-rules.md`. Refuse changes that touch test constants without an explicit override.