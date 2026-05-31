---
name: chain-weekly-review-full
description: Friday compounding loop chain. Runs the full weekly review for a client end-to-end — health-scorer, weekly-reviewer (with regression check and synthesis), conditional test launches, and client-report-writer. Single command for the Friday routine that compounds the OS.
triggers:
  - "Run /weekly-review-full for [client]"
  - "Friday review for [client]"
  - "Full weekly review for [client]"
  - "Compound the OS for [client]"
  - "End of week sweep for [client]"
  - "Friday portfolio triage"
  - "Run triage for all clients"
  - "Portfolio sweep"
reads:
  - "wiki/_skill-context.md"
  - "company/_config.md, MEMORY.md, campaign-state.md, decision-log.md, copy-library.md, test-log.md, comms-log.md, overview.md"
invokes:
  - "gtm-skills/client-health-scorer.md (always)"
  - "gtm-skills/weekly-reviewer.md (always — runs full 8 steps including synthesis)"
  - "gtm-skills/test-readiness-check.md (conditional)"
  - "gtm-skills/test-launcher.md (conditional)"
  - "gtm-skills/client-report-writer.md (always)"
writes:
  - "company/copy-library.md (winners logged via weekly-reviewer)"
  - "company/decision-log.md (decisions + recurring patterns via weekly-reviewer Step 7)"
  - "company/test-log.md (completed tests + queued next tests)"
  - "company/campaign-state.md (health rating updates)"
  - "company/MEMORY.md (Active Focus and Recent Learnings updates)"
  - "reports/YYYY-WW-weekly-report.md (NOT yet implemented — report stored in client-report-writer output)"
---

# Skill: Chain — Weekly Review Full

**Trigger:** "Run /weekly-review-full for [client]", "Friday review for [client]", "Full weekly review for [client]"

**Context:** The Friday compounding loop, end-to-end. Runs health score → full weekly review (with synthesis step) → conditional test launches for any tests that completed and need promotion → weekly client report. One command captures the entire Friday routine for a single client.

**Why this exists:** the Friday routine is the most important recurring activity in the OS — without it, nothing compounds. Running each skill individually means 4-5 explicit invocations with manual context-passing. This chain captures the routine as a single intent.

**Distinction from `gtm-skills/weekly-reviewer.md`:** the weekly-reviewer skill does the deep review (steps 1-8). This chain wraps it with the pre-step (health scoring) and post-step (test launches + report generation).

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## STEP 0 — Confirm Client + Pull Data (always)

**Log this invocation first.** Append a row to `company/session-log.md` Active Log per `wiki/_skill-context.md` "Session-Log Write" rules. Format: `| YYYY-MM-DD HH:MM | {{paraphrased prompt}} | chain-weekly-review-full | (filled at end) |`. Sub-skills invoked later will write their own rows.

Then verify:
- Client name confirmed (`company/_config.md` matches the trigger)
- This is the Friday routine for THIS client (not a portfolio sweep — that is `weekly-reviewer.md` batch mode, deferred until meta-OS exists)
- Last weekly review date (per `company/_config.md` `last_review_date`) — flag if more than 14 days ago (skipped weeks compound problems)

Pull from Instantly MCP: last 7 days of campaign data per active campaign.

If Instantly MCP unavailable → ask Harry to paste the metrics.

---

## STEP 1 — Client Health Score (always)

Invoke `gtm-skills/client-health-scorer.md`. Produces a 100-point score with breakdown.

**Pause-point:** show Harry the score + breakdown. If score is Amber (40-59) or Red/Critical (under 40), surface intervention recommendations BEFORE proceeding to the deep review.

**Why first:** the health score frames the rest of the review. A Red client gets prioritised attention. A Green client gets routine logging.

If Red/Critical: flag urgency in `company/MEMORY.md` Active Focus. Optionally Harry can pause the chain here to take immediate action.

---

