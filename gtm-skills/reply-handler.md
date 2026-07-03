---
name: reply-handler
description: Routes inbound replies by type and produces the right response. Handles positive (meeting booking), negative (graceful exit), OOO (re-queue), wrong person (re-route), stall ("send more info"), and objection (invokes objection-library). Closes the loop on what cold-email-writer starts.
triggers:
  - "Handle this reply"
  - "Reply came in from {{prospect}}"
  - "What do I send back to {{prospect}}"
  - "{{prospect}} just replied"
  - "How do I respond to this"
reads:
  - "wiki/_skill-context.md"
  - "wiki/objection-library.md"
  - "clients/{slug}/copy-library.md"
  - "clients/{slug}/comms-log.md"
writes:
  - "clients/{slug}/comms-log.md"
  - "clients/{slug}/copy-library.md (winners)"
  - "clients/{slug}/copy-library.md (graveyard)"
  - "clients/{slug}/decision-log.md (if novel response)"
---

# Skill: Reply Handler

**Trigger:** "Handle this reply", "{{prospect}} just replied", "How do I respond to this", "What do I send back"

**Context:** Cold emails generate replies. The OS goes silent the moment a reply lands unless this skill runs. Closes the loop — categorises the reply, produces the right response, and logs everything.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

**MUST READ:**
- `wiki/objection-library.md` — for any reply containing an objection (now bias-annotated per response)
- `wiki/psychological-principles.md` — bias-by-stage table; use the Objection Handling row to pick biases for the response
- `clients/{slug}/comms-log.md` — for prior context with this prospect
- `clients/{slug}/copy-library.md` — for winning response patterns

**READ IF CONDITION:**
- `clients/{slug}/voice.md` — to match brand voice in the response
- `clients/{slug}/offer.md` — for proof points to deploy
- `gtm-skills/campaign-analyst.md` — if reply contains performance feedback worth logging

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
- Outcome column filled at end of execution (e.g. "Drafted Email 1 + 2 follow-ups", "Diagnosed: deliverability issue", "Pattern detected: diagnose-campaign-performance")

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## STEP 1 — Classify the Reply

Paste the reply. Identify the type:

| Type | Indicators | Route to step |
|------|-----------|---------------|
| **Positive** | "Interested", "Let's chat", "Tell me more", "Send a time" | Step 2A |
| **Negative — polite** | "Not a fit", "We're set", "No thanks" | Step 2B |
| **Negative — hostile** | "Unsubscribe", "Take me off", "Stop emailing" | Step 2C |
| **OOO** | Auto-reply, "Out of office", "Returning [date]" | Step 2D |
| **Wrong person** | "Not me", "Forward to X", "Try Y instead" | Step 2E |
| **Stall** | "Send a deck", "Email me Q3", "Circle back" | Step 2F |
| **Objection** | "We use X", "No budget", "Tried before, didn't work" | Step 2G (→ objection-library) |
| **Question only** | "What's the price", "How does it work", "Are you GDPR compliant" | Step 2H |
| **Forwarded internally** | "Looped in [name]", "Adding [name]" | Step 2I |
| **Unclear** | Cannot categorise confidently | Step 2J |

If multiple types apply, pick the dominant intent. Note the secondary.

---

## STEP 2A — Positive Reply (meeting booking)

**Action:** convert to a booked meeting.

**Template (default):**
```
Subject: RE: [original subject]

{{firstName}},

Glad to hear it.

Quick options:
- [Calendar link]
- Or grab any time that works here: [direct link]

I'll send a short agenda once booked — 20 mins, no slides.

Harry
```

**Adjustments:**
- ATL targets → drop "no slides" line (executives expect more polish)
- BTL targets → keep casual
- If they replied without naming a time → offer 2-3 specific options
- If they replied with "send a time" → send 3 specific slots

**Log:**
- `clients/{slug}/comms-log.md` — entry with date, channel, summary
- `clients/{slug}/decision-log.md` — if this is the first positive from a new variant
- Flag the source campaign / email for **winner consideration** in next weekly-reviewer

**Stop conditions:**
- If positive reply rate >2% on this campaign → consider promoting Email 1 to canonical variant

