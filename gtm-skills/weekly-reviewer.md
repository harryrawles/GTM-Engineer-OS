# Skill: Weekly Reviewer

**Trigger:** "Run weekly review for {{client}}", "Weekly sweep", "Run weekly review for all clients", "End of week review", "Friday review"

**Context:** The compounding loop of the OS. Without this skill running consistently, `wiki/copy-library.md`, `wiki/test-log.md`, and `company/decision-log.md` stay empty — meaning every campaign starts from scratch. **This is the single most important recurring skill in the OS.**

**Cadence:** every Friday afternoon (or first thing Monday). Skipping a week is fine. Skipping a month means the compounding effect is dead.

**Two modes:**
- **Single client:** "Run weekly review for {{client}}" — full deep review of one client (~15-20 min)
- **Batch / portfolio:** "Run weekly review for all clients" — sweeps every client OS, surfaces portfolio summary, then runs the deep review on flagged accounts

---

## READS

- Instantly MCP — last 7 days per campaign per client
- `company/campaign-state.md` — current campaign list and health
- `company/icp.md` — to check signal alignment
- `wiki/copy-library.md` — prior winners (do not re-log)
- `wiki/test-log.md` — currently running tests
- `wiki/signal-sourcing.md` — signal performance benchmarks
- `wiki/email-benchmarks.md` — what good looks like
- `company/decision-log.md` — prior decision rationale (read for context)

## WRITES

- `wiki/copy-library.md` — new winners (with why-it-worked notes)
- `wiki/copy-library.md` graveyard section — new losers
- `company/decision-log.md` — rationale for every winner logged
- `wiki/test-log.md` — completed test results, next test queued
- `company/campaign-state.md` — refreshed health rating per campaign

---

## SINGLE-CLIENT MODE — Full Flow

### Step 1 — Pull data from Instantly

For the past 7 days, per campaign:
- Sends, replies, positive reply rate (PRR), meetings booked
- Bounce rate, open rate, complaint rate
- Per-sequence-step breakdown (Email 1 / 2 / 3 PRR)
- Top subject lines by open rate

If Instantly MCP is unavailable → ask Harry to paste the data. Continue from Step 2.

### Step 2 — Surface signal performance trends

For each active signal in `company/icp.md`:
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

For each campaign / variant hitting the winner threshold AND not already in `wiki/copy-library.md`:

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

4. **Write to `wiki/copy-library.md`** in the Top Performers section using the existing template (client, date, signal, target ICP, sequence step, metrics, full copy, why it worked, what to steal).

5. **Write to `company/decision-log.md`** with the rationale (see decision-log template below).

6. Confirm both writes to Harry.

### Step 4 — Identify losers (PRR < 0.5%, sample ≥ 300 sends)

For each campaign / variant hitting the loser threshold AND not already in the graveyard:

1. Output the candidate loser with metrics and copy.
2. Ask: **"Log this to the graveyard? What was the root cause?"**
3. Write to `wiki/copy-library.md` graveyard section with: variant name, signal, PRR, why it failed, what NOT to repeat.
4. Write to `company/decision-log.md` capturing the lesson.

### Step 5 — Update completed tests in `wiki/test-log.md`

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

3. Write the result to `wiki/test-log.md` Completed Tests section.

4. Apply scientific method (`wiki/scientific-method.md`):
   - If variant won → promote variant to new control. Recommend next test from priority order.
   - If control won → return to control. Pick a different needle-mover variable.
   - If inconclusive → recommend re-test with refined hypothesis.

5. Queue the recommended next test in `wiki/test-log.md` testing roadmap.

### Step 6 — Update campaign health in `company/campaign-state.md`

For each active campaign, set health:
- **Green** — PRR ≥ 1.5%, bounce < 2%, all sequence steps performing
- **Amber** — PRR 0.5-1.5%, OR bounce 2-3%, OR signal declining
- **Red** — PRR < 0.5%, OR bounce > 3%, OR warmup disabled

Update the "current metrics" and "health" fields per campaign. Add a state note if anything changed materially.

### Step 7 — Hand off to client-report-writer

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

## BATCH MODE — Portfolio Sweep

Triggered by "Run weekly review for all clients" or "Weekly portfolio sweep."

**This mode requires the meta-OS** (separate repo listing all client repos). If it does not exist, ask Harry to list the active client OS repos and proceed.

### Batch flow

For each client repo in sequence:
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
- **Never invent metrics.** If Instantly MCP fails or numbers are missing, ask Harry to paste them. Do not estimate.
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
Harry: Run weekly review for Recruitcha

Claude:
=== Weekly Review — Recruitcha — Week ending 2026-05-29 ===

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
I run engineering placement for 3 VC-backed SaaS teams — last quarter we got TurboTenant fully staffed in 18 days and saved them $100k vs in-house recruiting.
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

Harry: The dollar figure is Recruitcha-specific. Other clients need their own proof number.

Claude:
Writing to wiki/copy-library.md... done.
Writing to company/decision-log.md... done.

Next: loser candidates.

[continues through all 7 steps]
```