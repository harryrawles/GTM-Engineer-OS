# Skill: Weekly Reviewer

**Trigger:** "Run weekly review for {{client}}", "Weekly sweep", "Run weekly review for all clients", "End of week review", "Friday review"

**Context:** The compounding loop of the OS. Without this skill running consistently, `clients/{slug}/copy-library.md`, `clients/{slug}/test-log.md`, and `clients/{slug}/decision-log.md` stay empty — meaning every campaign starts from scratch. It is also where **Confirmed** learnings get abstracted, de-identified, and promoted up into the shared layer (Step 8) so a lesson learned on one client improves the OS for *all* clients. **This is the single most important recurring skill in the OS.**

**Cadence:** every Friday afternoon (or first thing Monday). Skipping a week is fine. Skipping a month means the compounding effect is dead.

**Two modes:**
- **Single client:** "Run weekly review for {{client}}" — full deep review of one client (~15-20 min)
- **Batch / portfolio:** "Run weekly review for all clients" — sweeps every client OS, surfaces portfolio summary, then runs the deep review on flagged accounts

---

## READS

- Instantly API (via `.claude/bin/instantly.sh`) — last 7 days per campaign per client
- `clients/{slug}/campaign-state.md` — current campaign list and health
- `clients/{slug}/icp.md` — to check signal alignment
- `clients/{slug}/copy-library.md` — prior winners (do not re-log)
- `clients/{slug}/test-log.md` — currently running tests
- `wiki/signal-sourcing.md` — signal performance benchmarks
- `wiki/email-benchmarks.md` — what good looks like
- `clients/{slug}/decision-log.md` — prior decision rationale (read for context)

## WRITES (now includes the canonical scientific-method discipline)

- `clients/{slug}/copy-library.md` — new winners (with why-it-worked notes)
- `clients/{slug}/copy-library.md` graveyard section — new losers
- `clients/{slug}/decision-log.md` — rationale for every winner logged
- `clients/{slug}/test-log.md` — completed test results, next test queued
- `clients/{slug}/campaign-state.md` — refreshed health rating per campaign
- **Shared layer — Step 8, DE-IDENTIFIED ONLY, and only on `Confirmed` patterns:** `best-practices/` (won copy *structures* + graveyard *anti-patterns*), `frameworks/` (strategic mental models), or `wiki/objection-library.md` (reusable objections). Never a client's raw copy, numbers, or named prospects.

---

## STEP 0 — Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

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


---

## TWO-TIER MODE SELECTION

Before running any review, determine which mode applies:

**Quick-review (default — Friday triage pass):**
- Use when: routine Friday sweep across all clients
- Time: ~2 min per client
- Escalates automatically to full review if any triage gate fires

**Full review (deep review):**
- Use when: triage flagged this client, OR Harry explicitly invokes full review, OR client is Red/Critical
- Time: 15-20 min per client

The portfolio triage pattern: run quick-review on every client first, collect the flagged list, then run full review only on flagged clients. See `gtm-skills/chain-weekly-review-full.md` Portfolio Triage Mode.

---

## QUICK-REVIEW MODE — Triage Pass

**Trigger:** "Quick review for {{client}}", "Triage {{client}}", or called from portfolio triage in `gtm-skills/chain-weekly-review-full.md`

**Purpose:** 2-minute health stamp. Determines whether this client needs a full review this Friday. Does not log winners, diagnose losers, or analyse tests — it only checks whether those things need doing.

### Pull data

Pull last 7 days from the Instantly API (via `.claude/bin/instantly.sh`). If it can't be reached (missing/invalid key), read `clients/{slug}/campaign-state.md` last-known health and ask Harry for a headline PRR figure.

### Four triage gates

