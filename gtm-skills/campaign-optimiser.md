# Skill: Campaign Optimiser

**Trigger:** "Diagnose this campaign", "optimise this campaign", "why is PRR low", "what should I test next", "campaign is underperforming"

**Context:** Diagnosing underperforming campaigns and recommending the highest-leverage fix. Always follow the scientific method — one variable at a time.

**Read before diagnosing — primary:**
- `company/campaign-state.md` — live campaign status and benchmarks
- `company/icp.md` — ICP and signal accuracy check
- `company/offer.md` — offer and proof point check
- `wiki/scientific-method.md` — test methodology
- `wiki/copywriting-101.md` — copy hard rules and formula
- `company/copy-library.md` — winning variants and graveyard
- `company/test-log.md` — what has already been tested

**Read before diagnosing — extended:**
- `wiki/email-benchmarks.md` — symptom-to-cause diagnostic table and benchmark calibration
- `wiki/deliverability.md` — for any bounce / open rate / spam issues
- `wiki/copywriting-frameworks.md` — alternative frameworks if the default formula has plateaued
- `wiki/signal-sourcing.md` — for signal freshness and list quality issues

**Skills to invoke if needed:**
- `gtm-skills/deliverability-doctor.md` — if the root cause is infrastructure
- `gtm-skills/list-builder.md` — if the root cause is list quality
- `gtm-skills/signal-sourcer.md` — if the root cause is signal saturation

---

## BEFORE YOU DIAGNOSE

Pull from Instantly MCP:
- Campaign sends, reply rate, PRR, bounce rate (last 30 days)
- Per-step breakdown: which email step is generating replies
- Subject line performance breakdown

Ask Harry to paste metrics if Instantly MCP is unavailable.

Cross-check against `wiki/email-benchmarks.md` to set expectations before diagnosing.

---

## DIAGNOSIS FRAMEWORK

Work through these in order. Stop at the first confirmed root cause and recommend a fix before moving on.

### 1. Deliverability check (always first)

- Bounce rate over 4%? → Route to `gtm-skills/deliverability-doctor.md`. Fix before touching copy.
- Are emails landing in spam? Check sending domain health, SPF/DKIM/DMARC.
- Are mailboxes properly warmed? Minimum 20 days warmup before any campaign.

**If deliverability is broken, stop here. Fix it first.**

### 2. List quality check

- Are leads matching the ICP in `company/icp.md`?
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
- Does it use proof points from `company/offer.md`?
- Does the value prop match the decision-maker role (check `company/icp.md` and `wiki/atl-btl-messaging.md`)?

### 5. Copy check

- Is every email under 100 words?
- Is Part 1 genuinely relevant to the signal — or generic?
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
- Does the personalisation feel relevant — or sweeping?

---

## QUICK DIAGNOSTICS — Symptom to Cause

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
**Fix:** {{One specific change — one variable}}
**Expected impact:** {{What PRR improvement you expect and why}}
**Test approach:** {{How to isolate this variable and measure it cleanly}}

---

## WHAT TO TEST NEXT

If the campaign is not in crisis (PRR above 0.5%), recommend the next split test.

Priority order (from `wiki/scientific-method.md`):
1. Offer (Part 3 of formula)
2. ICP / targeting
3. Icebreaker / personalisation angle
4. CTA phrasing
5. Subject line

Check `company/test-log.md` before recommending — do not re-test what has already been learned.

If the default formula has plateaued: recommend switching to a named framework from `wiki/copywriting-frameworks.md` (Do the Math, Pattern Interrupt, Upfront Value).

---

## OPTIMISER RULES

- Never recommend changing more than one variable at a time.
- Minimum 300 sends before drawing any conclusion.
- Bounce rate is always the first check — deliverability beats copy.
- If PRR is above 1.5%, do not change copy. Scale instead.
- If PRR is close to KPI (within 1%), consider scaling rather than iterating.
- Log every test result in `company/test-log.md` after completion.
---

## ACTIVE-TEST STRICT BLOCK (added in v1.2.0)

Before making any change to a campaign or its sequence, **read `company/campaign-state.md`** and check whether the campaign has a `TEST ACTIVE` flag.

If `TEST ACTIVE — T-{{ID}} testing {{variable}}. Constants LOCKED.` is present:

1. **Read `company/test-log.md` → T-{{ID}} → Section 1.7 Constants list**
2. **Compare the requested change to the locked constants:**
   - If the change touches a constant (lead source, ICP, sending domain, mailbox, send time, follow-up sequence, daily volume, any non-needle-mover variable with locked V-number) → **REFUSE**.
   - If the change touches the needle-mover variable being tested → **REFUSE** (modifying it mid-test invalidates the test).
   - If the change is genuinely orthogonal (a different campaign, a different stimulus type entirely) → proceed normally.

3. **Refusal output format:**
```
⚠️ STRICT BLOCK — Active test T-{{ID}} on this campaign

The requested change touches: {{constant_name OR variable_under_test}}
Locked since: {{launch_date}}
Reason: modifying this would invalidate test T-{{ID}}.

Options:
(A) Wait for test completion ({{estimated_date}})
(B) Pause and invalidate the test deliberately (requires explicit override)

To override and proceed anyway, respond: "Override active test T-{{ID}}"
This will:
- Mark T-{{ID}} as INVALID in test-log.md
- Log the override + reasoning to decision-log.md
- Surface a warning in the next weekly review
- Allow the requested change to proceed
```

4. **If Harry overrides:**
   - Move the test from Running to Reverted in `company/test-log.md` with reason "manually invalidated mid-test by override"
   - Log the override to `company/decision-log.md` with context (why the change couldn't wait)
   - Remove the `TEST ACTIVE` flag from `company/campaign-state.md`
   - Then proceed with the requested change

**Why this matters:** the scientific method only works if Ceteris Paribus is enforced — all other things equal during the test. The OS is the enforcer. Without this gate, mid-test changes silently invalidate data and the iteration loop stops compounding.