---
name: client-request-handler
description: Routes mid-week client requests to the right skill. Captures the request, logs it, runs the appropriate handler, confirms completion to client. Closes the gap between "client asked for something" and "it got done and logged."
triggers:
  - "Handle client request"
  - "Client asked for {{X}}"
  - "{{Contact name}} wants {{X}}"
  - "Process this request from {{client}}"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/comms-log.md"
  - "clients/{slug}/overview.md (SLA)"
writes:
  - "clients/{slug}/comms-log.md (log the request)"
  - "clients/{slug}/decision-log.md (log the decision)"
---

# Skill: Client Request Handler

**Trigger:** "Handle client request", "{{Contact}} wants {{X}}", "Process this request from {{client}}"

**Context:** Clients send asks mid-week. Without a defined handler, every ask is improvised. This skill routes the request to the right downstream skill, logs the interaction, and confirms back to the client.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end - captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt - no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution (e.g. "Drafted Email 1 + 2 follow-ups", "Diagnosed: deliverability issue", "Pattern detected: diagnose-campaign-performance")

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## STEP 1 - Capture the Request

Paste the client message. Capture:
- **Date received:** {{timestamp}}
- **Channel:** email / Slack / call / Notion comment
- **From:** {{contact name}}
- **Verbatim request:** {{paste}}

Ask Harry to confirm interpretation if ambiguous.

---

## STEP 2 - Classify the Request Type

| Type | Indicators | Route to |
|------|-----------|---------|
| **A - Change to ICP** | "Stop targeting X", "Add Y to ICP", "These leads aren't right" | `gtm-skills/icp-builder.md` |
| **B - Change to offer** | "Update the pitch", "New case study to use", "Stop using X claim" | Update `clients/{slug}/offer.md` directly |
| **C - Change to copy** | "Rewrite Email 1", "Try this angle", "This subject isn't working" | `gtm-skills/cold-email-writer.md` |
| **D - New test request** | "Test X", "Try Y vs Z" | `gtm-skills/test-launcher.md` |
| **E - Pause / stop a campaign** | "Pause X", "Stop sending to Y", "Halt for 2 weeks" | Update `clients/{slug}/campaign-state.md` directly |
| **F - Resume campaign** | "Restart X", "Resume sending" | Update `clients/{slug}/campaign-state.md` + verify pre-launch-check |
| **G - Reporting question** | "What's our PRR this month", "How many meetings did we book", "Send me the data" | `gtm-skills/campaign-analyst.md` or `gtm-skills/client-report-writer.md` |
| **H - Strategic / Q4 planning** | "Plan Q4", "What should we change", "What's working" | `gtm-skills/qbr-writer.md` or strategic discussion |
| **I - Performance concern** | "PRR seems low", "Why are we underperforming" | `gtm-skills/campaign-optimiser.md` + diagnostic. If this Type fires at all, `sops/client-not-getting-results.md` Step 1 was missed, the client should already know before they ask. |
| **J - Contract / billing** | "Renewal terms", "Invoice question", "I want a refund" | Manual - escalate to the AM, not Harry (billing is AM-owned per `sops/am-gtme-responsibility-split.md`), using the channel and format in `sops/gtme-escalation-to-am.md`. Refund requests: follow `sops/client-communication-principles.md` situational guidance (no commitments, escalate immediately to the AM, tag Aaron if the client has public presence) |
| **K - Asset request** | "Send the deck", "Share the case study" | Manual - pull from `assets/` and send |
| **L - Custom / unclear** | Anything else | Capture and flag for Harry |

If multiple types → handle the most actionable first, then sequentially.

---

## STEP 3 - Initial Response (acknowledgement)

Within SLA (default 24h per `clients/{slug}/overview.md`, and the OS-wide default set in
`sops/daily-structure.md`), send a brief acknowledgement:

**Template (default):**
```
{{firstName}},

On it. {{1-line summary of what you understood + ETA}}.

Will update once {{X is done / decision is made / data is pulled}}.

Harry
```

**Adjust:**
- Tone matches `clients/{slug}/voice.md` and prior `comms-log.md` history
- If urgent → include shorter ETA
- If unclear request → ask one clarifying question before committing ETA

---

## STEP 4 - Route to Downstream Skill

Based on classification:

### Type A - ICP Change
1. Invoke `gtm-skills/icp-builder.md`
2. Update `clients/{slug}/icp.md`
3. Re-check active lead lists against new ICP
4. Flag if any active campaign now has wrong-fit leads → may need to pause or filter

### Type B - Offer Change
1. Read current `clients/{slug}/offer.md`
2. Apply the change
3. If proof point changed → check active copy for usage of old proof point, flag for rewrites
4. Note: any change to "approved claims" requires explicit client confirmation in writing

### Type C - Copy Change
1. Invoke `gtm-skills/cold-email-writer.md`
2. Generate new copy
3. Show client for approval BEFORE replacing in Instantly
4. After approval → invoke `gtm-skills/campaign-launcher.md` for pre-flight check
5. Update sequence in Instantly

### Type D - Test Request
1. Invoke `gtm-skills/test-launcher.md`
2. Validate the test makes sense (one variable, achievable sample, etc.)
3. Queue or launch per Harry's go-ahead