| Gate | Check | Flag if... |
|------|-------|------------|
| G1 — Winner candidate | Any campaign PRR ≥ 1.5% with ≥ 300 sends | NOT already in `clients/{slug}/copy-library.md` Top Performers |
| G2 — Loser candidate | Any campaign PRR < 0.5% with ≥ 300 sends | NOT already in `clients/{slug}/copy-library.md` Graveyard |
| G3 — Test completing | Any Running test in `clients/{slug}/test-log.md` | Sample size hit AND latency window elapsed this week |
| G4 — Signal declining | Any signal in `clients/{slug}/icp.md` signal table | PRR down 30%+ week-over-week |

### Output and routing

**All four gates NO:**
```
{{client_name}} — Green pass. PRR {{x}}%, {{n}} meetings. No action this Friday.
```
- Update health to Green in `clients/{slug}/campaign-state.md` (or preserve current rating if already higher)
- Update `clients/{slug}/_config.md` `last_review_date` to today
- Write session-log row (see below)
- Done — move to next client

**Any gate YES:**
```
{{client_name}} — Flagged for full review.
G1 Winner: [YES/NO] — [campaign name if yes]
G2 Loser:  [YES/NO] — [campaign name if yes]
G3 Test:   [YES/NO] — [T-ID if yes]
G4 Signal: [YES/NO] — [signal name if yes]
```
Escalate to SINGLE-CLIENT MODE — Full Flow below.

### Session-log entry

Write one row to `clients/{slug}/session-log.md` Active Log:
```
| YYYY-MM-DD HH:MM | Quick-review triage | weekly-reviewer | Green pass / Flagged: [gates fired] |
```

---

## SINGLE-CLIENT MODE — Full Flow

### Step 1 — Pull data from Instantly

For the past 7 days, per campaign:
- Sends, replies, positive reply rate (PRR), meetings booked
- Bounce rate, open rate, complaint rate
- Per-sequence-step breakdown (Email 1 / 2 / 3 PRR)
- Top subject lines by open rate

If the Instantly API can't be reached (missing/invalid key) → ask Harry to paste the data. Continue from Step 2.

### Step 2 — Surface signal performance trends

For each active signal in `clients/{slug}/icp.md`:
- 7-day PRR vs prior 7 days
- 30-day rolling PRR trend
- Flag any signal trending down 30%+ week over week
- Flag any signal where PRR < 0.5% (saturating or burning out)

Output a signal trends table:
```
Signal           | 7-day PRR | Prior week | Trend  | Status
---------------- | --------- | ---------- | ------ | ------
Hiring intent    | 2.3%      | 2.1%       | ↑ 10%  | Healthy
Funding (Series A)| 0.6%      | 1.8%       | ↓ 67%  | DECLINING — flag
Tech change      | 1.2%      | 1.1%       | ↔      | Stable
```

If a signal is flagged: recommend either pause + iterate, or rotate in a new signal from `wiki/signal-sourcing.md`.

### Step 3 — Identify winners (PRR ≥ 1.5%, sample ≥ 300 sends)

For each campaign / variant hitting the winner threshold AND not already in `clients/{slug}/copy-library.md`:

1. Output the candidate winner:
```
WINNER CANDIDATE — {{campaign_name}} / Email {{n}}
- Sends: {{n}}
- PRR: {{pct}}
- Reply rate: {{pct}}
- Meetings: {{n}}
- Signal: {{signal}}
- Target ICP: {{title / company type}}

Copy:
Subject: {{subject}}
{{body}}
```

2. Ask: **"Log this as a winner?"** Wait for confirmation.

3. If yes, ask Harry the decision-log questions:
   - **Why do you think this worked?** (1-3 specific reasons)
   - **What is the most stealable element?** (the pattern to replicate)
   - **Anything you would NOT carry over to another client?**

4. **Write to `clients/{slug}/copy-library.md`** in the Top Performers section using the existing template (client, date, signal, target ICP, sequence step, metrics, full copy, why it worked, what to steal).

5. **Write to `clients/{slug}/decision-log.md`** with the rationale (see decision-log template below).

6. Confirm both writes to Harry.

### Step 4 — Identify losers (PRR < 0.5%, sample ≥ 300 sends)

For each campaign / variant hitting the loser threshold AND not already in the graveyard:

