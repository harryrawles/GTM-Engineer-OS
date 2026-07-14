---
name: client-checkin-writer
description: Three-times-weekly relationship and visibility check-in for every client (or one, on demand) - Monday plan, Wednesday results, Friday recap + next-week scope. Warm, casual, never a performance report. Distinct from workspace-deep-report.md's performance deep-dive and client-report-writer.md's fixed data report.
triggers:
  - "Monday check-in for {{client}}"
  - "Monday check-in for all clients"
  - "Wednesday check-in for {{client}}"
  - "Wednesday check-in for all clients"
  - "Friday check-in for {{client}}"
  - "Friday check-in for all clients"
  - "weekly check-in for {{client}}"
  - "client check-ins"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/campaign-state.md, comms-log.md, decision-log.md, overview.md, voice.md"
  - "best-practices/growth-plays.md"
writes:
  - "clients/{slug}/comms-log.md (every sent check-in, outbound entry, on confirmation)"
---

# Skill: Client Check-in Writer

**Trigger:** "Monday check-in for {{client}}", "Wednesday check-in for {{client}}", "Friday check-in for
{{client}}", any of the three "for all clients", or "weekly check-in for {{client}}" (ambiguous day - ask
which of Mon/Wed/Fri before proceeding).

**Context:** This is relationship maintenance, not performance reporting, run three times a week now
(Monday, Wednesday, Friday), manually triggered by the GTME each time. Whether a client is thriving or
stuck, they should never wonder what's happening with their account. The three days do different jobs:

- **Monday** - here's the plan for this week.
- **Wednesday** - here's how it's actually going, stated plainly, no positive spin.
- **Friday** - here's what got done this week, and here's the scope for next week.

If a client isn't getting the volume or results they want yet, every one of these three messages is a
chance to show the GTME is already working towards it, before they have to ask - the plan, and the
light at the end of the tunnel, is what keeps a client backing you through a slow patch. This is never
optional and never skipped just because the week is quiet.

**Not the same as:**
- `gtm-skills/workspace-deep-report.md` - an on-demand, GTME-triggered deep performance analysis for one
  account under risk, ending in a scenario-matched message. Unaffected by this skill.
- `gtm-skills/client-report-writer.md` - the fixed, under-300-word standard weekly performance report
  (metrics table, campaign breakdown). Unaffected by this skill.

This skill never reports a PRR table. Monday and Friday report **what's planned / what happened
operationally**; Wednesday reports **results, factually**. None of the three ever slides into the metrics
table format owned by the two skills above.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads
below.

## SKILL-SPECIFIC READS

**MUST READ (every time, every day):**
- `clients/{slug}/comms-log.md` - **not just the last check-in.** Read back through the most recent
  Monday, Wednesday, and Friday entries (whichever have already run this week, plus enough history to
  catch anything still open). Every one of the three days depends on knowing what the other two already
  said - Wednesday must not repeat Monday's plan, Friday must recap against what Monday actually promised,
  and the following Monday must pick up wherever Friday left the "next week" thread. Continuity across all
  three is mandatory, not a nice-to-have.
- `clients/{slug}/campaign-state.md` - Active Campaigns table, Paused/Completed table, State Notes, for
  anything already logged this week
- `clients/{slug}/decision-log.md` - recent decisions or tests worth mentioning, and prior growth-play
  proposals (for the rotation check)
- `clients/{slug}/overview.md` - call cadence, so a call reminder is only mentioned if one is actually
  scheduled this week
- `clients/{slug}/voice.md` - tone, register, banned words
- `best-practices/growth-plays.md` - the shared idea bank, checked for a play that fits this client's
  current state and hasn't been proposed recently

**Instantly reads now run every day this skill fires** (Monday, Wednesday, and Friday alike) - not just
Wednesday. Monday needs the same data to build the week's plan and to surface a suggested move; Friday
needs it to confirm what actually happened. See Step 1.

