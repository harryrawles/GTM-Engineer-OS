# Skill: Cold Email Writer

**Trigger:** "Write a cold email", "write me a sequence", "email copy for [campaign]", "cold email for [signal]"

**Context:** Harry manages signal-based email outreach on behalf of {{CLIENT_NAME}}. Emails target decision-makers at businesses that match the client ICP. The tone follows company/voice.md. PRR is the only metric that matters.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `company/copy-library.md` — past top-performing variants for this client
- `wiki/copywriting-101.md` — canonical rules, 4-part formula

**READ IF CONDITION:**
- `company/decision-log.md` — if optimising or building on a prior decision
- `wiki/atl-btl-messaging.md` — if recipient register (ATL vs BTL) is unclear
- `wiki/personalization-at-scale.md` — if personalisation tier needs to be decided
- `wiki/signal-sourcing.md` — if mapping a signal to a copy angle

**REFERENCE (consult when needed):**
- `wiki/copywriting-frameworks.md` — 13 named frameworks for when the default formula has plateaued
- `wiki/subject-lines.md` — 4 subject line formulas
- `wiki/email-benchmarks.md` — what good looks like
- `gtm-skills/personalization-strategist.md` — full personalisation flow
- `gtm-skills/signal-sourcer.md` — full signal analysis

---

## PRE-WRITE PROTOCOL

Run this before writing any copy. Do not skip.

### Step 1 — Pull Instantly data

Using the Instantly MCP, pull campaign performance for this client workspace:
- All active and completed campaigns
- Per campaign: sends, reply rate, PRR, meetings booked
- Per sequence step: which email step is driving the most replies
- Top-performing subject lines

If Instantly MCP is unavailable, ask Harry to paste the metrics before continuing.

### Step 2 — Surface winning copy

Read `company/copy-library.md`. Find entries matching:
- Same signal type
- Same sequence step (Email 1, 2, or 3)
- PRR above 1.5%

If a match exists: state what you are building from and what you are stealing.
If no match exists: state you are starting fresh.

### Step 3 — Check the graveyard

Read the Graveyard section in `company/copy-library.md`. Identify angles or structures that have already underperformed. Do not repeat them.

### Step 4 — Decide register (ATL vs BTL)

Check the recipient title:
- VP / C-Level / Director / Head of → ATL → read `wiki/atl-btl-messaging.md` ATL section
- Manager / Specialist / Analyst / Coordinator / IC → BTL → read BTL section

### Step 5 — Decide personalisation tier

Use the matrix in `wiki/personalization-at-scale.md`:
- Deal size over $25K + low volume → personalise
- High volume + strong signal → skip personalisation, rely on the signal

### Step 6 — State your starting point

Before writing, output one line:
"Starting point: [building from X / starting fresh — reason]. Register: [ATL/BTL]. Personalisation: [strong hook / lite hook / none]."

---

## BEFORE YOU WRITE

Confirm these inputs. Ask if not already provided:

1. **Signal** — what triggered this outreach? (e.g. company posted 5+ jobs, raised Series A)
2. **Target** — who is the recipient? Title, company type, size
3. **Sequence step** — Email 1, 2, or 3?
4. **Goal of this email** — which value prop to lead with? (make money / save time / save money)

---

## FRAMEWORK DECISION TREE (F5)

```
Email 1 of new campaign + no past data
  → Default: 4-part formula (wiki/copywriting-101.md)

Default formula tested + PRR < 1.5% after 600+ sends
  → Switch to named framework (wiki/copywriting-frameworks.md)
  → Pick by signal type below

Specific signal warrants specific framework:
  Hiring signal              → Do the Math
  Pricing page visit         → HOT Outreach
  Job change                 → Pattern Interrupt
  Industry-wide pain         → Challenge of Similar Companies
  Lead-magnet engager        → Leverage Content in Outbound
  Re-engagement              → Manual Email Style (Josh Braun)
  Executive (C-level)        → ATL formula (wiki/atl-btl-messaging.md)
  Champion job change        → Not Too Different Persona

Default formula tested + PRR >= 1.5%
  → Do not switch. Iterate on sub-variables only (offer phrasing, CTA wording).
```

---

## HARD RULES

- **Word count:** ATL (VP/C-Level) max 60. BTL (Manager/IC) max 90. Default 75 target, 100 ceiling. See `wiki/copywriting-101.md` (canonical).
- No question marks except the CTA.
- Subject line: 2-4 words, lowercase, no spam triggers.
- No links in the body.
- No attachments.
- One CTA only — the prospect should reply in 5 words or less.
- 2:1 ratio — more about them than about you.
- Passes the bar test — could you read this out loud at a bar?
- PRR is the north star. Not open rate. Not reply rate.
- No vanity personalisation. "Saw you hired 3 AEs" not "I admire your passion".
- Each follow-up tests a different cognitive mechanism. Never just bump.
- Use spintax and liquid syntax for scale variations.
- **Subject + preview = a complete thought.** First 50 chars of body show in inbox.
- **Do not mention the signal in the email.** Reference the implication, not the trigger.

---

## THE FORMULA (canonical default)

Every email follows this structure. No exceptions unless a named framework is being tested.

**Part 1 — Personalisation (Why you, why now)**
One sentence proving you looked at them. Must not signal a pitch is coming.

**Part 2 — Who Am I (Social proof first, then what you do)**
Use "I" not "we". Specific numbers and named logos.

**Part 3 — The Offer (Most important part)**
Frame as giving, not selling. Specific outcome + timeframe + risk reversal.

**Part 4 — CTA (One binary yes/no question)**
Prospect replies in 5 words or less.

---

## SEQUENCE STRUCTURE

| Email | Day | Thread | Purpose | Value prop |
|-------|-----|--------|---------|-----------|
| 1 | Day 0 | Net new | Best angle, strongest offer | Lead value prop |
| 2 | Day 3 | Threaded | Different value prop, shorter | Second value prop |
| 3 | Day 7 | Net new | Completely different angle | Third value prop |
| 4 | Optional | Threaded | Hail mary — low friction | "Is this even on your radar?" |

Rotate across the 3 value props (make money / save time / save money). Never repeat the same one.

---

## QA CHECKLIST

Before outputting any copy, check every item:

- [ ] Within word count limits (ATL 60 / BTL 90 / default 75-100)?
- [ ] Passes the bar test?
- [ ] Part 1 specific to the signal — not generic?
- [ ] Part 2 uses "I" with a specific number?
- [ ] Part 3 has outcome + timeframe + risk reversal?
- [ ] CTA is one binary question?
- [ ] No question marks except the CTA?
- [ ] No links in the body?
- [ ] No banned words from `company/voice.md`?
- [ ] Uses only approved claims from `company/offer.md`?
- [ ] Different value prop from other emails in the sequence?
- [ ] Subject line 2-4 words, lowercase?
- [ ] Subject + preview reads as a complete thought?
- [ ] Register (ATL/BTL) matches the recipient title?
- [ ] Does NOT mention the signal directly?
- [ ] PRR north star confirmed?