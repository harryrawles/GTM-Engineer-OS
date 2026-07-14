---
name: workspace-deep-report
description: On-demand deep-dive analysis of a client's entire Instantly workspace (every campaign, multiple data cuts) to catch performance risk early, ending in a tone-matched client message and, on confirmation, a decision-log/campaign-state entry cold-email-writer.md can draw on next time. GTME picks which client gets one and when, this is not an automated portfolio scan.
triggers:
  - "Weekly report for {{client}}"
  - "deep report for {{client}}"
  - "workspace report for {{client}}"
  - "proactive report for {{client}}"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/campaign-state.md, icp.md, voice.md, decision-log.md"
  - "sops/campaign-performance-standards.md"
writes:
  - "clients/{slug}/decision-log.md (matched scenario + any 3+ objection pattern, on explicit confirmation)"
  - "clients/{slug}/campaign-state.md (refreshed Green/Amber/Red health, on explicit confirmation)"
  - "(the client message itself is never written anywhere, it is presented as a draft and sent externally only on its own separate confirmation)"
---

# Skill: Workspace Deep Report

**Trigger:** "Weekly report for {{client}}", "deep report for {{client}}", "workspace report for {{client}}", "proactive report for {{client}}"

**Context:** The goal is to stay ahead of underperforming campaigns instead of reacting once the client
raises it. This skill is GTME-triggered, one client at a time. There is no automated portfolio scan in
this version, the GTME decides which client needs a deep look this week, based on their own read of risk
(see Risk Scenarios Table below for the patterns worth watching for).

**Why this matters:**
1. **Builds client confidence** - the client sees their campaigns are being actively managed and
   optimised, not left to run unattended.
2. **Prevents reactive conversations** - performance issues get addressed before the client flags them.
3. **Shows a clear plan for improvement** - the report is a structured way to share insight and propose
   next steps, not just a numbers dump.
4. **Reinforces the strategic partnership** - this demonstrates a systematic approach to making outbound
   work, not just "campaigns are running."

**The goal:** after reading the message, the client should feel that their performance is being closely
monitored, that there is a clear plan to improve results, and that the GTME is actively working to make
outbound a reliable lead source for them. This is why Steps 3 and 4 require every message to be built from
a matched scenario with a specific, real next action, a tone-matched message with no concrete plan
attached fails the point of the report.

**Not a replacement for:**
- `gtm-skills/weekly-reviewer.md` - the Friday compounding-loop review (winner/loser logging, test-log,
  decision-log, shared-layer promotion). Unaffected by this skill, except that `campaign-state.md` health
  is a shared field, this skill may refresh it mid-week (Step 6) ahead of the next Friday review, using
  the exact same Green/Amber/Red format so the two never disagree on convention, only on timing.
- `gtm-skills/client-report-writer.md` - the fixed, under-300-word standard weekly client report.
  Unaffected by this skill. This skill is a separate, occasional, much deeper analysis for an account
  under risk, it does not feed into or replace the standard report.
- `gtm-skills/cold-email-writer.md` - reads `decision-log.md` when building on a prior decision, this is
  how a finding logged here (Step 6) becomes available the next time copy gets written for this client.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads
below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `clients/{slug}/campaign-state.md` - known campaign list and last-recorded health, used to spot any
  campaign live in Instantly that campaign-state.md doesn't know about yet
- `clients/{slug}/icp.md` - target ICP, for the job-title breakdown cut
- `clients/{slug}/voice.md` - tone and banned words, for the client message draft
- `clients/{slug}/decision-log.md` - check for an existing recent entry on the same objection pattern
  before logging one in Step 6, `reply-handler.md` may already have logged it
- `sops/campaign-performance-standards.md` - the Green/Amber/Red PRR and bounce bands, reused here for
  tone calibration rather than inventing a new threshold set

---

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end, this captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt, no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement
loop breaks.

---

## RISK SCENARIOS TABLE

This table is load-bearing, not decoration. Step 3 matches the client against it, and the matched row
decides which data points the message must cite and which action plan it must propose. It's also the
reference the GTME uses to judge which client is worth a deep report this week.

