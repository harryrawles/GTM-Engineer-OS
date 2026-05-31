# Operating Rhythm

The daily, weekly, monthly, and quarterly cadence for managing GTM accounts. Following this rhythm is what separates "good operator" from "world class."

**Total time investment for 20 clients:** ~20-25 hours per week (with triage-first Friday review).

---

## Daily — Morning Check (10 min)

**When:** First thing, before any client work.

**What:**
1. Check overnight Slack / email alerts (deliverability, blacklists, escalations)
2. Scan Instantly inbox for new replies across all clients (~5 min)
3. Triage:
   - Positive replies → run `gtm-skills/reply-handler.md` (or batch for later)
   - Hostile / GDPR-flagged replies → handle immediately
   - OOO / wrong-person replies → auto-handle via reply-handler
4. Check overnight bounce rates across all active campaigns
5. If any red flag → log a GitHub issue, decide whether to escalate today

**Skip if:** weekend, planned day off, or vacation (set Instantly to "monitor only" before going dark).

**Output:** mental model of "what needs attention today" before deep work starts.

---

## Daily — End of Day Wrap (5 min)

**When:** Before logging off.

**What:**
1. Log any client comms sent today to `company/comms-log.md` (per client)
2. Update any decision log entries if a decision was made
3. Push commits to client repos if files changed

**Why:** prevents drift. Future-Harry remembers what happened today only if today-Harry writes it down.

---

## Monday — Week Planning (1 hour for 20 clients)

**When:** First thing Monday morning.

**What:**
1. **Portfolio health pass** — run `gtm-skills/client-health-scorer.md` in portfolio mode. Get scores across all clients.
2. **Identify focus list for the week:**
   - All Red / Critical clients → top priority
   - All Amber clients → second priority
   - Clients with renewal in next 90 days → ensure positive momentum
3. **For each focus client (~5-10 min each):**
   - Review last week's metrics
   - Identify the one biggest needle-mover for the week
   - Add to weekly to-do (GitHub issue, Notion task, etc.)
4. **Schedule the week:**
   - Mon-Tue: optimisation work on at-risk clients
   - Wed: net new copy / new client onboarding
   - Thu: client comms, calls, QBR prep
   - Fri: weekly review of all clients

**Output:** prioritised week with concrete tasks per client.

---

## Friday — Weekly Review Sweep (2.5-4 hours for 20 clients)

**When:** Friday afternoon (default). Or Monday morning if Friday is impossible.

**The single most important recurring activity.** Without this, the OS does not compound.

**Two-tier approach — triage first, full review only for flagged clients.**

Running full reviews on all 20 clients every Friday takes 5-6 hours. The triage approach cuts this to 2.5-4 hours by skipping full reviews on clients where nothing actionable happened that week.

**What:**

### Step 1 — Portfolio triage (~40 min)
Run `gtm-skills/chain-weekly-review-full.md` in Portfolio Triage Mode:
```
Friday portfolio triage for: [list all 20 clients]
```
This runs a 2-minute triage pass on each client via `gtm-skills/weekly-reviewer.md` quick-review mode. Each client gets four gates checked: winner candidate, loser candidate, test completing, signal declining. Output: a portfolio table showing which clients are Green pass vs flagged.

**Typical outcome:** 5-8 clients flagged, 12-15 Green pass.

### Step 2 — Full reviews (flagged clients only, ~15-20 min each)
For each flagged client, run full single-client review (chain-weekly-review-full Steps 1-5):
- Winners to log (PRR ≥ 1.5%) → confirm "why it worked" → write to copy-library + decision-log
- Losers to log (PRR < 0.5%) → confirm root cause → write to graveyard
- Completed tests → confirm result → write to test-log → queue next test
- Signal trends → diagnose decline → recommend pivots

Priority order: Red/Critical first → Amber → Green (if flagged).

### Step 3 — Reports (~45 min across all 20)
- Flagged clients → full weekly report via `gtm-skills/client-report-writer.md`
- Green-pass clients → 3-line status update (PRR, meetings, no action)
- Review before sending (never auto-send)
- Send via Slack / email per `company/overview.md` SLA

**Output:**
- Every client has a logged review (full or triage stamp)
- Flagged clients have fresh learnings in copy-library + decision-log
- Every active test has progressed or completed
- Every client has a report or status update

