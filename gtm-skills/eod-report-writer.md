---
name: eod-report-writer
description: Produces the portfolio-wide end-of-day report for Slack (MOVED/BLOCKED/NEXT), reconstructed from the day's session trail. Portfolio-wide by nature - does not require an active client.
triggers:
  - "EOD report"
  - "End of day report"
  - "Wrap up my day"
  - "Close out the day"
  - "Daily report"
  - "What did I get done today"
  - "Run my EOD"
reads:
  - ".claude/sessions/*.jsonl (primary source)"
  - "clients/{slug}/session-log.md, comms-log.md, decision-log.md, campaign-state.md, test-log.md"
  - "wiki/_skill-context.md"
writes:
  - "clients/{slug}/session-log.md (one row per client touched today)"
---

# Skill: EOD Report Writer

**Trigger:** "EOD report", "End of day report", "Wrap up my day", "Close out the day", "Daily report", "What did I get done today", "Run my EOD"

**Context:** Produces the end-of-day report the GTME posts to the team Slack. This is the skill for the **Daily - End of Day Wrap** slot in `OPERATING-RHYTHM.md` (previously "manual logging"). It is **portfolio-wide by nature** - it summarises the whole day across every client worked on, so it does **not** require an active client. The report is outcomes-based: every line answers "what actually changed today?" or "what changes next?" - never a narration of process. Three sections: **MOVED** (pushed forward), **BLOCKED** (barriers in the way), **NEXT** (what happens next). Output is a plain-text Slack message - never auto-sent.

**The lever this report exists to show:** not how many clients got touched (activity theatre), but how many **stagnant** accounts got genuinely fixed and how often **good** accounts got pushed further. "Added leads" and "reworked copy" describe activity, not outcome - they say nothing about whether the account was diagnosed or moved. See STEP 2 and STEP 3 below for the bar every bullet has to clear.

**Cadence:** End of every working day (~5 min). Skipping a day is fine - the raw audit trail in `.claude/sessions/` persists, so a missed day can be reconstructed later.

**Reporter:** Defaults to **the GTME** (per `CLAUDE.md`). Only override if someone else is filing.

---

## READS

- `.claude/sessions/*.jsonl` - the raw Claude Code audit trail written by `.claude/hooks/session-logger.sh`. **Primary source - this is "everything that happened in Claude Code today."** Filter to today's date. `user_prompt` events give intents; `tool_start` events give the concrete actions (Instantly mutations, Gmail/Slack sends, writes into `clients/{slug}/`); `tool_fail` events surface what broke; `session_end` summaries give a top-tools digest.
- `clients/{slug}/session-log.md` (Active Log) - today's skill-invocation rows per client, with the one-line outcome column already recorded. Cross-reference against the raw trail.
- `clients/{slug}/comms-log.md` - client comms logged today.
- `clients/{slug}/decision-log.md` - decisions logged today.
- `clients/{slug}/campaign-state.md` - health / state changes today (BLOCKED candidates: Red health, warmup disabled, paused campaigns). **Also read for STEP 2** - Launch date and current PRR/health per campaign are what the stagnant-account check runs against.
- `clients/{slug}/test-log.md` - tests launched or queued today (NEXT candidates).
- `wiki/_skill-context.md` - session-log write rules (portfolio note below).
- Instantly API (via `.claude/bin/instantly.sh`) - **optional, light touch only.** Confirm meetings/opps booked today for outcome bullets. Also acceptable use: confirming lifetime sends or launch date for the STEP 2 stagnant check if `campaign-state.md` isn't current. Do **not** pull full metrics - that is `client-report-writer` / `weekly-reviewer` territory.

## WRITES

- `clients/{slug}/session-log.md` - one STEP 0 row per client that appears in the report (see below). No other writes.

---

## STEP 0 - Log Invocation (mandatory)

This skill runs in **portfolio mode** and does **not** require an active client (do not stop to ask which client - the `wiki/_skill-context.md` "stop and ask" rule is for client-specific tasks; this one is not).

Resolve the set of clients worked on today first (from `.claude/sessions/*.jsonl` + per-client `session-log.md` rows dated today), then append one row to each of those clients' `clients/{slug}/session-log.md` Active Log:

```
| YYYY-MM-DD HH:MM | EOD report | eod-report-writer | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START - right after resolving today's client set, before writing the report.
- Paraphrase - no raw prospect names, emails, or sensitive data.
- Skill name only (no path).
- Outcome column filled at end (e.g. "EOD posted - 6 clients, 0 blockers").

If no client can be resolved (nothing logged today), skip the per-client rows and tell the GTME there is no activity to report - do not invent any.

---

## STEP 1 - Reconstruct the day

1. List `.claude/sessions/` and read every `.jsonl`. Keep only lines whose `ts` is today (the hook writes UTC - allow for the local-day boundary if a session runs late). If a session spans midnight, include only today's portion.
2. From `user_prompt` events, extract the abstract intent of each prompt (what the GTME set out to do).
3. From `tool_start` events, extract the concrete actions - especially:
   - Instantly mutations (activate / pause / create campaign, add / enrich leads, update sequence)
   - Gmail / Slack sends (client comms)
   - Writes into `clients/{slug}/` files (copy, decisions, state)
4. From `tool_fail` events, note anything that broke or stalled mid-execution.
5. Cross-reference each client's `session-log.md` today rows for the one-line outcomes already recorded.
6. Attribute every item to a client folder. Cross-client actions go in an **All Clients** bucket.

**Fallback:** if `.claude/sessions/` is empty or the hook is not installed, use the per-client `session-log.md` today rows plus this conversation, and note in your reply that the raw trail was unavailable (so the GTME knows the report may be thinner than reality). Never pad the gap with invented work.

## STEP 2 - Classify each touched account before writing a single bullet

For every client with activity today, before deciding what to write, work out which of three situations it's actually in. This classification is what STEP 3's bullet rules key off - do this first, not as an afterthought.

**Is the account stagnant?** A campaign is stagnant if it has crossed **either** threshold below **and** results are weak:
- Lifetime sends ≥ 10,000, **or**
- Days live ≥ 14 (today minus Launch date in `campaign-state.md`'s Active Campaigns row)
- **and** current PRR is Amber or Red (under 0.5% - per `sops/campaign-performance-standards.md`)

If both conditions hold, this account is a **red flag** - whatever was done on it today must be reported as a diagnosis-and-fix (STEP 3, Template A), not a plain activity line.

**Is the account healthy and was it deliberately pushed further today?** Green health, and today's work specifically scaled or expanded it - more volume, a new signal, a new ICP segment, a new channel. If so, report it as a push (STEP 3, Template B).

**Otherwise** - routine work: onboarding, comms, admin, reporting, a launch with no prior problem to diagnose. Report it plainly (STEP 3, Template C) but still name the concrete reason or result - never a bare activity description.

**Diagnostic order - check strategy before copy.** When an account is stagnant, do not default to "the copy is wrong." Work the cause in this order, per `gtm-skills/campaign-optimiser.md`'s diagnostic funnel: deliverability first, then targeting/list quality, then offer, then copy, then sequence. Copy is the last place to land, not the first. State which cause you landed on **and** which more-upstream cause you ruled out - that's what proves the diagnosis happened rather than being assumed.

**Before writing a stall into the report, confirm the tools were actually used.** A stagnant account that's merely reported as "still not working" without evidence that `campaign-optimiser.md` was run, the Instantly data was actually pulled, or a teammate was looped in, is activity theatre with an "I'm blocked" label on it instead of a "here's what I did" label. This is guidance, not an automated gate - but if a stagnant account shows up with nothing done on it today, say so plainly rather than writing a bullet that implies work happened.

## STEP 3 - Categorise by client, then section

For each client, sort items into:

**MOVED - pushed forward today.** Completed or progressed work. Every bullet must show *why*, not just *what* - a description of activity with no reasoning or result attached does not qualify, no matter how much happened. Three bullet shapes, by the STEP 2 classification:

- **Template A - stagnant-fix.** `{{Client}} - {{quantified symptom}}, {{named cause}} not {{cause ruled out}}, {{action taken}}, {{status/timing}}.`
  > `Acme - 0 opps on 30k sends, offer's unclear not targeting, rewrote the hook, live Thurs.`
  Compare the weak version this replaces: `Reworked copy for Acme.` Same length, only one proves the account was actually diagnosed.

- **Template B - good-account push.** `{{Client}} - {{lever pushed}}, {{why / expected or observed impact}}.`
  > `Acme - scaled sends 20/day to 50/day off sustained Green health, expect proportional opp lift by next week.`
  > `Acme - added a funding signal on top of hiring, roughly doubles addressable volume.`
  "Account's healthy, nothing changed" is not a push and does not belong in MOVED - if nothing was scaled or expanded today, it doesn't get a bullet just for being touched.

- **Template C - everything else.** State the concrete reason or result, not the bare action. "Awaiting approval" belongs **here** - the work got done, it is just pending review.
  > Weak: `Enriched leads for Acme.` Better: `Enriched 400k companies for Acme to clear the TAM ceiling flagged last week.`