---

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars, include Mon/Wed/Fri}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end, this captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt, no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement
loop breaks.

---

## STEP 1 - GATHER WHAT'S KNOWN (per client, every day)

Pull what's visible, don't ask the GTME for anything this step can answer on its own:

**From the client folder:**
- `comms-log.md` - the most recent Monday/Wednesday/Friday entries (see Reads above), any open "Action
  needed" rows, any unresolved client question
- `campaign-state.md` - Active Campaigns status (Active/Paused), any State Notes dated this week
- `decision-log.md` - any decision or test logged this week worth a mention, and any growth-play already
  proposed in the last 4 weeks (see `best-practices/growth-plays.md` Rotation Discipline)

**From Instantly (reads only, runs automatically, via `.claude/bin/instantly.sh`), every day this skill
runs:**
- `GET /campaigns` - is each campaign Active or Paused right now, does that match what `campaign-state.md`
  last recorded (flag if it's drifted)
- `GET /campaigns/analytics/daily` (last 7 days vs prior 7) - send-volume and reply trend, up, down, or
  flat
- `POST /leads/list` (sorted by most recently added) - whether any leads were added in the last 7 days

**Analyse, don't just report.** Look at what the data actually shows (volume drop, reply rate flat,
campaign near the end of its list, data running low) and form a plain-language read on what it means and
what move it suggests - a test, a data top-up, a pause, a growth-play. This analysis feeds:
- **Monday** - becomes a suggested focus for the week, put to the GTME in Step 2 for a yes/no/adjust
  before it ever reaches the client.
- **Wednesday** - becomes the factual results statement (see Step 3, no positive spin).
- **Friday** - becomes the confirmation of what actually got done, checked against Monday's plan.

**Growth-play check (any day):** if the client's campaign has been live 3+ weeks with a meaningful
non-reply pool, and no play has been proposed in the last 4 weeks per the Rotation Discipline, note which
`best-practices/growth-plays.md` entry fits best as a candidate for Step 3. If nothing fits, or one was
proposed recently, don't force one in. A growth-play can surface on any of the three days - it isn't tied
to one.

---

## STEP 2 - ASK THE GTME FOR THE REST

Instantly and the client folder can't see everything, and Monday specifically needs the GTME to confirm
the week's plan before it's put to a client. Ask only for what Step 1 couldn't determine, in one short
batch, and skip anything Step 1 already answered.

**Monday-specific:** present the Step 1 analysis and suggested focus for each client ("reply rate's flat
this week, suggest we test a new subject line" / "list's thinning, suggest a data top-up") and ask the GTME
to confirm, adjust, or drop each one before it becomes the week's plan. Also ask:
- Anything already decided for this week that Instantly/the files wouldn't show yet (a new campaign
  going live, a manual fix in progress)?
- Any call scheduled with this client this week?

**Wednesday-specific:**
- Any credits, tooling, or data-source constraint this week? (not visible via the Instantly API)
- Anything operationally worth flagging that Step 1 couldn't see?

**Friday-specific:**
- Confirm whether Monday's planned items actually happened (Step 1's Instantly read should already
  confirm most of this - only ask about what it can't see, e.g. a manual task or a client-side dependency)
- Anything already decided for next week that Instantly/the files wouldn't show yet?

If nothing applies, move on, don't force an answer into every field.

**Portfolio mode:** present this as one compact list, one row per active client, rather than a separate
question per client, so the GTME can fill in exceptions in a single pass and leave the rest blank.

---

## STEP 3 - DRAFT THE CHECK-IN

Always warm and casual, in the client's voice (`clients/{slug}/voice.md`). None of the three days
calibrates tone by performance - every check-in reads as genuinely engaged regardless of the numbers, and
every one of the three carries the plan / light-at-the-end-of-tunnel principle from the Context section
above when a client isn't yet getting the results they want.

### Monday - THE PLAN