**If skipped:** flag in Monday review. Skipping 2 weeks = OS stops compounding for that client. The triage stamp counts — even a Green pass is better than no review.

---

## Monthly — ICP & Offer Review (per client, ~30 min)

**When:** First Monday of the month.

**What (per client):**
1. Review `company/icp.md` against last 30 days of campaign data:
   - Are positive replies coming from the expected titles? (If not → ICP drift)
   - Are negative replies from titles we should exclude? (If yes → tighten avoid list)
   - Has signal performance shifted? (Rotate underperformers)
2. Review `company/offer.md` against client outcomes:
   - Are the case studies still relevant?
   - Have new client wins been added that could be used?
   - Is the risk reversal still credible?
3. Review `company/test-log.md`:
   - Are tests progressing? Any stuck?
   - Is the testing roadmap fresh?
4. Update files where needed → log changes to `company/decision-log.md`

**Output:** ICP and offer stay current. Test roadmap stays moving.

---

## Quarterly — QBR (per client, ~2 hours)

**When:** Last week of each quarter (per client).

**What:**
1. **Prep:** run `gtm-skills/qbr-writer.md` to generate the QBR document
2. The QBR covers:
   - 90-day performance summary (PRR, meetings, deals closed)
   - Wins and learnings (from decision-log)
   - ROI calculation (what client paid vs what they earned)
   - Next quarter strategy (signal pivots, new tests, scale plan)
   - Renewal / expansion discussion
3. Schedule QBR call with client (~45 min)
4. Run the call, capture feedback to `company/comms-log.md`
5. Log strategic decisions to `company/decision-log.md`
6. Update `company/overview.md` Success Criteria for next quarter

**Output:** strategic alignment for next 90 days. Renewal momentum.

---

## Ad-Hoc — When Things Happen

### Client request lands
→ Run `gtm-skills/client-request-handler.md`. Route, log, action.

### Reply received
→ Run `gtm-skills/reply-handler.md`. Classify, respond, log.

### Campaign performance drops
→ Run `gtm-skills/campaign-optimiser.md`. Diagnose, recommend, test.

### Deliverability issue
→ Run `gtm-skills/deliverability-doctor.md`. Triage, fix.

### Incident (blacklist, outage, bad reply going public)
→ Run `gtm-skills/incident-responder.md`. Protocol, escalate.

### New client signed
→ Run `gtm-skills/client-onboarder.md`. 5-phase setup.

### Client churns / engagement ends
→ Run `gtm-skills/client-offboarder.md`. Final report, archive, learnings.

---

## Cadence Summary

| Cadence | Duration | Skill |
|---------|----------|-------|
| Daily morning | 10 min | Manual + reply-handler |
| Daily evening | 5 min | Manual logging |
| Monday | 1 hour | client-health-scorer (portfolio) |
| Friday | 2.5-4 hours | weekly-reviewer (triage + full on flagged) + client-report-writer |
| Monthly (per client) | 30 min | Manual review of icp.md, offer.md, test-log.md |
| Quarterly (per client) | 2 hours | qbr-writer |

**Total weekly time for 20 clients:** ~20-25 hours (triage-first Friday).
**Plus monthly:** ~10 hours.
**Plus quarterly:** ~40 hours (spread across the quarter).

---

## What Happens If You Skip

| Skipped | First week | After 2 weeks | After 4 weeks |
|---------|-----------|---------------|---------------|
| Daily morning check | Replies pile up | Hostile reply slips through | Client questions Harry's responsiveness |
| Friday weekly review | OS stops compounding | Test log goes stale | Same mistakes repeat across clients |
| Monthly ICP review | OK | ICP drift unnoticed | Targeting waste compounds |
| Quarterly QBR | OK | Renewal conversation reactive | Client churns without warning |

**Skip the Friday review and the entire OS architecture collapses.** Everything else can be made up. The compounding loop cannot.

---

## How to Start

Week 1 of using this OS:
- Day 1 (Monday) — set up morning routine, configure Instantly alerts
- Day 5 (Friday) — first weekly review. Will take 4-5 hours because no patterns exist yet
- Day 10 — second weekly review. Will be 3 hours because some patterns logged
- By Day 20 — weekly review is 2-3 hours and getting easier

After 8 weeks the routine is automatic. The OS does most of the cognitive work.