# Scientific Method

How we iterate copy, sequences, signals, and any tested stimulus. **Every change to an active campaign should pass through this framework.** Without it, we are guessing — and guessing does not compound.

The principle, in one sentence: **define a hypothesis, hold every other variable constant, test it long enough to be real, then iterate one variable toward fitness.**

> **Why we test instead of copying "what's working":** see `wiki/first-principles-client-acquisition.md`
> Section 5 (Cyclical Stimulus Effectiveness) — any stimulus that's visibly working niche-wide is already
> partway through its decay curve.
>
> **Why sample size and latency rules exist:** see `wiki/acquisition-systems-theory.md` Section 8
> (Regression to the Mean) — small samples don't distribute evenly even when the underlying rate is fixed,
> which is exactly what makes early results misleading.
>
> **Why "genotype" and "fitness" are the right words for this:** this file's entire Step 1-4 process is
> the applied procedure for `wiki/darwinian-acquisition-theory.md` — that file explains the biological
> reasoning underneath every rule here (Ceteris Paribus, needle-movers, V-numbering) and adds techniques
> beyond single-variable iteration (splicing, cross-pollination, sharing wins across a network).

> Used by: `gtm-skills/test-launcher.md`, `gtm-skills/test-readiness-check.md`, `gtm-skills/weekly-reviewer.md`, `gtm-skills/campaign-optimiser.md`, `gtm-skills/cold-email-writer.md`. Test entries live in `clients/{slug}/test-log.md`.

---

## Quick Reference

| Step | What | Key output |
|------|------|-----------|
| 1 | Formulate Hypothesis | Genotype + KPIs + sample + constants + airtight check |
| 2 | Test Hypothesis | Run, **do nothing**, log daily |
| 3 | Observe Results | Verify data, work the 5-question tree |
| 4 | Iterate Hypothesis | Pick needle-mover, set modification level, build V(n+1) |

---

# Step 1 — Formulate Hypothesis

> Take a guess as to which variable genotype has fitness.

Think of a stimulus (a cold email, a Loom, a video pitch, a subject line) as a **genotype** made up of variables. Fitness = the stimulus producing the result we want (PRR, ABR, meeting booked).

### 1.1 Define the key variables

Ask: *what are the 2-4 key variables making up this stimulus?*

**Example — initial cold email:**
```
Content - Subject - CTA = Email
  V1       V1       V1     V1
```

**Example — initial video pitch:**
```
Content - CTA - Delivery = Initial Video
  V1       V1     V1          V1

Variable 1 (Content):  the actual pitch of the message
Variable 2 (CTA):      what action you're asking them to take
Variable 3 (Delivery): are you delivering enthusiastically? Seriously?
```

Pick 2-4 variables that actually drive performance for the stimulus type. Resist the urge to call ten things "variables" — most are constants in disguise.

### 1.2 Define metrics and KPIs

Identify the **primary** and **secondary** metrics that reflect the performance of this stimulus.

| Metric | Role | Example KPI |
|--------|------|-------------|
| **Primary — PRR (positive reply rate)** | Directly attributable to THIS stimulus | 1% target |
| **Secondary — ABR (appointment booking rate)** | Polaris — upstream of PRR, influenced by the whole sequence | 3.5% target |

**Rule:** if the secondary (ABR) is at or above KPI, do NOT look at the primary (PRR). ABR is downstream of the entire system — if Polaris is hitting, the system is working. Touch nothing.

### 1.3 Establish sample size

Decide how much data you will need before metrics become trustworthy enough to act on. Most operators send 15 cold messages, get emotional at no response, and change everything. **That is exactly the failure mode this step exists to prevent.**

Recommended minimum sample sizes:

| Stimulus | Minimum sample |
|----------|---------------|
| Cold email variant | 300 sends per variant |
| Loom video on cold email | 30 looms viewed (tracked + all follow-ups sent) |
| Video cold message | 30 videos viewed (tracked + all follow-ups sent) |
| Cold call decision-maker pitch | 30 pitches made (tracked + all follow-ups sent) |
| Subject line A/B | 200 sends per variant |
| LinkedIn DM | 100 messages |

Do not draw conclusions before sample size. Emotional reactions to early data are the enemy.

### 1.4 Establish latency and timeframe

Ask: *how long will I run this experiment, and how long will I wait for the system to produce results after sending stops?*

Every system has latency.

**Example — cold email:**
- Send 20 emails/day with simple follow-ups Mon-Fri
- Friday's follow-ups go Saturday
- Sunday is the latency window
- Total: ~1 week from first send to first verdict
- At least 30/100 people should engage; if it takes longer, so be it

**Latency rule:** for cold email, do NOT call results until 7 days after the FINAL send in the sequence. A reply that comes on day 5 of follow-up could rescue a "losing" verdict.

### 1.5 Make the test airtight

Ask: *what could go wrong during this experiment in a way that biases the outcome — and how do I prevent it?*