## STEP 2 — Deep Weekly Review (always)

Invoke `gtm-skills/weekly-reviewer.md`. This runs the full 8-step flow:

1. Pull Instantly data (Step 0 of this chain already did this, weekly-reviewer can reuse)
2. Signal trends — surface declining signals
3. Identify winners (PRR ≥ 1.5%, sample ≥ 300) — confirm + capture "why" + log to copy-library + decision-log
4. Identify losers (PRR < 0.5%, sample ≥ 300) — confirm root cause + log to graveyard
5. Update completed tests (six-rule check + 5-question tree + regression check + recommend revert or promotion)
6. Update campaign health in `company/campaign-state.md`
7. **Synthesise the week's insight** — capture meta-takeaway, write to copy-library Cross-Campaign Patterns OR decision-log Recurring Patterns
8. Hand off to report (handled by Step 4 of this chain)

**This is the longest step.** Operator pauses occur naturally inside weekly-reviewer (confirm each winner, each loser, each test result).

---

## STEP 3 — Test Promotion (conditional)

After weekly-reviewer Step 5 completes, check `company/test-log.md` for:

### Case A: A completed test recommended PROMOTION
The variant won (V(n+1) beat V(n) on PRR).

- Promote variant to new control in `company/copy-library.md`
- Queue the NEXT test (different needle-mover per `wiki/scientific-method.md` Step 4.2 priority order)
- If next test is ready to launch: invoke `gtm-skills/test-readiness-check.md` on the queued test
- If READY: invoke `gtm-skills/test-launcher.md`
- If NOT READY: surface gaps, leave in queue

### Case B: A completed test recommended REVERT
The variant regressed from V(n) (regression check fired).

- Revert to V(n) as control
- Log to `company/test-log.md` Reverted Tests section
- Queue a DIFFERENT needle-mover for the next test (do not re-test the same variable)
- Same readiness check pattern as Case A

### Case C: No completed tests this week
Skip Step 3 entirely. Move to Step 4.

