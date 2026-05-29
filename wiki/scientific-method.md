# Scientific Method

Framework for running split tests on any outbound stimulus (cold email, LinkedIn, subject lines, CTAs). Never change more than one variable at a time.

**PRR (positive reply rate) is the primary KPI for cold email copy.**

---

## Overview

| Step | Action |
|------|--------|
| 1 | Formulate hypothesis |
| 2 | Test hypothesis |
| 3 | Observe results |
| 4 | Iterate hypothesis |

---

## Step 1: Formulate Hypothesis

### 1.1 Define key variables

Identify 2-4 key variables making up the stimulus. Example for a cold email:

- Variable 1: Content (the actual pitch)
- Variable 2: Subject line
- Variable 3: CTA

Genotype: Content(V1) - Subject(V1) - CTA(V1) = Email V1

### 1.2 Define metrics and KPIs

- **Primary metric: PRR** — directly attributable to the stimulus
- **Secondary metric: ABR (appointment booking rate)** — influenced by the full sequence

Example KPIs: Primary (PRR) 5% / Secondary (ABR) 3.5%

If secondary (ABR) is at KPI, don't look at primary (PRR). ABR is downstream and accounts for more latency.

### 1.3 Establish sample size

Minimum sends before drawing conclusions:

| Channel | Minimum sample |
|---------|---------------|
| Cold email variant | 300 sends |
| Loom video | 30 views (fully tracked) |
| LinkedIn message | 30 views (fully tracked) |

Do not change anything before hitting sample size. Emotional reactions to early data are the enemy.

### 1.4 Establish latency and timeframe

Decide how long you will run the experiment and how much delay you will give the system to produce results. All systems have latency — do not judge results on the final day of testing.

Example: cold email test is not complete until all follow-ups in the sequence have been sent to every contact. Account for at least 1 week of post-send latency before calling results.

### 1.5 Make the test airtight

List what could go wrong and eliminate it before launching:

- Deliverability issue (emails landing in spam)
- Form / redirect broken
- Tracking not attributed correctly
- Constants not held constant

If the test is compromised mid-run, restart. Bad data is worse than no data.

### 1.6 Create version variables

Label every variable clearly. First version of each is V1.

Example: Content(V1) - Subject(V1) - CTA(V1) = Email V1

### 1.7 Establish constants

Constants are parts of the system that affect performance but are held fixed during the test.

Examples for cold email: lead source, ICP, sending domain/mailbox, time of day, follow-up sequence, send volume per day.

Do not vary constants while a test is running. If you do, you cannot attribute results to any specific variable.

---

## Step 2: Test Hypothesis

### 2.1 Run the test

Take the actions to launch. Send the emails, add the leads.

### 2.2 Do nothing

While running the test, do nothing. Do not adjust the experiment, change copy, or make any modifications. Resist all impulses to act, no matter how tempting. DO NOTHING.

### 2.3 Log the data

Log metrics every day, reporting on YESTERDAY's results (not today's — 24 hours must have elapsed). Use a spreadsheet. Verify every data point. Make no judgements until the test is complete.

---

## Step 3: Observe Results

A test is only complete when ALL of the following are true:

1. Data for the sample size has been collected and metrics are attributed to their source
2. Latency is accounted for
3. The test is airtight — nothing went seriously wrong
4. All constants remained the same throughout
5. You changed nothing during the test
6. You logged data every day with 100% accuracy

### 3.1 Verify data

Before making any decisions, verify the data again against the source.

### 3.2 Determine success

Work through these questions in order:

**Q1: Were you at or above KPI for the secondary metric (ABR)?**
- Yes → change nothing, scale
- No → go to Q2

**Q2: Were you at or above KPI for the primary metric (PRR)?**
- Yes → the copy is working. Look at what else affects ABR (reply handling speed, follow-up sequence, calendly). Wait for downstream latency before changing copy.
- No → go to Q3

**Q3: Is the primary metric (PRR) way below KPI?**
- Yes → iterate the hypothesis (Step 4)
- No but close → consider scaling cautiously. A 2.7% PRR against a 3.5% KPI is often good enough

Note: KPIs are measuring sticks, not binary rules. Poor metrics can still be scaled with volume. 1% ABR at 100 sends/day = 1 booked call/day = 20 meetings/month.

---

## Step 4: Iterate Hypothesis

### 4.1 Re-define key variables

Return to the original hypothesis and re-note the key variables:
Content(V1) - Subject(V1) - CTA(V1) = Email V1

### 4.2 Pick the needle-mover variable

Which single variable, if improved, would have the biggest impact on PRR? Pick one. You can only pick one.

Priority order for cold email (from highest impact to lowest):
1. Offer (Part 3 of formula)
2. ICP / targeting
3. Icebreaker / personalisation angle
4. CTA phrasing
5. Subject line

### 4.3 Recognise new constants

The variables NOT chosen as the needle-mover become constants for this next test. Do not touch them.

### 4.4 Pick modification level

| Distance from KPI | Modification level |
|-------------------|--------------------|
| Close (e.g. 2.3% vs 3.5% KPI) | Slight — next version has affinity to existing |
| Off (e.g. 1.3% vs 3.5% KPI) | Moderate — some affinity to existing |
| Dead (e.g. 0.3% vs 3.5% KPI) | Complete — no affinity to existing, start fresh |

### 4.5 Modify needle-mover

Create V2 of the needle-mover variable only.

Before: Content(V1) - Subject(V1) - CTA(V1) = Email V1
After:  Content(V2) - Subject(V1) - CTA(V1) = Email V2

### 4.6 Repeat Step 1

Run the new hypothesis through the same test. Follow all 6 rules before drawing conclusions.

---

## Managing Future Experiments

After every test, ask:

- Does the latest version regress from KPI more than the previous version?
  - Yes → revert to previous version and iterate in a different direction
  - No → continue iterating in this direction

Goal: a feedback loop between inputs and outputs that moves closer to KPI with each iteration. This is the core engine of scalable outbound.