Common test integrity threats:

| Channel | What could break |
|---------|-----------------|
| Cold email | Deliverability — 30% landing in spam |
| Cold message | Videos failing to deliver 25% of the time |
| Ads | Form on funnel does not redirect to scheduler |
| Any channel | Tracking misattribution (human error) |
| Any channel | Constants drifting mid-test |

Run the airtight check BEFORE launching:
- [ ] Deliverability verified (warmup green, bounce baseline <2%)
- [ ] Tracking attribution correctly wired
- [ ] All variables under test cleanly differentiated in the platform
- [ ] All constants locked
- [ ] Stop conditions written down

If the test is compromised mid-run, restart. **Bad data is worse than no data.**

### 1.6 Create version variables

Label every variable clearly. First version is V1.

```
Content(V1) - CTA(V1) - Delivery(V1) = Initial Video V1
```

V-number notation is mandatory in `clients/{slug}/test-log.md`. Without it, you cannot reason about which version regressed or improved.

### 1.7 Establish the constants

A **constant** is a part of the system that affects performance but is held fixed during the test.

**Example — cold email constants:**
- Lead source (big one — change this and the test is invalid)
- ICP definition
- Sending domain / mailbox
- Send time of day
- Follow-up sequence structure
- Daily send volume
- All variables not under test

**Rule:** do not vary constants while a test is running. If a constant changes mid-test, you cannot attribute results to any specific variable. This is Ceteris Paribus — *all other things equal*. Without it, the test is noise.

See also `gtm-skills/cold-email-writer.md` and `gtm-skills/client-request-handler.md` — both will refuse to modify a constant of a running test without explicit override.

---

# Step 2 — Test Hypothesis

> Run the genotype in the environment. Does it produce fitness?

### 2.1 Run the test

Take the action. Send the messages. Add the leads to Instantly. Launch the campaign.

### 2.2 Do nothing

**While the test runs, do nothing.** Do not adjust the experiment. Do not change copy. Do not "tweak" the subject line because day 2 looks bad. Do not vary anything else.

Resist all emotional impulses, no matter how tantalising. **DO NOTHING but run the test.**

This is the hardest discipline in client acquisition. The OS enforces it: skills that touch active-test campaigns will refuse changes that touch constants unless explicitly overridden.

### 2.3 Log the data

Every day, log the metrics. Verify each data point. Make no judgements until the test is complete.

**Daily logging rule:** report on **yesterday's** results. If you log today at 3pm, 24 hours have not elapsed — that is not a real test data point. Log yesterday only.

Log goes into `clients/{slug}/test-log.md` under the active test's "Running data" section.

---

# Step 3 — Observe Results

A test is only complete when **ALL SIX** of the following are true. Before drawing any conclusion, verify each one.

| # | Rule |
|---|------|
| 1 | Data for the sample size has been collected and metrics are correctly attributed |
| 2 | Latency is accounted for |
| 3 | The test is airtight (nothing went seriously wrong) |
| 4 | All constants remained the same throughout |
| 5 | You changed NOTHING during the test |
| 6 | You logged data every day with 100% accuracy |

If any rule failed → the test is invalid. Restart with a clean version. Do not pretend partial data is conclusive.

### 3.1 Verify data

Before deciding, verify the data once more against the source (the Instantly API, tracking platform, spreadsheet).

### 3.2 Determine success — the 5-question tree

Work through these questions in order:

**Q1: What was the conversion rate for the primary (PRR) and secondary (ABR) metrics?**
Document both. Then:

**Q2: Were you above or just slightly below KPI for the SECONDARY metric (ABR)? By how much?**
- **Yes** → change nothing. **Scale.** Stop here. Polaris is hitting; the system works.
- **No** → go to Q3.

**Q3: Were you above or just slightly below KPI for the PRIMARY metric (PRR)? By how much?**
- **Yes** → the copy is working. Look DOWNSTREAM of PRR for what is dragging ABR (reply handling speed, follow-up sequence quality, calendar friction). Wait for downstream latency to play out before changing copy. Do not iterate the variable that is performing.
- **No** → go to Q4.

**Q4: Is the primary (PRR) way below KPI?**
- **Yes** → iterate the hypothesis (Step 4 below).
- **No, but close** → consider scaling cautiously. A 0.8% PRR against a 1% KPI is often good enough for scale.

**Q5 (the calibration question): Are you treating KPI as a hard rule or as a measuring stick?**

KPIs are measuring sticks for scale, not hard cutoffs. Poor metrics can still be scaled with volume.

> 1% ABR at 100 sends/day = 1 booked call/day = ~20 meetings/month. Even at a 10% close rate, that is 2 clients/month, or 12 in 6 months. Enough to clear $100k ARR.

Do not become emotionally or binarily attached to the KPI number. Move what is moveable; scale what is workable.

---

# Step 4 — Iterate Hypothesis