| # | Client scenario | Key data to share with the client | Action plan to propose |
|---|---|---|---|
| 1 | Recently launched (2-3 weeks), very little traction (low reply rate) | Emails sent, reply rate, deliverability indicators (bounce rate, spam signals if available) | Diagnose traction issues early: propose testing new messaging angles, adjusting targeting, or reviewing deliverability. Frame this as normal early-stage optimisation. |
| 2 | Recently launched (2-3 weeks), replies but mostly negative | Total replies, positive vs negative reply breakdown, common objections/themes in replies | Use the reply insight to refine messaging and positioning: adjust the value proposition, ICP targeting, or offer framing based on the objection pattern. |
| 3 | Launched 4+ weeks, very little traction (low reply rate) | Total emails sent, reply-rate trend over time, current campaign structure (sequences, targeting segments) | Position as a campaign reset opportunity: new messaging angles, additional lead sources, revised targeting criteria, or sequence restructuring. |
| 4 | Launched 4+ weeks, replies but mostly negative | Reply volume, positive vs negative reply ratio, common objection themes, targeting segments in use | Identify the targeting/messaging misalignment: propose repositioning the offer, testing a new ICP segment, or adjusting how the value proposition is framed. |
| 5 | Launched 4+ weeks, decent positive reply rate, but the client is questioning lead quality | Positive reply rate, example positive replies, lead titles/company types engaging, meeting or qualification outcomes (if available) | Focus on lead qualification and targeting refinement: tighten ICP filters, refine lead sources, or adjust messaging to attract more qualified prospects. |
| - | None of the above, performance is healthy | Standard headline metrics | Simple positive acknowledgement, no corrective plan needed. |

Scenario 5 cannot be detected from Instantly data alone, "questioning lead quality" is a client-stated
concern, not a metric. Only match scenario 5 when the GTME confirms that's the reason for the report (see
Step 3).

---

## STEP 1 - DATA PULL (Instantly API, reads only, runs automatically)

Pull via `.claude/bin/instantly.sh` (see `sops/instantly-api.md`). Default window: **last 7 days**. If the
GTME names a different window (a date range, "since launch", etc.), use that instead and state it clearly
at the top of the output.

For **every campaign currently in the workspace** (not just the ones already tracked in
`clients/{slug}/campaign-state.md`, flag any gap between the two):

1. `GET /campaigns` - campaign list, name, status, and first-step subject/body for the description cut
2. `GET /campaigns/analytics` (`ids` = every campaign, `start_date`/`end_date` = the window) - per-campaign
   sends, opens, replies, bounces
3. `GET /campaigns/analytics/overview` (same `ids`/window) - aggregated workspace totals
4. `GET /campaigns/analytics/steps` (per campaign) - reply distribution by sequence step
5. `GET /emails` (`email_type=received`, `min_timestamp_created`/`max_timestamp_created` = the window,
   per `campaign_id`) - reply text and timestamps
6. `POST /leads/list` (per campaign, or workspace-wide) - `job_title` is a native lead field, used for
   the job-title performance cut in Step 2.
7. Reply sentiment - use the workspace's lead-label / interest-status data (`interest_status_label`
   positive/negative/neutral, `lt_interest_status`) to split replies into positive/negative and to exclude
   automated ones (out-of-office, bounce-backs, wrong-person) from the reply analysis and timestamp cuts.

If the API can't be reached (missing/invalid key, `[HTTP 401]`), ask the GTME to paste the data. Do not
estimate or carry over numbers from memory.

---

## STEP 2 - BUILD THE DATA CUTS (internal, GTME-facing only)

None of this goes to the client. It's what the GTME reads to decide what to say. Build all six cuts
every time, mark any cut "not available for this client" rather than omitting it silently.

### 2.1 Campaigns Launched
One line per campaign, maximum 20 words: the pain point, the value proposition, and the CTA it's testing.
Not descriptive, just the three elements. Respect a custom timeframe if the GTME gave one.

```
{{Campaign name}} - Pain: {{...}}. Value prop: {{...}}. CTA: {{...}}.
```

### 2.2 Overall Stats (aggregated)
One table, one column, totals across every campaign for the window. Default excludes Unsubscribes,
Meetings Booked, Meetings Completed, and Deals Closed (these need CRM-side data the OS doesn't reliably
have from Instantly alone), include them only if the GTME asks and the workspace tracks them.

| Metric | Total |
|---|---|
| Sends | {{n}} |
| Opens | {{n}} |
| Replies | {{n}} |
| Positive replies | {{n}} |
| Bounces | {{n}} |
| PRR | {{%}} |
| Bounce rate | {{%}} |

### 2.3 Performance Breakdown by Campaign
Same metrics as 2.2, one column per campaign, not aggregated.

| Metric | {{Campaign A}} | {{Campaign B}} | ... |
|---|---|---|---|
| Sends | | | |
| PRR | | | |
| Bounce rate | | | |

### 2.4 Performance Breakdown by Job Title Targeted
Group by title/title family, show sends and PRR per group.

### 2.5 Reply Analysis
Non-automated replies only (per Step 1.7). Summary table of the objections/themes seen, with a count and
one representative (anonymised where sensitive) example per theme.

| Theme | Count | Example |
|---|---|---|
| {{e.g. "Already have a vendor"}} | {{n}} | {{short quote}} |

### 2.6 Timestamp Analysis
Non-automated replies only. Bucket by day of week and hour-of-day sent, surface the 2-3 windows with the
highest reply density. State the sample size, if it's too small to be meaningful (under ~20 replies) say
so instead of asserting a pattern.