**Pause-point:** Harry confirms any test launch before it fires (test-launcher's normal behaviour).

---

## STEP 4 — Generate Weekly Report (always)

Invoke `gtm-skills/client-report-writer.md` using the data captured in Steps 1-3.

The report should reflect:
- Top-line metrics (from Step 0 data pull)
- Health rating (from Step 1)
- Campaign breakdown (from Step 2 Step 6)
- What worked / what is being tested (from Step 2 Steps 3, 4, 7)
- Next week plan (informed by Step 3 test launches)

**Pause-point:** Harry reviews the report before sending. Edits if needed.

After approval → Harry sends via Slack/email per `company/overview.md` SLA. The chain does not auto-send.

---

## STEP 5 — Update OS Hygiene (always)

After the report is sent:

1. Update `company/_config.md`:
   - `last_review_date` → today's date

2. Update `company/MEMORY.md`:
   - Active Focus: any new priorities surfaced this week
   - Active Inbound Watch: prune entries past their re-check date
   - Recent Learnings: any pattern from Step 2 Step 7 synthesis

3. Update `company/comms-log.md` with an entry that the weekly report was sent.

4. If health was Red/Critical in Step 1, ensure a follow-up action is scheduled (next Monday review, escalation call, etc.).

---

## CHAIN OUTPUT FORMAT

```
=== Chain Complete: Weekly Review Full — [CLIENT_NAME] — Week ending [date] ===

Step 1 — Health Score:   [n]/100 → [band] (was [previous] → change [+/-])
Step 2 — Deep Review:
  - Winners logged: [n]
  - Losers logged: [n]
  - Tests completed: [n]
  - Synthesis: "[this week's meta-takeaway in 1 line]"
Step 3 — Test Promotion:
  - Tests promoted: [n]
  - Tests launched: [n]
  - Tests reverted: [n]
Step 4 — Report:
  - Draft generated and ready for Harry review

Files updated:
- company/copy-library.md
- company/decision-log.md
- company/test-log.md
- company/campaign-state.md
- company/MEMORY.md
- company/_config.md (last_review_date)
- company/comms-log.md (report sent entry — pending after Harry sends)

OS state for [client]: [Green/Amber/Red]
Next review: Friday [date + 7]

Outstanding: [any client-side actions Harry needs to take this week]
```

---

## PORTFOLIO TRIAGE MODE

**Trigger:** "Friday portfolio triage", "Run triage for all clients", "Portfolio sweep"

**Purpose:** Sweep all 20 clients in under 45 minutes and identify which ones need a full review this Friday. Run this first, every Friday. Then run single-client mode (Steps 0-5) only on flagged clients.

**Prerequisites:** Harry supplies the client list at invocation: "Portfolio triage for: [Client A, Client B, ...]". A formal `clients.md` index will be added in v1.5.0 meta-OS. Until then, the list is the source of truth.

### Phase 1 — Triage Sweep (~2 min per client)

For each client in the list, invoke `gtm-skills/weekly-reviewer.md` in quick-review mode.

Output a running portfolio table as each client completes:

```
=== Portfolio Triage — Friday [date] ===

| Client       | PRR   | Meetings | G1 Winner | G2 Loser | G3 Test | G4 Signal | Action       |
|--------------|-------|----------|-----------|----------|---------|-----------|--------------|
| Client A     | 2.1%  | 3        | NO        | NO       | NO      | NO        | Green pass   |
| Client B     | 0.4%  | 0        | NO        | YES      | NO      | YES       | Full review  |
| Client C     | 1.8%  | 5        | YES       | NO       | YES     | NO        | Full review  |
| ...          |       |          |           |          |         |           |              |

Clients needing full review: [n] of 20
Estimated Friday time remaining: [n × 15 min] + ~[20 × 3 min] reports
```

**After table:** "Run full reviews now? (Y — I'll work through flagged clients in priority order / tell me the order)"

### Phase 2 — Full Reviews (flagged clients only)

For each flagged client, run this chain (Steps 0-5) in single-client mode.

Priority order: Red/Critical first → Amber → Green (if flagged).

### Phase 3 — Reports (all 20 clients)

After all full reviews complete, generate reports for flagged clients via `gtm-skills/client-report-writer.md`. Green-pass clients get a 3-line status update (PRR, meetings, no action) rather than a full report — saves ~30 min across the portfolio.

### Honest time estimate

| Activity | Time |
|----------|------|
| Triage: 20 clients × 2 min | ~40 min |
| Full reviews: typically 5-8 flagged × 15-20 min | 75-160 min |
| Reports: flagged clients full + green-pass status updates | ~45 min |
| **Total** | **2.5-4 hours** |

This compares to 5-6 hours running full reviews on every client. The efficiency gain comes entirely from skipping full reviews on green-pass clients.


---

## RULES

- **Use Portfolio Triage Mode for 20 clients.** Run quick-review triage on all clients first (see Portfolio Triage Mode above), then run single-client mode only on flagged clients. Do not run full review on all 20 clients sequentially — that is 5-6 hours, not 2.5-4 hours.
- **Never skip Step 2.** The deep review IS the compounding loop. If you skip it, the OS does not learn anything from this week.
- **Always run the synthesis step.** That is weekly-reviewer Step 7 — the meta-takeaway that turns individual entries into compounding patterns. Without it, the entries pile up without ever connecting.
- **Pause at every meaningful checkpoint.** This chain is decision support — Harry confirms winners, losers, test launches, and the report before send.
- **Update `last_review_date`.** Skipped weeks = broken compounding loop. The date tracking surfaces drift.
- **If chain is interrupted mid-flow.** Resume from the last completed step on next invocation. The OS state files (copy-library, decision-log, test-log) are appended to as each step completes — no all-or-nothing risk.