1. Output the candidate loser with metrics and copy.
2. Ask: **"Log this to the graveyard? What was the root cause?"**
3. Write to `clients/{slug}/copy-library.md` graveyard section with: variant name, signal, PRR, why it failed, what NOT to repeat.
4. Write to `clients/{slug}/decision-log.md` capturing the lesson.

### Step 5 — Update completed tests in `clients/{slug}/test-log.md` (apply scientific method)

For each test currently in "Running" status, run the **six-rule completion check** from `wiki/scientific-method.md` Step 3:

| # | Rule | Verify |
|---|------|--------|
| 1 | Sample size hit | Compare actual sends to 1.3 target |
| 2 | Latency window elapsed | Compare today to launch date + send window + 7 days |
| 3 | Test was airtight | Confirm 1.5 checks held throughout |
| 4 | Constants unchanged | Verify no skill modified anything locked in 1.7 |
| 5 | No changes during test | Verify do-nothing rule held |
| 6 | Daily logging complete | Verify Running data table has full daily entries |

If any rule failed → mark test INVALID, do not draw conclusions, restart with a clean version.

If all 6 pass → proceed to the **5-question tree** (Step 3.2):

1. **Q1:** What was the conversion rate for primary (PRR) and secondary (ABR)?
2. **Q2:** Was secondary (ABR) at or above KPI? If YES → change nothing, scale. Stop.
3. **Q3:** Was primary (PRR) at or above KPI? If YES → copy is working, look downstream of PRR.
4. **Q4:** Is primary way below KPI? If YES → iterate (Step 4 of scientific method).
5. **Q5:** Is the result scalable with volume even if below KPI? (calibration question)

#### Regression check (the Managing Future Experiments rule)

If the completed variant V(n+1) was an iteration of V(n), compare PRR head-to-head:

- **V(n+1) regressed from V(n) by more than the backtrack threshold defined in test-log** → recommend **REVERT** to V(n) and iterate a DIFFERENT needle-mover next. Log the regression as a learning in `clients/{slug}/decision-log.md` under "What we tried + what failed" and in `clients/{slug}/test-log.md` Reverted Tests section.
- **V(n+1) improved over V(n)** → promote V(n+1) as the new control. Update `clients/{slug}/copy-library.md` if PRR ≥ 1.5%. Queue next test (different needle-mover, OR same needle-mover at a different modification level, OR same modification on a different variable per the priority order in `wiki/scientific-method.md` Step 4.2).
- **V(n+1) inconclusive (within margin of V(n))** → re-test with a moderate modification of the same needle-mover.

Output the regression verdict explicitly:
```
T-{{ID}} regression check: V(2) vs V(1)
- V(1) PRR: 1.8%
- V(2) PRR: 0.5%
- Backtrack threshold: V(2) <50% of V(1) PRR
- VERDICT: REGRESSED — recommend revert to V(1), iterate CTA next instead of Content
```

#### Active-test awareness

If a test is **still Running** (sample not hit OR latency window not elapsed), do NOT analyse it as if complete. Note it as in progress and skip the variant analysis until next week.

Use Step 4 of `wiki/scientific-method.md` to queue the next test in the testing roadmap.

For each test currently in "Running" status:
- Has it hit sample size (300 sends per variant)?
- Has latency window passed (1 week post-send minimum)?

If yes:
1. Output the test result:
```
TEST {{ID}} COMPLETE — {{variable_tested}}
Control:  {{name}} | Sends: {{n}} | PRR: {{pct}}
Variant:  {{name}} | Sends: {{n}} | PRR: {{pct}}
Winner: {{Control / Variant / Inconclusive}}
```

2. Ask: **"Confirm result? Conclusion?"**

3. Write the result to `clients/{slug}/test-log.md` Completed Tests section.

4. Apply scientific method (`wiki/scientific-method.md`):
   - If variant won → promote variant to new control. Recommend next test from priority order.
   - If control won → return to control. Pick a different needle-mover variable.
   - If inconclusive → recommend re-test with refined hypothesis.