---

## STEP 2B — Negative Polite

**Action:** graceful exit. Log to graveyard if patterned.

**Template:**
```
Subject: RE: [original subject]

{{firstName}},

Understood — appreciate the reply.

If timing changes, you can find us anytime.

Harry
```

**Variant if they said "We're happy with [competitor]":**
```
Subject: RE: [original subject]

{{firstName}},

Good to hear. If anything ever shifts on [competitor]'s side, I'll be around.

Harry
```

**Log:**
- `clients/{slug}/comms-log.md`
- Suppress in Instantly (no further emails to this contact)
- If 3+ similar "we're happy with [competitor]" replies → flag in weekly-reviewer; consider competitor switch angle

---

## STEP 2C — Negative Hostile / Unsubscribe

**Action:** immediate suppression, no response.

**Steps:**
1. Add to Instantly suppression list immediately
2. Add to client's global do-not-contact in `clients/{slug}/_config.md` if requested
3. Do NOT reply — escalates risk
4. If hostile and threatens action (lawyer, complaint) → flag to Harry immediately, do not auto-respond

**Log:**
- `clients/{slug}/comms-log.md` — flag as "hostile" if relevant
- If language suggests GDPR / CAN-SPAM concern → check `wiki/deliverability.md` compliance section
- Cluster pattern: if >3 hostile replies on same campaign → pause and audit copy

---

## STEP 2D — OOO

**Action:** parse return date, re-queue.

**Steps:**
1. Extract return date from auto-reply
2. Pause this prospect in Instantly until 2 days after return
3. Do not send further emails until then
4. When sequence resumes, restart from current step

**Log:**
- Note OOO date in CRM / Instantly
- No comms-log entry needed (not a real reply)

---

## STEP 2E — Wrong Person / Re-route

**Action:** thank them, ask for the right contact, restart sequence with that contact.

**Template:**
```
Subject: RE: [original subject]

{{firstName}},

Appreciate the redirect.

Quick ask — who would you point me to on the [function area] side?

Happy to take it directly to them.

Harry
```

**Or if they named the person:**
```
Subject: RE: [original subject]

{{firstName}},

Thanks — I'll reach out to [named person] directly.

Quick favour: mind if I mention you pointed me their way?

Harry
```

**Then:**
- Source the named person's email (via Findymail / Clay)
- Add to Instantly with "warm intro" tag
- Start a new sequence with the referral angle ("[firstName] suggested I reach out")

**Log:** `clients/{slug}/comms-log.md` + add new contact + decision-log if pattern (e.g. "Champions consistently point to Head of X — refine ICP DM list").

---

## STEP 2F — Stall ("send more info")

**Action:** send tailored asset, set follow-up reminder.

**Decision tree:**
- "Send a deck" → send the 1-pager (not full deck — friction)
- "Send a case study" → match closest case study from `clients/{slug}/offer.md` to their context
- "Email me Q3" / "Circle back" → schedule follow-up in calendar for that date, mark sequence as paused

**Template (deck/case study send):**
```
Subject: RE: [original subject]

{{firstName}},

Here you go: [link to 1-pager / case study]

Two minutes to read.

If anything sparks, happy to dive deeper.

Harry
```

**Then:**
- Set 7-day follow-up reminder
- If no engagement after 7 days → send Email 3 of sequence or move to nurture

**Log:** `clients/{slug}/comms-log.md` + asset sent + follow-up date

---

## STEP 2G — Objection

**Action:** invoke `wiki/objection-library.md` for the matching objection pattern.

**Process:**
1. Identify the objection type (no budget, wrong time, use competitor, tried before, etc.)
2. Read the response template from objection-library — each is now annotated with the biases it leverages
3. Verify the response biases are right for THIS prospect (e.g. ATL register vs BTL — adjust tone accordingly)
4. Customise with proof points from `clients/{slug}/offer.md`
5. Send response
6. If they respond again → escalate to Harry directly (Claude does not handle 2+ objection cycles automatically)

