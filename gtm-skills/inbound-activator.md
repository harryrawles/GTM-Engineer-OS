---
name: inbound-activator
description: Closes the loop between inbound signal detection and outbound activation. Takes a detected inbound signal (website visitor, job change, funding, hiring, tech change), enriches and qualifies it, routes to the right outbound motion, fires sequence within SLA.
triggers:
  - "Inbound signal: {{description}}"
  - "RB2B picked up {{company}}"
  - "Someone hit pricing page from {{company}}"
  - "Activate this inbound lead"
  - "{{company}} just raised funding - should we reach out"
  - "Champion just moved to {{company}}"
reads:
  - "wiki/_skill-context.md"
  - "wiki/inbound-orchestration.md"
  - "wiki/signal-sourcing.md"
  - "wiki/list-building.md"
  - "clients/{slug}/icp.md"
  - "clients/{slug}/campaign-state.md (tools section)"
writes:
  - "clients/{slug}/comms-log.md (logs the activation)"
  - "clients/{slug}/decision-log.md (if novel signal pattern)"
  - "clients/{slug}/MEMORY.md (active inbound under watch)"
---

# Skill: Inbound Activator

**Trigger:** "Inbound signal: [X]", "RB2B picked up [company]", "Someone hit pricing page from [company]", "[company] just raised funding", "Champion just moved to [company]", "Activate this inbound lead"

**Context:** Cold outbound replies at 6-8%. Inbound-triggered outbound replies at 18-22%. Multi-signal hits 35-40%. This skill is how single inbound signals turn into hot outbound moves within SLA.

The skill is distinct from:
- `signal-sourcer.md` - designs which signals to TARGET (strategy)
- `reply-handler.md` - handles inbound REPLIES (post-outreach)
- `inbound-activator.md` - handles inbound SIGNALS (pre-outreach, this skill)

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

**MUST READ:**
- `wiki/inbound-orchestration.md` - the framework (signals, SLA, tiering)
- `clients/{slug}/icp.md` - for qualification scoring
- `clients/{slug}/campaign-state.md` Tools section - to know what enrichment is possible

**READ IF:**
- `wiki/signal-sourcing.md` - for multi-signal scoring across this and other detected signals
- `wiki/list-building.md` - for ICP scoring methodology
- `clients/{slug}/MEMORY.md` - check if this account is already under watch from prior signals

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

## STEP 1 - Capture the Signal

Identify and confirm:
- **Signal type:** website visitor / job change / funding / hiring / tech change / multi-signal
- **Detected company:** name + domain
- **Detected contact (if known):** name + title (often unknown on website visitors)
- **Source:** which tool fired the signal (RB2B, Clay, Crunchbase, etc.)
- **Detection timestamp:** when did the signal fire?
- **Time since signal:** how much of the optimal window has elapsed?

If signal is older than its optimal window (per freshness rules in `wiki/signal-sourcing.md`), flag and ask Harry whether to still activate or drop to nurture.

---

## STEP 2 - Enrich

Check `clients/{slug}/campaign-state.md` Tools section to see what's available.

### If Clay connected
Trigger Clay workflow for this signal type. Expected output:
- Full firmographics (industry, size, revenue, funding stage)
- Technographics (tech stack relevance)
- Contact discovery (find the right person at the company)
- Email waterfall (verify contact)
- Multi-signal stacking (any OTHER signals firing on same account?)

### If Apollo / LinkedIn Sales Nav connected
Manual enrichment via Apollo. Slower but workable.

### If no enrichment tools connected
Note the gap. Use public data only. Quality will be lower. Recommend Harry connects Clay or Apollo for this client.

---

## STEP 3 - Qualify

Apply the 100-point ICP scoring from `wiki/list-building.md`:

| Criterion | Weight |
|-----------|--------|
| Industry match | 20 |
| Company size | 15 |
| Revenue range | 15 |
| Geography | 10 |
| Technology fit | 15 |
| Growth signals | 10 |
| Intent signals (THIS signal counts here) | 15 |

Apply recency multiplier (1.5x for last 24h down to 0.3x for 30+ days old).

Assign tier:
- **A** (80-100): hot - same-day or sub-hour outreach
- **B** (60-79): warm - automated sequence within 24-48h
- **C** (40-59): cool - content drip / nurture
- **D** (<40): disqualify

---

## STEP 4 - Check Multi-Signal Stack

Query `clients/{slug}/decision-log.md`, recent `clients/{slug}/comms-log.md`, and any signal source available - is the same account showing other signals?

- 1 signal → standard route per tier
- 2 signals → bump priority one level (B → A, A → urgent)
- 3+ signals → on fire - Slack alert, same-day personal outreach

---

## STEP 5 - Activate (route to outbound)

Based on tier × signal:

### Hot (A-tier + strong signal - pricing page, demo no-show, multi-stack)
- **Action:** Personal outbound by Harry directly
- **Channel:** Email + LinkedIn DM
- **SLA:** Within 1 hour (sub-5-min if demo request)
- **Copy generation:** invoke `gtm-skills/cold-email-writer.md` with maximum personalisation tier
- **Notification:** Alert Harry via Slack / immediate flag

### Warm (A-tier weaker signal, B-tier strong signal)
- **Action:** Add to existing premium sequence in Instantly
- **Channel:** Email
- **SLA:** Within 24 hours
- **Copy generation:** invoke `gtm-skills/cold-email-writer.md` with lite hook personalisation
- **Notification:** Standard daily summary