5. Queue the recommended next test in `clients/{slug}/test-log.md` testing roadmap.

### Step 6 — Update campaign health in `clients/{slug}/campaign-state.md`

For each active campaign, set health:
- **Green** — PRR ≥ 1.5%, bounce < 2%, all sequence steps performing
- **Amber** — PRR 0.5-1.5%, OR bounce 2-3%, OR signal declining
- **Red** — PRR < 0.5%, OR bounce > 3%, OR warmup disabled

Update the "current metrics" and "health" fields per campaign. Add a state note if anything changed materially.

### Step 7 — Synthesise the Week's Insight

After all individual winners, losers, and tests are logged, zoom out and capture the meta-takeaway.

Ask Harry one question:
> "What pattern emerged this week? What did this week tell us that the individual entries don't?"

Then classify the pattern type:

- **Copy pattern** (a specific phrasing, hook, CTA, framework, sequence step is working/failing repeatedly) → write to `clients/{slug}/copy-library.md` **Cross-Campaign Patterns** table
- **Strategic pattern** (signal health, ICP fit, offer framing, sequence structure, persona register) → write to `clients/{slug}/decision-log.md` **Recurring Patterns** section

Format the entry as:

```
### {{date}} — {{Pattern name in 6 words}}

**Observed:** {{What happened — specific data points across multiple entries}}
**Sample size:** {{n campaigns / n decisions / n weeks supporting this}}
**Implication:** {{What this tells us}}
**Action:** {{What we change because of this}}
**Confidence:** {{Tentative / Emerging / Confirmed}}
```

**Confidence rules:**
- **Tentative:** 2-3 data points. Worth watching, do not change defaults yet.
- **Emerging:** 4-5 data points across 2+ weeks. Test a default change.
- **Confirmed:** 6+ data points across 3+ weeks. Adopt as new default.


### Sub-Agent — Optional Research Lookup

If during synthesis the pattern is unclear (e.g. "PRR dropped — is this industry-wide or just us?"), spawn a general-purpose sub-agent for external research. See `wiki/_subagent-patterns.md` Pattern 2.

Example prompt:
```
Look up recent (last 30-60 days) industry reports or articles about cold email reply rate trends in the B2B {{vertical}} space. Specifically: are reply rates declining industry-wide, or are observed declines client-specific?

Sources: industry blog posts (ColdIQ, SmartLead, Instantly blog), recent Reddit r/Emailmarketing threads, recent LinkedIn posts from known practitioners.

Return:
1. Are there reports of industry-wide PRR decline in this vertical?
2. What time period?
3. What's the proposed root cause (if any)?
4. Suggested adaptations

Cite sources.
```

Use sub-agent here only when the synthesis genuinely requires external context. Most weeks the pattern is internal and the sub-agent isn't needed.

**Skip rule:** if no pattern emerged this week, write to decision-log: `### {{date}} — No emergent pattern this week — continue current defaults`. Do NOT invent patterns from noise.

This is the compounding step. Skipping it means individual entries pile up without ever connecting into insight.

---
### Step 8 — Promote Generalisable Learnings to the Shared Layer

This is the **system-wide** half of the compounding loop (root `CLAUDE.md` → *The Compounding Loop*). Steps 3-7 compound *within* the client; this step lifts de-identified methodology *up* so every client benefits. Runs after the week's patterns are logged.

**When it fires:** only for a pattern that reached **`Confirmed`** confidence in Step 7 (6+ data points across 3+ weeks). Tentative/Emerging patterns stay client-local until they mature. If nothing is Confirmed this week, skip this step and say so.

**Isolation guardrail (critical — same rule as `gtm-skills/client-offboarder.md` STEP 3):** only promote **abstracted, generalisable patterns** — never a client's raw private data. Strip the client's specific numbers, named prospects, proof points, and verbatim copy. If a learning cannot be stated without the client's private data, it is NOT promotable — it stays in `clients/{slug}/`. See root `CLAUDE.md` → *Golden Rules* (no cross-client sharing of data, ever).

**Flow — for each Confirmed pattern:**