---

## STEP 3 - MATCH THE SCENARIO

Before drafting anything, match the client against the Risk Scenarios Table above using the data from
Step 1/2:

1. **Launch age.** Read `campaign_schedule.start_date` from the campaign object (`GET /campaigns` /
   `GET /campaigns/{id}`) for the campaign this report is really about (the one prompting the check, or
   the newest active one if the GTME didn't name one). Recently launched = 21 days or under since
   `start_date`. Established = 28 days or over. 22-27 days is a grey zone, use judgement and say which way
   you leaned and why.
2. **Traction.** Very little traction = reply rate at or under the internal floor in
   `sops/campaign-performance-standards.md` (0.2%), or so few replies the rate isn't meaningful yet. Has
   replies = above that floor.
3. **Sentiment split** (only if it has replies). Use the Step 1.7 lead-label data: mostly negative =
   negative replies outnumber positive, mostly positive = positive at or ahead.
4. **Ask the GTME once, before drafting:** "Is there a specific reason for this report, e.g. the client
   raised a lead-quality concern?" Scenario 5 only applies if the GTME confirms that, never infer it from
   metrics alone, a decent PRR with no stated concern is just a healthy account, not scenario 5.

Match to exactly one row:

| Launch age | Traction | Sentiment | GTME flag | Scenario |
|---|---|---|---|---|
| Recent (<=21d) | Very little | - | - | 1 |
| Recent (<=21d) | Has replies | Mostly negative | - | 2 |
| Established (>=28d) | Very little | - | - | 3 |
| Established (>=28d) | Has replies | Mostly negative | - | 4 |
| Established (>=28d) | Has replies | Mostly positive | Lead-quality concern confirmed | 5 |
| Anything else | | | | None, healthy |

State which scenario matched and why (one line, citing the specific numbers that drove the match) before
moving to Step 4.

---

## STEP 4 - CALIBRATE THE CLIENT MESSAGE

Classify the week using the same Green/Amber/Red bands `weekly-reviewer.md` Step 6 already computes from
`sops/campaign-performance-standards.md` (PRR and bounce thresholds), don't invent a separate scale, this
sets the overall register:

- **Green, no scenario matched → Positive tone.** Strong PRR, solid positive reply volume.
- **Amber, or scenario 1/2/5 matched → Neutral tone.** Reasonable activity, something specific is being
  tightened.
- **Red, or scenario 3/4 matched → Negative tone.** Little or no traction, targeting/messaging
  misalignment, or bounce/deliverability trouble.

Draft the message in the client's voice (`clients/{slug}/voice.md`), matching the tone banded above. Every
message must cite the exact "Key data to share" points from the matched scenario's row, and its plan must
follow that row's "Action plan to propose", not a generic substitute. Keep each one to 2-4 sentences,
specific, no filler:

**Positive (no scenario matched):**
> Great results this week, {{client}}, strong reply volume and solid positive engagement. Pleased with
> the direction things are heading. {{Optional: proposal to feature as a case study.}}

**Neutral (scenario 1, 2, or 5):**
> Here's your report for this week, {{client}}. {{Scenario's key data, e.g. "412 sent, reply rate at
> 0.4% two weeks in" / "18 replies, 11 positive" / "0.9% PRR, but here's who's engaging: ..."}}. We're
> {{scenario's action plan, e.g. testing a new messaging angle / tightening ICP filters}} to push this
> further. More next week.

**Negative (scenario 3 or 4):**
> Here's your report for this week, {{client}}. {{Scenario's key data, e.g. "reply rate has held at 0.1%
> over the last 4 weeks" / "22 replies, 16 negative, mostly around pricing"}}. We're already on it:
> {{scenario's action plan, e.g. resetting the campaign with a new angle and lead source / repositioning
> the offer}} goes live next week and you should see it reflected in next week's numbers.

Every bracketed section must name something real and specific from the Step 2 analysis and the matched
scenario row, not a placeholder left in.

---

## STEP 5 - PRESENT AND CONFIRM THE CLIENT MESSAGE

Output order:
1. The window used and any gaps found (campaign in Instantly but not in `campaign-state.md`).
2. All six data cuts from Step 2, in order.
3. The matched scenario from Step 3 (or "healthy, no scenario matched") and why.
4. The health band (Green/Amber/Red) and the tone it maps to.
5. The drafted client message from Step 4, citing the matched scenario's data and action plan.
6. Ask explicitly: **"Send this to {{client}}? (Y/N)"** and wait.

Sending the message is external client comms, per root `CLAUDE.md` Safety Guard rule 1 it needs the
GTME's explicit approval every time, regardless of how the tone was calibrated. This skill only drafts,
it never sends on its own.

---

## STEP 6 - LOG THE FINDING (internal, separate confirmation)

This is what makes the analysis usable the next time copy gets written, otherwise the scenario diagnosis
and objection pattern found here evaporate the moment this run ends. `cold-email-writer.md` already reads
`clients/{slug}/decision-log.md` when building on a prior decision, this step is how a workspace-deep-report
finding gets there.

This confirmation is independent of Step 5's send decision. The GTME may send the client message without
logging the finding, log the finding without sending anything, both, or neither.

1. **Propose the decision-log entry**, in the existing decision-log format:
   - The matched scenario (or "healthy, no action needed", skip logging in that case)
   - The diagnosis in one line, plus the action plan from the matched Risk Scenarios Table row
   - Any objection theme from Step 2.5 that hit 3+ occurrences this window, **only if** `decision-log.md`
     doesn't already have a recent entry covering that same theme (check the MUST READ above first,
     don't double-log what `reply-handler.md` already caught)
2. **Propose the campaign-state.md health update:** the Green/Amber/Red band from Step 4, plus a one-line
   state note referencing the matched scenario, in the same format `weekly-reviewer.md` Step 6 already
   uses. This can update health mid-week, ahead of the next Friday review, since the whole point of this
   skill is catching risk before Friday.
3. Ask explicitly: **"Log this finding to decision-log.md and refresh campaign-state.md health? (Y/N)"**
   and wait.
4. On yes: write both files, confirm the writes to the GTME.
5. On no: leave both files untouched. The analysis stays in this conversation only.

---

## RULES

- Never invent a data cut. If Instantly can't supply it (e.g. reply sample too small for a timestamp
  pattern), say so plainly instead of guessing.
- Every client message must cite the exact data points and action plan from its matched Risk Scenarios
  Table row, per the "Why this matters" framing above, a tone-matched message with no concrete plan
  attached is not acceptable output.
- Never match scenario 5 from metrics alone. It requires the GTME to confirm the client raised a
  lead-quality concern (Step 3, point 4). A decent PRR with no stated concern is healthy, not scenario 5.
- Pull every campaign live in the workspace, not just the ones already in `campaign-state.md`. Flag the
  gap if one exists, that gap is itself a signal `campaign-state.md` is stale.
- Reuse the existing Green/Amber/Red bands from `sops/campaign-performance-standards.md` for tone, do not
  create a second scoring scale.
- Reply analysis and timestamp analysis must exclude automated replies (out-of-office, bounces,
  wrong-person), per the lead-label / interest-status filtering in Step 1.7.
- Nothing is sent to the client without an explicit Y/N from the GTME, no exceptions.
- Nothing is written to `decision-log.md` or `campaign-state.md` without its own explicit Y/N (Step 6),
  kept separate from the send decision (Step 5), sending and logging are independent choices.
- Before logging an objection pattern, check `decision-log.md` for an existing entry on the same theme.
  Don't double-log what `reply-handler.md` already caught.
- The `campaign-state.md` health update reuses the exact Green/Amber/Red band from Step 4 and the format
  `weekly-reviewer.md` Step 6 already uses, do not invent a different health note format.
- This is a manually-triggered, single-client skill. It does not scan the portfolio and does not decide
  who gets one, that judgement stays with the GTME (see Risk Scenarios Table).

---

## QA CHECKLIST

Before presenting the report:

- [ ] Correct client resolved and confirmed before any Instantly pull?
- [ ] Window (last 7 days, or the GTME's override) stated clearly at the top of the output?
- [ ] Every number pulled from Instantly for that window, none estimated or carried over from memory?
- [ ] Every campaign live in the workspace covered, not just the ones already in `campaign-state.md`?
- [ ] Reply analysis and timestamp analysis exclude automated replies?
- [ ] Scenario match (Step 3) stated with the specific numbers that drove it, including launch age,
      traction, and sentiment split?
- [ ] Scenario 5 only matched after the GTME explicitly confirmed a lead-quality concern, never inferred
      from PRR alone?
- [ ] Health band (Green/Amber/Red) matches `sops/campaign-performance-standards.md` thresholds, not a
      gut call?
- [ ] Client message tone matches the health band, and it cites the matched scenario's specific "key data
      to share" and "action plan", nothing generic or left as a placeholder?
- [ ] Message shown to the GTME with an explicit Y/N before anything is sent, per Safety Guard rule 1?
- [ ] `decision-log.md` checked for an existing entry on the same objection theme before proposing to log
      a new one, no duplicate of what `reply-handler.md` already caught?
- [ ] decision-log and campaign-state writes (Step 6) confirmed on their own explicit Y/N, separate from
      the send decision (Step 5)?
- [ ] campaign-state.md health note uses the same Green/Amber/Red band and format `weekly-reviewer.md`
      already uses, not a new ad hoc format?