> Once you are certain the genotype has not produced fitness, iterate.

### 4.1 Re-define key variables

Go back to the original hypothesis. Write the variables out.

```
Content(V1) - CTA(V1) - Delivery(V1) = Initial Video V1
```

### 4.2 Pick the needle-mover variable

Out of the key variables, which ONE, if iterated positively, would have the biggest impact on fitness? Pick one. **You can only pick one.**

Use your knowledge of the stimulus and what data the test surfaced. Ask the community / Harry if delivery seems off vs content vs CTA. Do not guess in a vacuum.

**Example:** for the cold email genotype above, after observing the test, you decide Content is the needle-mover. Delivery and CTA are fine.

> The needle-mover will not always be the same variable in future tests. Re-evaluate each time.

**Priority order for cold email (from highest leverage to lowest):**
1. Offer (Part 3 of the formula)
2. ICP / targeting
3. Icebreaker / personalisation angle
4. CTA phrasing
5. Subject line

### 4.3 Recognise new constants

The variables NOT chosen as needle-mover become **constants** for this next test. Lock them.

This is the core discipline. If you test two variables at once, you cannot attribute the result to either. **Ceteris Paribus.**

### 4.4 Pick modification level

How heavily do you modify the needle-mover? Three levels, picked by how far from KPI the current version is.

| Modification level | Affinity to V(x) | When to pick (PRR vs 1% KPI) |
|--------------------|-----------------|-------------------------------|
| **Slight** | High — V(x+1) feels similar to V(x) | Close to KPI (e.g. 0.7% vs 1%) |
| **Moderate** | Some — same direction, different execution | Off (e.g. 0.4% vs 1%) |
| **Complete** | Zero — start from a blank page | Dead in the water (e.g. 0.1% vs 1%) |

**Rule of thumb:** the worse the result, the bigger the swing. A slight modification to a dead variant is wasted volume.

### 4.5 Modify needle-mover accordingly

Build V(n+1) of the needle-mover. Everything else stays at V1.

**Before:**
```
Content(V1) - CTA(V1) - Delivery(V1) = Initial Video V1
```

**After (Content is the needle-mover):**
```
Content(V2) - CTA(V1) - Delivery(V1) = Initial Video V2
```

Log the V-numbers in `clients/{slug}/test-log.md`.

### 4.6 Repeat Step 1

Run the new hypothesis through the same test cycle. Honour all 6 rules from Step 3 before drawing conclusions.

---

# Managing Future Experiments — The Feedback Loop

Every test should move you **closer to KPI**, not further away. After every completed test, ask:

**Does the latest version regress from KPI more than V(x-1)?**
- **Yes** → revert to V(x-1) and iterate in a different direction
- **No** → continue iterating in this direction

**Does the new hypothesis regress from KPI more than V(x-1)?**
- **Yes** → revert to V(x-1) and iterate in a different direction
- **No** → continue iterating in this direction

This is enforced by `gtm-skills/weekly-reviewer.md` — when a completed test shows regression, it explicitly recommends the revert and surfaces V(x-1) as the proposed next control.

### Why this matters

What this builds is a feedback loop between inputs and outputs. Every Hypothesis produces a new Hypothesis that feeds back into the system toward iterative fitness.

**This is the secret to client acquisition.** Lots of iteration, ruthless discipline, no shortcuts.

There is no magic copy variant. There is only the cycle: hypothesis → test → observe → iterate → hypothesis. Run it enough times and the copy gets to KPI. Skip steps and you guess forever.

---

# Common Failure Modes

| Failure | Symptom | Fix |
|---------|---------|-----|
| Testing too small | Concluding from <300 sends | Wait for sample size |
| Testing too short | Killing a variant on day 3 | Honour latency window |
| Testing multiple variables | Cannot attribute the result | One variable per test, always |
| Drifting constants | Lead source changed mid-test | Restart |
| Ignoring Polaris | PRR up but ABR flat — iterating PRR copy | Stop iterating copy. Fix downstream. |
| Emotional reaction to early data | Changing variant on day 2 | Do nothing until complete |
| Over-modifying when close | Complete rewrite when slight would do | Match modification level to distance from KPI |
| Under-modifying when dead | Slight tweak when result is 0.3% vs 3.5% | Complete rewrite. Slight modifications cannot rescue dead variants. |
| Not logging V-numbers | Cannot reason about regression | Mandatory V(n) notation in test-log |
| Not respecting "do nothing" | Adjusting copy mid-test | OS enforces this — skills refuse to modify active-test constants |

---

# Source Material

Synthesised from practitioner methodology (Refine Flow / Harry's iteration process). Cross-referenced with:
- `wiki/copywriting-101.md` — the canonical formula being iterated
- `wiki/email-benchmarks.md` — KPI reference points
- `clients/{slug}/test-log.md` — where each test is captured
- `gtm-skills/test-readiness-check.md` — the gate that enforces Step 1 completion