### Type E - Pause Campaign
1. Update `clients/{slug}/campaign-state.md`:
   - Change status to "Paused"
   - Note reason and date
2. Pause in Instantly
3. Log to `clients/{slug}/decision-log.md`

### Type F - Resume Campaign
1. Run `gtm-skills/pre-launch-check.md` first
2. If READY → resume
3. Update `clients/{slug}/campaign-state.md`

### Type G - Reporting Question
1. Pull data from the Instantly API (via `.claude/bin/instantly.sh`)
2. Format response appropriate to question
3. Send via reply

### Type H - Strategic
1. Schedule a call rather than handle in text
2. Prep using `gtm-skills/qbr-writer.md` template

### Type I - Performance Concern
1. Invoke `gtm-skills/campaign-optimiser.md`
2. Diagnose
3. Respond with: root cause + fix + expected impact + timeline

### Type J - Contract / Billing
ESCALATE - do not auto-handle. Notify Harry, draft acknowledgement to client.

### Type K - Asset Request
1. Pull asset from `assets/README.md` index
2. Send link
3. Log to comms-log

### Type L - Unclear
- Output for Harry: "Request type unclear. Suggested classification: {{X}}. Proceed?"
- Wait for Harry's call

---

## STEP 5 - Log Everything

**To `clients/{slug}/comms-log.md`:**
```
### {{YYYY-MM-DD HH:MM}} - {{channel}} {{inbound/outbound}}

**With:** {{contact name}}
**Topic:** {{1-line topic}}

**Summary:**
{{Verbatim or close paraphrase of the client request}}

**Action needed:**
- [ ] {{specific action}} - by {{date per SLA}}

**Outcome:** (to update after completion)
```

**To `clients/{slug}/decision-log.md`** (if a non-trivial decision was made):
```
### {{date}} - Client request: {{topic}}

**Context:** {{why they asked}}
**Decision:** {{what we agreed to do}}
**Why:** {{reasoning, including any pushback}}
**Trade-offs:** {{what we are NOT doing as a result}}
**Outcome:** (to update)
```

---

## STEP 6 - Confirm Completion to Client

Once the action is done, send a closing message:

**Template:**
```
{{firstName}},

{{Action}} done.

{{1-2 line summary of what changed}}

{{If applicable: when to expect first results from the change.}}

Anything else, just shout.

Harry
```

Update comms-log entry with outcome.

---

## RULES

- **Acknowledge within SLA, always.** Even if the work takes longer, the acknowledgement is non-negotiable.
- **One channel per request.** Reply where they asked (email → email, Slack → Slack). Don't switch channels without reason.
- **Log every request.** No exceptions. comms-log + (if strategic) decision-log.
- **Don't promise what you can't deliver.** "By Friday" only if you actually can.
- **Push back on bad asks.** If a client asks for something that breaks methodology (e.g. "send 200 emails/day per mailbox"), respond honestly with the reason and an alternative.
- **Escalate billing, contract, and legal.** Never auto-handle these.
- **Update OS files immediately.** If ICP changes, update icp.md the same hour - don't batch for Friday review.

---

## QA CHECKLIST

Before confirming completion to the client:

- [ ] Acknowledgement sent within SLA (24h default)?
- [ ] Classification type matches the actual request, not a convenient guess?
- [ ] Every action logged to `comms-log.md`, and to `decision-log.md` if non-trivial?
- [ ] Billing, contract, and legal requests escalated, never auto-handled?
- [ ] Closing message ties back to the specific thing the client asked for?

---

## EXAMPLES

### Example - copy change request

```
Harry: Handle client request:
"{{PRIMARY_CONTACT}} said the Email 2 isn't landing for him. He wants something more about the candidate quality story, not the timeline."

Claude:
=== Client Request Captured ===

From: {{PRIMARY_CONTACT}} ({{CLIENT_NAME}})
Channel: Slack
Type: C - Change to copy
Classification confidence: High

Acknowledgement draft (sending now):
"{{PRIMARY_CONTACT}} - on it. Reframing Email 2 around candidate quality. Will have a draft for you by EOD tomorrow. - Harry"

Routing to cold-email-writer for Email 2 of Hiring Signal v4.
Reading clients/{slug}/copy-library.md (current Email 2)...
Reading clients/{slug}/offer.md (proof points around candidate provenance)...

[Invokes cold-email-writer to draft new Email 2]
[Shows side-by-side: current Email 2 vs new variant]

After Harry approves:
- Reply to {{PRIMARY_CONTACT}} with the new copy for sign-off
- Once approved by {{PRIMARY_CONTACT}} → run campaign-launcher pre-flight
- Update in Instantly
- Update clients/{slug}/campaign-state.md with new Email 2 in sequence
- Log to comms-log + decision-log
```

---

## ACTIVE-TEST ENFORCEMENT

Before modifying a campaign or its sequence, check `clients/{slug}/campaign-state.md` for a `TEST ACTIVE` flag and apply the rules in `wiki/_active-test-rules.md`. Refuse changes that touch test constants without an explicit override.