1. Restate the pattern in **client-agnostic form** (the transferable lesson, not the client's exact email). Do not copy `copy-library.md` / `decision-log.md` entries verbatim.
2. Classify the destination:
   - Won copy **structure** / hook / CTA / sequence-step pattern → `best-practices/` (append to the most relevant existing file, or create a new client-agnostic one).
   - Graveyard **anti-pattern** (the structural mistake to avoid) → `best-practices/`.
   - Strategic **mental model** / signal-health / offer-framing / register insight → `frameworks/`.
   - Reusable **objection + response** → `wiki/objection-library.md`.
3. Show Harry the exact de-identified text and target file. **Ask: "Promote this to `{path}`? (Y/N)"** Wait for confirmation (per the RULES below — never write without confirmation).
4. On yes: write the abstracted entry to the target file. If a *new* shared file was created, add it to `INDEX.md`.
5. Record the promotion in `clients/{slug}/decision-log.md` (one line: what was promoted, to where, on what date) for traceability — so the client folder shows what left it, without the shared file ever pointing back to the client.

**Output:**
```
Step 8 — Shared-layer promotions this week: {{n}}
- "{{pattern name}}" → {{best-practices/frameworks/wiki path}} (de-identified) [pending Harry Y/N]
```

If a promotion is declined, leave the learning in the client folder and note the decline in `decision-log.md`.

---
### Step 9 — Hand off to client-report-writer

Once all writes are confirmed, output:

```
=== Weekly Review Complete: {{client_name}} ===

Winners logged: {{n}}
Losers logged: {{n}}
Tests completed: {{n}}
Tests queued next: {{n}}
Campaign health: {{green count}} green, {{amber}} amber, {{red}} red
Signal alerts: {{n}}

Ready to generate weekly client report. Run client-report-writer? (Y/N)
```

If yes → invoke `gtm-skills/client-report-writer.md` using the data just analysed. The report draft is populated from the review, not pulled from scratch.

---

## OS Hygiene (run at the end of every review)

Housekeeping so the compounding substrate stays clean:

- **Prune the session log.** In `clients/{slug}/session-log.md`, move Active Log rows older than 90 days into the Archive table — including the deterministic `via:hook` backstop rows, which accrue one per prompt and are the fastest-growing entries. Never delete; archive only.
- **Refresh dates.** Set `clients/{slug}/_config.md` `last_review_date` to today.
- **INDEX.** If Step 8 promoted a learning into a *new* shared file, confirm it is listed in `INDEX.md`.

(The portfolio chain `gtm-skills/chain-weekly-review-full.md` performs the equivalent as its STEP 5 — Update OS Hygiene.)

---

## BATCH MODE — Portfolio Sweep

Triggered by "Run weekly review for all clients" or "Weekly portfolio sweep."

This is the multi-client OS — no separate meta-OS repo is needed. The portfolio **is** the set of folders
under `clients/`.

**How the client list is resolved:**
- Enumerate every active folder in `clients/` — each is one client (its slug is the folder name). Skip any subfolder whose name starts with `_` or `.` (e.g. `clients/_archived/`).
- Run the sweep once per client, in **full isolation**: read/write only that client's `clients/{slug}/`
  files. Never carry one client's copy, ICP, or data into another's review.
- Cross-client *patterns* (e.g. a winning Email 1 framework working across 3 clients) may be surfaced in
  the aggregate summary as an observation — but never by copying one client's private data into another.

**Total time guide:** ~15 min per client if run as full deep reviews; use Portfolio Triage first (quick
one-line health per client, then deep-dive only flagged accounts) to keep the whole sweep to 2.5-4 hours.

The flow below is the batch flow.

### Batch flow

For each client folder under `clients/` in sequence:
1. Pull last 7 days of Instantly data
2. Output a one-line health summary per client:
```
{{client_name}} — PRR {{pct}} | {{n}} meetings | {{health}} | {{signal alert if any}}
```
3. Skip clients that are green and have no winners/losers to log

Output the portfolio summary:
```
=== Portfolio Weekly Sweep — Week ending {{date}} ===

| Client | Sends | PRR | Meetings | Health | Action |
|--------|-------|-----|----------|--------|--------|
| ...    | ...   | ... | ...      | Green  | None   |
| ...    | ...   | ... | ...      | Amber  | Deep review needed |
| ...    | ...   | ... | ...      | Red    | URGENT |

Clients needing deep review: {{n}}
Clients needing client reports: {{n}}

Run deep review on flagged clients now? (Y/N)
```

If yes → enter single-client mode for each flagged client in priority order (Red first, then Amber).

After all reviews complete, ask: "Generate client reports for all clients?" If yes → run `client-report-writer` per client.

---

## RULES

- **Never write without confirmation.** Every log to copy-library, decision-log, test-log, or campaign-state must be confirmed by Harry.
- **Never invent metrics.** If the Instantly API fails or numbers are missing, ask Harry to paste them. Do not estimate.
- **Sample size is non-negotiable.** Do not log a winner or loser with fewer than 300 sends per variant. Flag as "pending sample size" instead.
- **Latency rule.** Do not call a test complete until 7 days post-send. Reply latency can rescue a "loser" verdict.
- **Decision log is non-skippable for winners.** Every winner logged must have a why captured. Otherwise the OS does not compound — it just stores artefacts.
- **Push back on vague "why" answers.** "It worked because the offer was good" is not a steal-worthy insight. Push for specifics: which phrase, which structure, which data point.
- **Surface anomalies you do not understand.** If a campaign hit 4% PRR with no clear signal, flag it. Do not log a winner you cannot explain.
- **Update INDEX.md if new wiki entries cause a structural change.** Otherwise leave it.
- **Time-box yourself.** Single-client deep review should be 15-20 min. Batch portfolio summary ≤ 5 min before drilling in.

---

## OUTPUT EXAMPLE — Single Client

```
Harry: Run weekly review for {{CLIENT_NAME}}

Claude:
=== Weekly Review — {{CLIENT_NAME}} — Week ending 2026-05-29 ===

Pulling Instantly data... done.

[Step 2 — Signal trends]

Signal              | 7-day PRR | Prior week | Trend  | Status
------------------- | --------- | ---------- | ------ | ------
Hiring intent       | 2.3%      | 2.1%       | ↑ 10%  | Healthy
Funding (Series A)  | 0.6%      | 1.8%       | ↓ 67%  | DECLINING — flag
Tech change         | 1.2%      | 1.1%       | ↔      | Stable

⚠ Funding signal declining sharply. Recommend pausing and rotating in M&A or expansion signal from wiki/signal-sourcing.md. Discuss after winners logged.

[Step 3 — Winner candidates]

WINNER CANDIDATE — Hiring Signal v4 / Email 1
- Sends: 423
- PRR: 2.4%
- Reply rate: 5.1%
- Meetings: 6
- Signal: 5+ engineering job postings in 30 days
- Target ICP: Head of Engineering at Series B-C SaaS

Copy:
Subject: hiring speed
Saw you posted 5 senior eng roles in the last 30 days.
I run engineering placement for 3 VC-backed SaaS teams — last quarter we got {{NAMED_PROOF_COMPANY}} fully staffed in 18 days and saved them $100k vs in-house recruiting.
Want me to send a sample shortlist?

Log this as a winner?

Harry: Yes

Claude:
Why do you think this worked?

Harry: The specific number (5 roles), the named client + $ saved, and the "send a sample shortlist" CTA — much lower friction than asking for a call.

Claude:
What is the most stealable element?

Harry: The "specific signal number + named client + dollar saved" structure for Part 1 and 2.

Claude:
Anything you would NOT carry over to another client?

Harry: The dollar figure is {{CLIENT_NAME}}-specific. Other clients need their own proof number.

Claude:
Writing to clients/{slug}/copy-library.md... done.
Writing to clients/{slug}/decision-log.md... done.

Next: loser candidates.

[continues through all 9 steps]
```