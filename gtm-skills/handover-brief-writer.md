---
name: handover-brief-writer
description: Generates the Handover Brief and Client Introduction Message when a client transitions between GTMEs (permanent departure, internal reassignment, or temporary cover). Collects required fields, then produces both outputs as editable drafts. Never sends anything.
triggers:
  - "Handover {{client}} to {{GTME}}"
  - "Generate handover brief for {{client}}"
  - "{{client}} handover brief"
  - "I'm covering for {{GTME}}"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/overview.md"
  - "clients/{slug}/campaign-state.md"
  - "clients/{slug}/icp.md"
  - "clients/{slug}/copy-library.md"
  - "clients/{slug}/comms-log.md"
  - "clients/{slug}/decision-log.md"
writes:
  - "clients/{slug}/comms-log.md (log the handover)"
  - "clients/{slug}/decision-log.md (log the transition, including outgoing/incoming GTME and AM)"
---

# Skill: Handover Brief Writer

**Trigger:** "Handover [client] to [GTME]", "Generate handover brief for [client]", "[client] handover brief", "I'm covering for [GTME]"

**Context:** GTMEs and AMs use this to execute clean client handovers per `sops/client-handover.md`. Two outputs: the Handover Brief (internal, for the incoming GTME) and the Client Introduction Message (client-facing, permanent and reassignment handovers only). Both are presented as editable drafts, never auto-sent.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

Pull whatever already exists before asking the GTME to re-type it:
- `clients/{slug}/overview.md` - client name, plan, MRR
- `clients/{slug}/campaign-state.md` - campaign status, current performance
- `clients/{slug}/icp.md` - ICP overview, angles tested
- `clients/{slug}/copy-library.md` - key wins to date
- `clients/{slug}/comms-log.md` - client personality/comms style, watch-outs
- `clients/{slug}/decision-log.md` - watch-outs, prior sensitive history

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
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## STEP 1 - Identify the Handover Type

If the GTME has not already stated the handover type, ask first:

"What type of handover is this? Permanent departure, internal reassignment, or temporary cover?"

This determines which outputs are needed:
- **Permanent / Reassignment** - produce both the Handover Brief and the Client Introduction Message.
- **Temporary Cover** - produce the Handover Brief only. No client message required unless the absence is 2+ weeks.

**If Temporary Cover:** also ask now, before collecting fields: "Is this planned or unplanned?" Per
`sops/client-handover.md` Scenario 3, this determines who is completing the brief:
- **Planned** - the outgoing GTME completes the brief before going out. Proceed with them as the source for Step 2.
- **Unplanned** - the AM completes the brief instead. Collect Step 2's fields from the AM (or from whatever
  records are available) rather than the absent GTME.

Carry this answer forward to Step 4 - it also determines who sends the client message, so do not ask again.

---

## STEP 2 - Collect Information

Ask for all missing fields in a single message. Do not ask one at a time unless the conversation naturally flows that way. If information has already been provided (in the prompt, or found via the skill-specific reads above), extract it directly rather than re-asking.

Required fields:
- **Client Name** - full client name or company name
- **Plan** - SalesOS / PerformanceOS / other
- **MRR** - monthly recurring revenue, written as words, no dollar signs
- **Transition Type** - Permanent / Reassignment / Cover
- **Handover Date** - the date ownership transfers
- **Outgoing GTME Name** - who is handing over
- **Incoming GTME Name** - who is taking over
- **AM Name** - Account Manager overseeing the handover
- **Campaign Status** - what is currently running, where it is in the testing cycle, current performance (PRR, leads generated to date)
- **ICP Overview** - who is being targeted, what angles have been tested, what has and has not worked
- **Client Personality and Comms Style** - how they communicate, how often they expect updates, any sensitivities or preferences
- **Open Action Items** - everything in progress or outstanding (campaigns being built, approvals pending, Looms due)
- **Key Wins to Date** - results worth referencing, positive replies, meetings booked, moments the client was visibly happy
- **Watch-outs** - ongoing concerns, previous complaints, anything sensitive the incoming GTME needs to know
- **Upcoming Milestones** - review calls, campaign launches, renewal dates

If a field genuinely has no content, write "None at this time." Never leave a field blank or skip it.

If information is provided via a voice-to-text transcript, extract the relevant details and confirm ambiguities before outputting.

---

## STEP 3 - Output the Handover Brief

Once all fields are collected, output the brief in this exact format:

```
Client: [Client Name] | Plan: [Plan] | MRR: [MRR written as words]
Transition type: [Permanent / Reassignment / Cover]
Handover date: [Date]
Outgoing GTME: [Name] | Incoming GTME: [Name] | AM: [Name]

# Campaign Status

[Value - what is running, where in the testing cycle, current performance]

# ICP Overview

[Value - who is being targeted, angles tested, what worked and what did not]

# Client Personality and Comms Style

[Value - communication style, update frequency expectations, sensitivities]

# Open Action Items

[Value - everything in progress or outstanding]

# Key Wins to Date

[Value - results worth referencing]

# Watch-outs

[Value - concerns, complaints, sensitive history]

# Upcoming Milestones

[Value - calls, launches, renewals]
```