**Bias check before sending:** confirm the response leverages the right biases for objection handling per `wiki/psychological-principles.md` "Biases by Copy Stage" table — primarily Disarming honesty, Frame-based misreaction (hold your frame), Understanding bias, Relatability, Reason-respecting, Polite bias. Avoid triggering Egocentric bias (do not attack their idea directly).

**Log:** `clients/{slug}/comms-log.md` + which objection was raised. If 3+ same objection across campaign → log to `clients/{slug}/decision-log.md` as a pattern requiring offer adjustment.

---

## STEP 2H — Question Only

**Action:** answer concisely, anchor back to value.

**Template:**
```
Subject: RE: [original subject]

{{firstName}},

[Direct answer to their question — 1-2 sentences max.]

[Bridge to value: "Where most {{ICP_title}}s land is..."]

Worth a quick chat to see if it fits {{company}}?

Harry
```

**Rules:**
- Never answer with a deck or case study (use Step 2F for that)
- Always answer the question first, then bridge
- Keep under 60 words

---

## STEP 2I — Forwarded Internally

**Action:** acknowledge, anchor the conversation, log new contact.

**Template:**
```
Subject: RE: [original subject]

{{newName}},

Thanks {{originalName}} — happy to be looped in.

Short version: [one-sentence offer summary tailored to newName's role].

Open to a quick call to walk through fit?

Harry
```

**Then:**
- Add `{{newName}}` to Instantly (do not double-email)
- Update `clients/{slug}/_config.md` if they're a new key contact

**Log:** `clients/{slug}/comms-log.md` + add `{{newName}}` to known contacts.

---

## STEP 2J — Unclear

**Action:** ask Harry to clarify. Do not auto-respond.

Output:
```
Reply categorisation uncertain. Possible types: [list].
Recommend manual review.
Suggested response if forced to pick: [draft a safe response].
```

---

## OUTPUT FORMAT

For every reply handled:

```
=== Reply Handled ===

Prospect: {{name}} at {{company}}
Reply type: {{type}}
Confidence: {{High / Medium / Low}}

Response:
[paste the response that will be sent]

Logs updated:
- clients/{slug}/comms-log.md
- clients/{slug}/copy-library.md (if winner pattern emerging)
- clients/{slug}/decision-log.md (if novel pattern)

Next action:
- {{What Harry needs to do — send manually / approve / book meeting}}

Notes:
- {{Anything unusual to flag}}
```

---

## RULES

- **Never send the response automatically.** Always show Harry the draft for approval.
- **Always log to `clients/{slug}/comms-log.md`.** Every reply, every type.
- **Pattern recognition is key.** If you see the same objection 3+ times, flag it. The OS should adapt.
- **Hostile replies → no response, immediate suppression.** Escalate to Harry.
- **GDPR-flagged replies** (mentions data, opt-out rights, legal language) → check `wiki/deliverability.md` compliance section, escalate to Harry.
- **Match the voice** in `clients/{slug}/voice.md`. Do not improvise tone.
- **Track winner patterns.** If a specific response template converts at unusual rate, log it as a candidate winner for the next weekly review.

---

## EXAMPLES

### Example 1 — Positive reply on {{CLIENT_NAME}} hiring campaign

```
Harry: Handle this reply:
"Yeah this sounds interesting. We've struggled with the typical agency churn. Send a time."

Claude:
=== Reply Handled ===

Prospect: Jordan Kim at Vector Health
Reply type: Positive
Confidence: High

Response:
Subject: RE: hiring speed

Jordan,

Glad to hear it.

Quick options — pick whichever works:
- Tue 14:00 EST
- Wed 10:00 EST
- Thu 16:00 EST

Or grab any time here: [calendar link]

20 mins, no slides — just the candidate pipeline approach.

Harry

Logs updated:
- clients/{slug}/comms-log.md: positive reply from Jordan Kim, Vector Health, hiring campaign Email 2
- Flagged for weekly-reviewer: hiring Email 2 has now produced 4 positive replies in 7 days

Next action:
- Send the response above
- Add Vector Health to active opportunity list
- Prep for call: pull Vector Health LinkedIn, recent hires, growth signals

Notes:
- "Typical agency churn" pain point worth logging — angle for future emails.
```