1. **Warm opener** - a genuine "happy Monday", matched to the actual day, not a template filler.
2. **This week's focus** - what's happening for this client this week, built from Step 1's analysis plus
   whatever the GTME confirmed in Step 2. Concrete, not vague ("we're testing a new subject line on the
   ops campaign this week" not "we're continuing to optimise").
3. **Optional growth-play idea** - only if Step 1 surfaced one that fits and hasn't been proposed recently.
4. **Light ask, only if there's a real one** - e.g. confirming a preference before the week's test goes
   out. Not mandatory - don't manufacture a question for its own sake.
5. **Warm sign-off**, mention the call only if Step 2 confirmed one is actually scheduled this week.

### Wednesday - THE RESULTS CHECK-IN

**No positive assumptions, regardless of volume.** State what Step 1 confirmed plainly - facts, not
framing. "12 leads added this week, reply rate's holding at the same level as last week" is correct even in
a strong week; "great week, leads are flying in" is not - that's an assumption about how the client
experiences it, not a fact. Don't editorialise in either direction; a quiet week is stated exactly as
plainly as a busy one.

1. **Warm opener** - a real greeting, matched to the actual day.
2. **Operational update** - what happened this week, using only what Step 1 confirmed or the GTME
   confirmed in Step 2. Never invent an update, if nothing changed this week, say so plainly and keep the
   message short rather than manufacturing busywork.
3. **The genuine ask, if there's a real one** - how the replies are landing, whether the right kind of
   people are coming through, whether anything has closed off the back of them. Not mandatory every single
   week if it was asked and unanswered days ago and nothing's changed since - but this is the day most
   likely to carry it, since results are the whole point of Wednesday.
4. **If there's an operational hiccup** (credits, a pause, a delay) - disclose it plainly and proactively,
   per `sops/client-not-getting-results.md` Step 1 and 2, never communicate a problem without a plan and a
   timeline attached. Say what's happening, why, and when it resolves.
5. **Warm sign-off**, mention the call only if Step 2 confirmed one is actually scheduled this week.

### Friday - THE RECAP + NEXT WEEK

1. **Warm opener** - a real greeting, matched to the actual day (winding down the week, not "happy
   Friday" as filler).
2. **Recap of what got done** - checked against Monday's plan (from comms-log.md), confirmed by Step 1's
   Instantly read where possible. If something planned on Monday didn't happen, say so plainly along with
   why and when it'll land instead - this is another light-at-the-end-of-tunnel moment, not something to
   quietly drop.
3. **Scope for next week** - what's coming, built the same way as Monday's plan (Step 1 analysis + Step 2
   confirmation). This is what next Monday's message picks up and confirms - don't leave it vague if it's
   going to be referenced again in three days.
4. **Optional growth-play idea** - only if Step 1 surfaced one that fits and hasn't been proposed recently
   and wasn't already raised earlier in the week.
5. **Light ask, only if there's a real one.**
6. **Warm sign-off.**

Keep every version short and conversational, the length and register of the four examples the GTME
provided, not a report. Sign off as Harry, not the company.

---

## STEP 4 - PRESENT AND CONFIRM

Show the draft. Ask explicitly: **"Send this to {{client}}? (Y/N)"** and wait.

Sending is external client comms, per root `CLAUDE.md` Safety Guard rule 1 it needs the GTME's explicit
approval every time. This skill only drafts, it never sends on its own.

**Portfolio mode:** present each client's draft with its own Y/N, in full isolation, sending one client's
message never depends on another's answer.

---

## STEP 5 - LOG THE SEND

On yes, append an outbound entry to `clients/{slug}/comms-log.md` using its existing format:

```
### {{YYYY-MM-DD HH:MM}} - Slack/Email {{whichever channel}} Outbound

**With:** {{Client contact}}
**Topic:** {{Monday check-in / Wednesday check-in / Friday check-in}}

**Summary:** {{1-2 lines - what was reported/planned/recapped, and what was asked, if anything}}

**Action needed:**
- [ ] {{only if a genuine ask was made - what's awaited, by when}}

**Outcome:** {{filled in once the client replies, if an ask was made}}
```

Always log which day this was in the Topic line - this is exactly what the next check-in's Step 1 read
depends on to keep Monday/Wednesday/Friday threaded together correctly. If a growth-play idea was
proposed, note which one in the Summary line, that's what the Step 1 Rotation Discipline check reads next
time to avoid repeating it too soon.

On no, don't write anything, the draft stays in this conversation only.

---

## PORTFOLIO MODE

Triggered by "{{Monday|Wednesday|Friday}} check-in for all clients". Loop every active client folder under
`clients/` (skip any subfolder starting with `_` or `.`, per `wiki/_skill-context.md`), running Steps 1-5
once per client in full isolation. Never let one client's operational facts, growth-play history, or
comms-log content leak into another client's draft.

Batch Step 2's questions into a single consolidated list across the whole portfolio (one row per client)
to keep it to one pass, then draft and confirm each client's message individually in Steps 3-5.

---

## RULES

- Three fixed cadence points a week - Monday (plan), Wednesday (results), Friday (recap + next week) -
  manually triggered by the GTME each time, never assumed or auto-run.
- Always warm, never performance-graded in tone. This skill does not vary its warmth by Green/Amber/Red,
  that banding belongs to `workspace-deep-report.md` and `weekly-reviewer.md`.
- **Wednesday never assumes positive sentiment from good volume.** State facts plainly regardless of how
  strong or quiet the week was.
- Every one of the three days carries the plan / light-at-the-end-of-tunnel principle for a client not yet
  getting results - visibility into the plan is what keeps a client backing you through a slow patch, and
  this is never dropped just because the news is thin.
- Never invent an operational update, a plan item, or a recap claim. State only what Step 1 confirmed via
  Instantly/the client folder, or what the GTME explicitly confirmed in Step 2.
- A "genuine ask" is optional on every day, include one only when there's a real question to ask, don't
  manufacture one for its own sake.
- Growth-play ideas only come from `best-practices/growth-plays.md`, never improvised on the spot, and
  never proposed to the same client twice within 4 weeks, per its Rotation Discipline.
- Never communicate an operational hiccup or a missed plan item without a plan and a timeline attached,
  per `sops/client-not-getting-results.md`.
- Nothing is sent without an explicit Y/N from the GTME, no exceptions.
- Every sent check-in is logged to `clients/{slug}/comms-log.md` with the day in the Topic line - this is
  the continuity record that Monday/Wednesday/Friday all read back through before drafting.
- Portfolio mode keeps every client fully isolated, full stop.

---

## QA CHECKLIST

Before presenting a draft:

- [ ] Correct client resolved (or full portfolio loop, isolated per client) before drafting?
- [ ] Correct day's structure used (Monday plan / Wednesday results / Friday recap + next week), not a
      generic template?
- [ ] `comms-log.md` read back through the recent Mon/Wed/Fri entries, so this message doesn't repeat or
      contradict what the other two already said this week?
- [ ] Every operational, plan, or recap claim traceable to Step 1's pull/analysis or Step 2's GTME
      confirmation, nothing invented?
- [ ] Wednesday only: no positive framing added on top of the plain facts, even in a strong week?
- [ ] If results are thin or a plan item slipped: a concrete plan and timeline included, not just a bare
      acknowledgement?
- [ ] Genuine ask, if included, is specific - not a generic "let me know if you need anything" - and not
      forced in where there's nothing real to ask?
- [ ] Any growth-play proposed actually came from `best-practices/growth-plays.md` and wasn't proposed to
      this client in the last 4 weeks?
- [ ] Message shown with an explicit Y/N before anything is sent, per Safety Guard rule 1?
- [ ] Sent message logged to `clients/{slug}/comms-log.md` with the day, channel, summary, and any pending
      action?