**BLOCKED - barriers in the way.** Genuine hard blockers only: data quality halting a campaign, churn risk, a client constraint with no clear path forward, an unmet external dependency, or a `tool_fail` that stopped progress. A stagnant account is **not** automatically a blocker - it's a MOVED (Template A) candidate if it was worked today, or it's simply absent from the report if it wasn't touched at all (portfolio-wide staleness sweeps are `client-health-scorer.md`'s job, not this one's). If nothing qualifies, write `* N/A`. A *potential* blocker can be flagged inside a MOVED bullet ("May move this to Blocked.") rather than forced here.

**NEXT - what happens next.** Planned but not-yet-done work: queued tests, target launch dates, deliverables owed, tomorrow's plan.

Rules while categorising:
- **Consolidate.** A dozen prompts on one campaign becomes one or two outcome bullets, not twelve.
- **Quantify** from the trail wherever possible (leads enriched, campaigns shipped, lists built, sends, opps).
- **Never invent.** Every bullet traces to the session trail, a client log, or Instantly. If unsure, leave it out. Never invent a cause, a lever, or an impact number just to fit a template - if the diagnosis genuinely wasn't done today, Template C plus an honest note is correct; a fabricated Template A bullet is worse than an admission nothing was diagnosed.

## STEP 4 - Output the report

Plain text for Slack. Exact structure:

```
EOD Report - {{Name}} - {{Weekday, Month D, YYYY}}

MOVED

{{Client}}

* {{outcome}}
* {{outcome}}

{{Client}}

* {{outcome}}

BLOCKED

* N/A

NEXT

{{Client}}

* {{planned action}}
```

Spacing: one blank line above and below each section label (MOVED / BLOCKED / NEXT), and one blank line between each client block. Client name on its own line, plain text, no colon. Bullets start with `* `.

Then present it and offer delivery (see RULES). Fill the STEP 0 outcome column.

## STEP 5 - Close the loop (one-line nudge)

After presenting, if the trail shows any of the rest of the `OPERATING-RHYTHM.md` EOD wrap is still outstanding, remind the GTME in a single line: log any client comms to `comms-log.md`, update `decision-log.md` for decisions made, and commit changed client files. One line, not a lecture.

---

## RULES

- **Never auto-send.** Posting to Slack / sending external comms is hard-blocked by the Safety Guard (`.claude/hooks/safety-guard.sh`; CLAUDE.md Safety Guard rule 1). Present the report as a draft. Only create a Slack **draft** if the GTME approves and names the channel.
- **Portfolio, not client-specific.** Do not ask for an active client - report across everyone worked on today.
- **Never invent** outcomes, numbers, causes, or client names. No activity today - say so plainly.
- **No bare activity bullets.** "Added leads," "reworked copy," "worked on X," "followed up" are not complete bullets on their own - every bullet pairs the action with a diagnosed cause, a named lever, or a concrete result (STEP 3).
- **Plain text only.** No markdown headings, bold, or tables in the report body - it is pasted straight into Slack.
- **Numbers as digits** (5, not five), per CLAUDE.md Behaviour Rules.
- **UK English default** (per CLAUDE.md). This is an internal ops message, so a client's `voice.md` does not apply.
- **Avoid OS banned words:** "leverage", "synergy", "game-changer", "revolutionary", "cutting-edge", "hope this helps".
- **Privacy.** Paraphrase intents; keep raw prospect names / emails out of the report.
- **Keep bullets tight** - one outcome each, one to two sentences. Diagnostic detail (Template A) fits in the same length as a vague bullet; it does not need to be longer, just more specific.
- **Not every client appears in every section.** A client with only planned work shows under NEXT only.

---

## OUTPUT EXAMPLE

See `examples/sample-eod-report.md` for the full worked example. Abbreviated:

```
GTME: wrap up my day

Claude:
[STEP 0] Portfolio mode - resolving today's clients from .claude/sessions/*.jsonl + session logs... 6 clients touched. Logging invocation to each.
[STEP 1] Reconstructing the day from the raw trail... done.
[STEP 2] Classifying: CLIENT_A stagnant (32k sends, 18 days live, PRR 0.4%) - flagged for diagnosis. CLIENT_D Green, volume scaled today - push. Rest routine.

EOD Report - GTME - Friday, July 3, 2026

MOVED

{{CLIENT_A}}

* 0 opps on 32k sends, offer's unclear not targeting, rewrote the hook, live Thurs.

{{CLIENT_D}}

* Scaled sends 20/day to 50/day off sustained Green health, expect proportional opp lift next week.

BLOCKED

* N/A

NEXT

{{CLIENT_C}}

* Set up all four campaigns with the updated copy. Target Tuesday launch.

---
Draft ready. I can't send it - the Safety Guard blocks external posts - but name a channel and I'll drop it in as a Slack draft for you to review.
Reminder: {{CLIENT_A}} comms not yet in comms-log.md, and 3 client files are uncommitted.
```