### Cool (B-tier weak signal, C-tier)
- **Action:** Automated sequence - standard signal-based campaign
- **Channel:** Email (LinkedIn optional)
- **SLA:** Within 48 hours
- **Copy generation:** standard sequence variant

### Disqualify (D-tier)
- **Action:** Add to suppression
- **Log:** to `clients/{slug}/decision-log.md` with reason (don't waste future outreach)

---

## STEP 6 - Generate Copy

Invoke `gtm-skills/cold-email-writer.md` with:
- Signal context (the trigger, but DO NOT mention it directly per cold-email-writer rules)
- Tier (informs ATL/BTL register and personalisation depth)
- Multi-signal context (if stacked, the angle can reference broader trajectory)

**Critical rule:** never mention the signal directly. Prospect will know what triggered the email and feel surveilled. Reference the IMPLICATION ("scaling pressure", "post-raise priorities", "hiring velocity") not the trigger ("I saw you visited our pricing page").

---

## STEP 7 - Log Everything

### Always
- `clients/{slug}/comms-log.md` - signal activated, tier assigned, action taken
- `clients/{slug}/MEMORY.md` - add to "Active inbound under watch" section

### If novel pattern
- `clients/{slug}/decision-log.md` - if this is a new signal type or unusual stack

### If converts (replies positively)
- Mark in MEMORY.md as "converted from inbound signal"
- Cross-reference in copy-library if the response becomes a winner

---

## STEP 8 - Set Follow-Up

Inbound signals decay. Set explicit re-check:
- Hot tier → re-check status in 48 hours
- Warm tier → re-check in 7 days
- Cool tier → folded into next weekly review

---

## OUTPUT FORMAT

```
=== Inbound Signal Activated - {{company}} ===

Signal: {{type}} ({{source}}, detected {{timestamp}})
Time since detection: {{X hours}} (optimal window: {{Y}})
Detected contact: {{name + title}} (or "company-level only")

Enrichment status: {{Clay/Apollo/none}}
- {{firmographic data}}
- {{technographic data}}
- {{discovered contacts}}

Multi-signal stack check:
- {{signal 1}}: {{when detected}}
- {{signal 2}}: {{when detected}}
(or "single signal")

Qualification:
- ICP score: {{n}}/100
- Tier: {{A/B/C/D}}
- Heat (multi-signal × tier): {{Hot / Warm / Cool}}

Action:
- {{route per tier}}
- SLA: {{X}}
- Channel: {{email / + LinkedIn}}
- Personalisation tier: {{strong / lite / none}}

Copy generation: invoking cold-email-writer with above context...

Logs:
- comms-log.md: activation entry
- MEMORY.md: added to Active Inbound under watch
- {{decision-log entry if novel}}

Follow-up: re-check {{date}}
```

---

## RULES

- **Speed matters more than perfection.** A 30-minute response to a pricing page hit beats a perfect 6-hour response.
- **Match SLA to signal type.** Demo request <5 min. Pricing page <1 hour. Funding <72 hours. Don't apply same SLA to all signals.
- **Never mention the signal directly in copy.** Surveillance feeling kills replies. Reference the implication.
- **Stack signals before activating.** A single signal is warm. Three signals firing on the same account are different - change the strategy.
- **Disqualify is a decision, not a failure.** D-tier should be suppressed cleanly. Don't waste future outreach on accounts that don't fit.
- **Log every signal - converted or not.** Pattern recognition across signals is how we improve detection over time.
- **If Clay or Apollo not connected for this client** → flag it. Inbound orchestration without enrichment is half-blind.

---

## EXAMPLES

### Example - Pricing page visitor

```
Harry: RB2B picked up someone from Vector Health visiting our pricing page

Claude:
=== Inbound Signal Activated - Vector Health ===

Signal: Pricing page visit (RB2B, detected 14 min ago)
Time since detection: 14 min (optimal window: <1 hour for A-tier)
Detected contact: Jordan Kim - VP Engineering (verified via LinkedIn)

Enrichment status: Clay connected - running...
- Industry: Health Tech SaaS (matches ICP)
- Size: 47 employees (matches sweet spot for {{CLIENT_NAME}})
- Funding: Series A $8M, 4 months ago
- Tech stack: AWS, GitHub, Slack (modern eng team)

Multi-signal stack check:
- Pricing page visit (today, 14 min ago)
- Hiring signal: 3 senior eng roles posted last 30 days (detected on 2026-05-25)
**3 signals stacked - On Fire tier**

Qualification:
- ICP score: 92/100 (matches all 7 criteria)
- Tier: A
- Heat: On Fire (multi-signal A-tier)

Action:
- Personal outbound by Harry within 1 hour (target: 30 min)
- Channel: Email PRIMARY, LinkedIn as follow-up 24h later
- Personalisation tier: Strong hook (reference the implication of recent Series A + scaling)

Copy generation: invoking cold-email-writer with above context...

[generates email - see cold-email-writer output]

Logs:
- comms-log.md: Hot inbound activation, Vector Health, Jordan Kim
- MEMORY.md: Active inbound watch - Vector Health (Jordan Kim, VP Eng, pricing + hiring + Series A stack)

Follow-up: re-check 2026-05-31 (48h)

Recommend: send the generated email to {{PRIMARY_CONTACT}} ({{CLIENT_NAME}}) for visibility - this is the kind of warm conversion he'll want to know about regardless of outcome.
```