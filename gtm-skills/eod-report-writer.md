# Skill: EOD Report Writer

**Trigger:** "EOD report", "End of day report", "Wrap up my day", "Close out the day", "Daily report", "What did I get done today", "Run my EOD"

**Context:** Produces the end-of-day report Harry posts to the team Slack. This is the skill for the **Daily — End of Day Wrap** slot in `OPERATING-RHYTHM.md` (previously "manual logging"). It is **portfolio-wide by nature** — it summarises the whole day across every client worked on, so it does **not** require an active client. The report is outcomes-based: every line answers "what actually changed today?" or "what changes next?" — never a narration of process. Three sections: **MOVED** (pushed forward), **BLOCKED** (barriers in the way), **NEXT** (what happens next). Output is a plain-text Slack message — never auto-sent.

**Cadence:** End of every working day (~5 min). Skipping a day is fine — the raw audit trail in `.claude/sessions/` persists, so a missed day can be reconstructed later.

**Reporter:** Defaults to **Harry** (per `CLAUDE.md`). Only override if someone else is filing.

---

## READS

- `.claude/sessions/*.jsonl` — the raw Claude Code audit trail written by `.claude/hooks/session-logger.sh`. **Primary source — this is "everything that happened in Claude Code today."** Filter to today's date. `user_prompt` events give intents; `tool_start` events give the concrete actions (Instantly mutations, Gmail/Slack sends, writes into `clients/{slug}/`); `tool_fail` events surface what broke; `session_end` summaries give a top-tools digest.
- `clients/{slug}/session-log.md` (Active Log) — today's skill-invocation rows per client, with the one-line outcome column already recorded. Cross-reference against the raw trail.
- `clients/{slug}/comms-log.md` — client comms logged today.
- `clients/{slug}/decision-log.md` — decisions logged today.
- `clients/{slug}/campaign-state.md` — health / state changes today (BLOCKED candidates: Red health, warmup disabled, paused campaigns).
- `clients/{slug}/test-log.md` — tests launched or queued today (NEXT candidates).
- `wiki/_skill-context.md` — session-log write rules (portfolio note below).
- Instantly MCP — **optional, light touch only.** Confirm meetings/opps booked today for outcome bullets like "2 new opportunities came in off the back of it." Do **not** pull full metrics — that is `client-report-writer` / `weekly-reviewer` territory.

## WRITES

- `clients/{slug}/session-log.md` — one STEP 0 row per client that appears in the report (see below). No other writes.

---

## STEP 0 — Log Invocation (mandatory)

This skill runs in **portfolio mode** and does **not** require an active client (do not stop to ask which client — the `wiki/_skill-context.md` "stop and ask" rule is for client-specific tasks; this one is not).

Resolve the set of clients worked on today first (from `.claude/sessions/*.jsonl` + per-client `session-log.md` rows dated today), then append one row to each of those clients' `clients/{slug}/session-log.md` Active Log:

```
| YYYY-MM-DD HH:MM | EOD report | eod-report-writer | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START — right after resolving today's client set, before writing the report.
- Paraphrase — no raw prospect names, emails, or sensitive data.
- Skill name only (no path).
- Outcome column filled at end (e.g. "EOD posted — 6 clients, 0 blockers").

If no client can be resolved (nothing logged today), skip the per-client rows and tell Harry there is no activity to report — do not invent any.

---

## STEP 1 — Reconstruct the day

1. List `.claude/sessions/` and read every `.jsonl`. Keep only lines whose `ts` is today (the hook writes UTC — allow for the local-day boundary if a session runs late). If a session spans midnight, include only today's portion.
2. From `user_prompt` events, extract the abstract intent of each prompt (what Harry set out to do).
3. From `tool_start` events, extract the concrete actions — especially:
   - Instantly mutations (activate / pause / create campaign, add / enrich leads, update sequence)
   - Gmail / Slack sends (client comms)
   - Writes into `clients/{slug}/` files (copy, decisions, state)
4. From `tool_fail` events, note anything that broke or stalled mid-execution.
5. Cross-reference each client's `session-log.md` today rows for the one-line outcomes already recorded.
6. Attribute every item to a client folder. Cross-client actions go in an **All Clients** bucket.

**Fallback:** if `.claude/sessions/` is empty or the hook is not installed, use the per-client `session-log.md` today rows plus this conversation, and note in your reply that the raw trail was unavailable (so Harry knows the report may be thinner than reality). Never pad the gap with invented work.

## STEP 2 — Categorise by client, then section

For each client, sort items into:

**MOVED — pushed forward today.** Completed or progressed work: shipped / launched / went live, built / created, wrote / rewrote copy, segmented, enriched, fulfilled leads, set up, sent to client for review, approved, onboarded, upsold, prevented churn, reached out. Past-tense outcomes. "Awaiting approval" belongs **here** — the work got done, it is just pending review.

**BLOCKED — barriers in the way.** Genuine hard blockers only: data quality halting a campaign, churn risk, a client constraint with no clear path forward, an unmet external dependency, or a `tool_fail` that stopped progress. If nothing qualifies, write `* N/A`. A *potential* blocker can be flagged inside a MOVED bullet ("May move this to Blocked.") rather than forced here.

**NEXT — what happens next.** Planned but not-yet-done work: queued tests, target launch dates, deliverables owed, tomorrow's plan.

Rules while categorising:
- **Consolidate.** A dozen prompts on one campaign becomes one or two outcome bullets, not twelve.
- **Outcome-first.** "2 new opportunities came in off the back of it" beats "spent time adding leads."
- **Quantify** from the trail wherever possible (leads enriched, campaigns shipped, lists built).
- **Never invent.** Every bullet traces to the session trail, a client log, or Instantly. If unsure, leave it out.

## STEP 3 — Output the report

Plain text for Slack. Exact structure:

```
EOD Report — {{Name}} — {{Weekday, Month D, YYYY}}

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

## STEP 4 — Close the loop (one-line nudge)

After presenting, if the trail shows any of the rest of the `OPERATING-RHYTHM.md` EOD wrap is still outstanding, remind Harry in a single line: log any client comms to `comms-log.md`, update `decision-log.md` for decisions made, and commit changed client files. One line, not a lecture.

---

## RULES

- **Never auto-send.** Posting to Slack / sending external comms is hard-blocked by the Safety Guard (`.claude/hooks/safety-guard.sh`; CLAUDE.md Safety Guard rule 1). Present the report as a draft. Only create a Slack **draft** if Harry approves and names the channel.
- **Portfolio, not client-specific.** Do not ask for an active client — report across everyone worked on today.
- **Never invent** outcomes, numbers, or client names. No activity today — say so plainly.
- **Plain text only.** No markdown headings, bold, or tables in the report body — it is pasted straight into Slack.
- **Numbers as digits** (5, not five), per CLAUDE.md Behaviour Rules.
- **UK English default** (per CLAUDE.md). This is an internal ops message, so a client's `voice.md` does not apply.
- **Avoid OS banned words:** "leverage", "synergy", "game-changer", "revolutionary", "cutting-edge", "hope this helps".
- **Privacy.** Paraphrase intents; keep raw prospect names / emails out of the report.
- **Keep bullets tight** — one outcome each, one to two sentences.
- **Not every client appears in every section.** A client with only planned work shows under NEXT only.

---

## OUTPUT EXAMPLE

See `examples/sample-eod-report.md` for the full worked example. Abbreviated:

```
Harry: wrap up my day

Claude:
[STEP 0] Portfolio mode — resolving today's clients from .claude/sessions/*.jsonl + session logs... 6 clients touched. Logging invocation to each.
[STEP 1] Reconstructing the day from the raw trail... done.

EOD Report — Harry — Friday, July 3, 2026

MOVED

{{CLIENT_A}}

* Client approved the campaign. Shipped it and went live today.

{{CLIENT_B}}

* Enriched 400k companies across the 1-10 and 11-25 headcount ranges.

BLOCKED

* N/A

NEXT

{{CLIENT_C}}

* Set up all four campaigns with the updated copy. Target Tuesday launch.

---
Draft ready. I can't send it — the Safety Guard blocks external posts — but name a channel and I'll drop it in as a Slack draft for you to review.
Reminder: {{CLIENT_A}} comms not yet in comms-log.md, and 3 client files are uncommitted.
```
