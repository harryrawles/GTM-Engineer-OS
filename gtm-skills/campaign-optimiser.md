# Skill: Campaign Optimiser

**Trigger:** "Diagnose this campaign", "optimise this campaign", "why is PRR low", "what should I test next", "campaign is underperforming"

**Context:** Diagnosing underperforming campaigns and recommending the highest-leverage fix. Always follow the scientific method — one variable at a time.

**Read before diagnosing:**
- `company/campaign-state.md` — live campaign status and benchmarks
- `company/icp.md` — ICP and signal accuracy check
- `company/offer.md` — offer and proof point check
- `wiki/scientific-method.md` — test methodology
- `wiki/copywriting-101.md` — copy hard rules and formula
- `wiki/copy-library.md` — winning variants and graveyard
- `wiki/test-log.md` — what has already been tested

---

## BEFORE YOU DIAGNOSE

Pull from Instantly MCP:
- Campaign sends, reply rate, PRR, bounce rate (last 30 days)
- Per-step breakdown: which email step is generating replies
- Subject line performance breakdown

Ask Harry to paste metrics if Instantly MCP is unavailable.

---

## DIAGNOSIS FRAMEWORK

Work through these in order. Stop at the first confirmed root cause and recommend a fix before moving on.

### 1. Deliverability check (always first)

- Bounce rate over 4%? Deliverability issue — fix before touching copy.
- Are emails landing in spam? Check sending domain health, SPF/DKIM/DMARC.
- Are mailboxes properly warmed? Minimum 20 days warmup before any campaign.

**If deliverability is broken, stop here. Fix it first.**

### 2. List quality check

- Are leads matching the ICP in company/icp.md?
- Is the signal still firing correctly? (Trigify / lead source)
- What percentage of leads are hitting the target titles?
- Are there false positives in the signal — companies being flagged who should not be?

### 3. Offer check

- Is Part 3 of the formula specific enough? (Outcome + timeframe + risk reversal)
- Is the offer differentiated? Would they get this pitch from 10 other senders?
- Does it use proof points from company/offer.md?
- Is the value prop matching the decision-maker role (see company/icp.md)?

### 4. Copy check

- Is every email under 100 words?
- Is Part 1 genuinely relevant to the signal — or generic?
- Does Part 2 use "I" and a specific number?
- Is the CTA one binary yes/no question?
- Does it pass the bar test?
- Are there question marks outside the CTA?

### 5. Sequence check

- Are all 3 value props represented across the sequence?
- Does each follow-up test a different cognitive mechanism?
- Is Email 3 on a new thread (not threaded to Email 2)?

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

If the campaign is not in crisis (PRR above 0.5%), recommend the next split test:

Priority order (from wiki/scientific-method.md):
1. Offer (Part 3 of formula)
2. ICP / targeting
3. Icebreaker / personalisation angle
4. CTA phrasing
5. Subject line

Check wiki/test-log.md before recommending — do not re-test what has already been learned.

---

## OPTIMISER RULES

- Never recommend changing more than one variable at a time.
- Minimum 300 sends before drawing any conclusion.
- Bounce rate is always the first check — deliverability beats copy.
- If PRR is above 1.5%, do not change copy. Scale instead.
- If PRR is close to KPI (within 1%), consider scaling rather than iterating.
- Log every test result in wiki/test-log.md after completion.