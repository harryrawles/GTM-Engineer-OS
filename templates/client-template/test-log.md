# Test Log - {{CLIENT_NAME}}

Record of every split test for this client. Every test must follow the scientific method (see `wiki/scientific-method.md`). Every entry must capture all Step 1 sub-steps explicitly - `gtm-skills/test-readiness-check.md` enforces this before any test launches.

**V-number notation is mandatory.** Without it, regression checks in weekly-reviewer cannot run.

---

## How to Read This File

Tests progress through four statuses:

| Status | Meaning |
|--------|---------|
| **Queued** | Designed but not launched. Pre-launch verification not yet passed. |
| **Running** | Live in Instantly. Constants locked. Do not modify anything. |
| **Complete** | Hit sample size + latency. Result determined. |
| **Reverted** | Result regressed from V(x-1). Backtracked. |

---

## Currently Running

For each running test, the **full Step 1 block** is mandatory.

### Test {{T-XXX}} - {{Short description}}

**Status:** Running
**Launched:** {{YYYY-MM-DD}}
**Expected completion:** {{YYYY-MM-DD}}

#### Step 1 - Hypothesis

**1.1 Genotype (variables of this stimulus):**
```
{{Variable_1}}(V?) - {{Variable_2}}(V?) - {{Variable_3}}(V?) = {{Stimulus name}} V?
```

**1.2 Primary KPI:** {{e.g. PRR}} - target {{X}}%
**1.2 Secondary KPI (Polaris):** {{e.g. ABR}} - target {{X}}%

**1.3 Sample size target:** {{n}} sends per variant ({{ minimum 300 for cold email}})

**1.4 Latency window:** {{e.g. 7 days post-final-send}}
**1.4 Total timeframe:** {{e.g. 2 weeks: 1 week send + 1 week latency}}

**1.5 Airtight check passed:**
- [ ] Deliverability verified (warmup green, bounce baseline <2%)
- [ ] Tracking attribution wired
- [ ] All variables under test cleanly differentiated in Instantly
- [ ] All constants locked
- [ ] Stop conditions written down

**1.6 Variable under test (the needle-mover):** {{ONE variable name, e.g. Content / Subject / CTA}}
**1.6 Modification level:** Slight / Moderate / Complete
**1.6 Justification:** {{Why this modification level - distance from KPI}}

**1.6 Control (current best) - {{Stimulus name}} V({{n}})}}:**
```
{{Paste exact control copy / configuration here}}
```

**1.6 Variant being tested - {{Stimulus name}} V({{n+1}})}}:**
```
{{Paste exact variant copy / configuration here}}
```

**1.7 Constants (LOCKED - any modification invalidates the test):**
- Lead source: {{value}}
- ICP: {{value}}
- Sending domain / mailbox: {{value}}
- Send time of day: {{value}}
- Follow-up sequence structure: {{value}}
- Daily send volume: {{value}}
- Variables NOT under test: {{list with V-numbers}}

#### Step 1 - Stop Conditions

Pause this test if:
- Bounce rate on either variant > {{X}}%
- PRR on variant <{{X}}% after {{n}} sends
- Complaint rate > 0.3%
- Constants drift detected
- Test integrity compromised (anything from 1.5 fails mid-run)

#### Step 1 - Backtrack Plan

If V({{n+1}}) regresses from V({{n}}) - defined as performing worse on the primary KPI by more than {{X}}%:
- Revert to V({{n}}) as the control
- Next iteration: modify a different needle-mover (NOT the same variable again)
- Log the regression as a learning in `clients/{slug}/decision-log.md`

#### Step 2 - Running Data (yesterday's results, logged daily)

| Date logged | Sends control | Sends variant | PRR control | PRR variant | Bounce control | Bounce variant | Notes |
|------------|--------------|--------------|-------------|-------------|---------------|---------------|-------|
| | | | | | | | |

#### Step 2 - Do-Nothing Verification

- [ ] No constants modified since launch
- [ ] Copy unchanged since launch
- [ ] Send volume / timing unchanged since launch
- [ ] No new variables introduced mid-test
- [ ] Data logged daily on yesterday's results

---

## Completed Tests

For each complete test: keep the full Step 1 block above, plus add Step 3 (Observe Results) and Step 4 (Iteration decision).

### Test {{T-XXX}} - {{Short description}}

**Status:** Complete
**Launched:** {{YYYY-MM-DD}}
**Completed:** {{YYYY-MM-DD}}

(All Step 1 fields preserved from when this was Running.)

#### Step 3 - Observe Results

**3.0 Six-rule completion check:**
- [ ] Sample size hit
- [ ] Latency window elapsed
- [ ] Test was airtight (nothing went seriously wrong)
- [ ] All constants remained the same
- [ ] No changes made during the test
- [ ] Data logged daily with 100% accuracy

If any rule failed → mark this test as INVALID and restart. Do not draw conclusions from compromised tests.

**3.1 Verified data (final):**

| Variant | Sends | Replies | PRR | Bounce | Meetings booked | ABR (if measurable) |
|---------|-------|---------|-----|--------|----------------|---------------------|
| Control V({{n}}) | | | | | | |
| Variant V({{n+1}}) | | | | | | |

**3.2 Five-question tree:**

- Q1 Conversion rates (primary, secondary): {{values}}
- Q2 Was secondary (ABR) at/above KPI? {{Yes/No}}
- Q3 Was primary (PRR) at/above KPI? {{Yes/No}}
- Q4 Is primary way below KPI? {{Yes/No}}
- Q5 Is poor PRR scalable with volume? {{Yes/No + reasoning}}

**Verdict:** Control won / Variant won / Inconclusive (test was compromised, restart)

#### Step 4 - Iteration Decision

**Needle-mover for next test:** {{variable name}}
**Modification level:** Slight / Moderate / Complete
**Justification:** {{distance from KPI; what the data revealed about why this version moved or did not move the needle}}

**Next test queued:** T-{{XXX}}

**Decision-log entry:** see `clients/{slug}/decision-log.md` - `{{date}} - Test {{T-XXX}} {{outcome}}`

---

## Reverted Tests

Tests where V(x+1) regressed from V(x) and we backtracked. Capture these so future iterations do not repeat the same misdirection.

### Test {{T-XXX}} - {{Description}}

**Status:** Reverted
**What we tried:** {{V(x+1) description}}
**Why we thought it would work:** {{hypothesis}}
**What actually happened:** {{result vs V(x)}}
**Rule learned:** {{What we now know not to do}}

---

## Testing Roadmap

Next tests to run, in priority order. Each must pass `gtm-skills/test-readiness-check.md` before promoting to "Currently Running."

| Priority | T-ID | Variable | Hypothesis | Status |
|----------|------|---------|-----------|--------|
| 1 | T-{{XXX}} | {{Offer (Part 3)}} | {{What you think will happen}} | Queued |
| 2 | T-{{XXX}} | {{ICP / targeting}} | {{Hypothesis}} | Queued |
| 3 | T-{{XXX}} | {{Icebreaker angle}} | {{Hypothesis}} | Queued |

**Priority order reminder (from scientific-method.md):**
1. Offer (Part 3 of formula) - highest impact
2. ICP / targeting
3. Icebreaker / personalisation angle
4. CTA phrasing
5. Subject line

---

## Test Notes

Observations about testing cadence, what has surprised you, constraints (e.g. low send volume means longer time to hit sample sizes), how the client wants to be informed of test results, etc.