Present this as a draft using `message_compose_v1` with kind "other" and label "Handover Brief".

---

## STEP 4 - Output the Client Introduction Message

Select the correct scenario based on handover type. Present as a separate editable draft after the brief, using a second `message_compose_v1` call with kind "other".

Skip this step entirely for Temporary Cover unless the absence is confirmed as 2+ weeks. For Temporary Cover, use the planned/unplanned answer already collected in Step 1, it determines who sends the message.

### Scenario 1 - Permanent Departure

**AM Message:**
"Hi [Name], just a quick update from our end. [Outgoing GTME] is moving on from the team, and [Incoming GTME] will be taking over your account from [date]. [Incoming GTME] has been fully briefed on your campaigns and everything built so far, there will be no disruption to your service. They will be in touch shortly."

**Incoming GTME Follow-up:**
"Hey [Client Name], [Incoming GTME] here. I've had a full handover and I'm across everything. I'll keep things moving and will be in touch with updates shortly. Looking forward to working with you."

Label: "Client Introduction - AM", second variant "Incoming GTME Follow-up".

### Scenario 2 - Internal Reassignment

**AM Message:**
"Hi [Client Name] and team. I trust you are well. I wanted to make an official introduction to [Incoming GTME], a top-performing GTME here on the VIP team. [Incoming GTME] will be taking over as your primary point of contact going forward.

The reason we are making this change is simple: we want to give you the best possible experience and output from your relationship with us. [Incoming GTME] is uniquely positioned to do that and is one of our most experienced team members, capable of giving your campaigns the strategic direction and flawless execution an ICP and initiative like yours requires.

You need the best of the best, and that is exactly what you are getting. That said, the entire team remains at your disposal.

[Incoming GTME] will reach out shortly, but has already been fully briefed and you can be sure there will be no disruption to the service."

**Incoming GTME Follow-up:**
"Hey [Client Name], [Incoming GTME] here. I've had a full handover and I'm across everything. I'll keep things moving and will be in touch with updates shortly. Looking forward to working with you."

Label: "Client Introduction - AM", second variant "Incoming GTME Follow-up".

### Scenario 3 - Temporary Cover (2 weeks or longer only)

**If planned**, the assigned GTME sends the message:
"Hi [Client Name] and team. Just a quick heads up, I'm taking some time away and [Incoming GTME] will be covering your account from [date] to [date]. [Incoming GTME] has been fully briefed and everything will keep moving without interruption. You are in good hands."

Label: "Cover Notice - GTME" (single variant, no follow-up).

**If unplanned**, the AM sends the message:
"Hi [Client Name] and team. Just a quick heads up, [Outgoing GTME] is taking some time away and [Incoming GTME] will be covering your account from [date] to [date]. [Incoming GTME] has been fully briefed and everything will keep moving without interruption. You are in good hands."

Label: "Cover Notice - AM" (single variant, no follow-up).

---

## STEP 5 - Log the Handover

- `clients/{slug}/decision-log.md` - log the transition (type, date, outgoing/incoming GTME, AM). This is
  the durable record of who owns the client going forward - there is no separate "owning GTME" field to
  update elsewhere. Each GTME runs their own instance of this OS, so within a given repo there is only
  ever one GTME; a permanent or reassignment handover means the client's folder itself moves to the
  incoming GTME's instance, and this decision-log entry (plus the Handover Brief) is what travels with it.
- `clients/{slug}/comms-log.md` - log the client introduction message once the GTME confirms it was sent (this skill does not send it).

---

## FORMATTING RULES

- Use `#` headings for every section label in the brief, no bullet points, no bold labels, no colons after headings.
- One blank line between the heading and the paragraph below it.
- One blank line between each section.
- No em dashes anywhere in the output.
- Do not use dollar signs, write monetary amounts as words.
- Keep each brief section to 4 sentences maximum, concise, factual, no padding.

---

## RULES

- Never send anything. Present all outputs as drafts only, the GTME (or the AM/GTME running this) sends manually.
- If a field genuinely has no content, write "None at this time.", never leave it blank or skip it.
- The brief is the internal document, the client messages are separate outputs, clearly labelled, never merge them into one draft.
- For Temporary Cover, always confirm planned vs. unplanned before drafting the Scenario 3 message, the sender differs.

---

## QA CHECKLIST

Before presenting the drafts to the GTME:

- [ ] All 14 required fields present, none blank, "None at this time" used where there is genuinely nothing to report?
- [ ] For Temporary Cover, was planned vs. unplanned confirmed before drafting the Scenario 3 message?
- [ ] Handover Brief and Client Introduction Message presented as two separate labelled drafts, never merged into one?
- [ ] Correct scenario selected for the handover type, with the right sender (GTME or AM) named in Scenario 3?
- [ ] `decision-log.md` entry captures the outgoing GTME, incoming GTME, and AM names alongside the transition type and date?
- [ ] No em dashes anywhere in either draft?
- [ ] MRR and any other monetary amounts written as words, no dollar signs?
