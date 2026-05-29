# Skill: Cold Email Writer

**Trigger:** "Write a cold email", "write me a sequence", "email copy for [campaign]", "cold email for [signal]"

**Context:** Harry manages signal-based email outreach on behalf of {{CLIENT_NAME}}. Emails target decision-makers at businesses that match the client ICP. The tone follows company/voice.md. PRR is the only metric that matters.

**Read before writing — primary:**
- `company/offer.md` — what they sell, proof points, differentiators
- `company/icp.md` — who to target, decision-maker profiles
- `company/voice.md` — tone rules, approved claims, words to avoid
- `company/decision-log.md` — past decision rationale (why prior choices were made)
- `wiki/copy-library.md` — past top-performing variants for this client
- `wiki/copywriting-101.md` — Refine Flow hard rules, formula, frameworks

**Read before writing — extended (ColdIQ knowledge):**
- `wiki/copywriting-frameworks.md` — 13 named frameworks + ColdIQ 250K-email playbook + Josh Braun principles
- `wiki/subject-lines.md` — 4 subject line formulas and A/B testing rules
- `wiki/atl-btl-messaging.md` — register-appropriate copy for VP vs IC
- `wiki/personalization-at-scale.md` — 6 buckets, hooks, AI prompts
- `wiki/signal-sourcing.md` — to map signal → copy angle
- `wiki/email-benchmarks.md` — what good looks like

**Skills to invoke first if needed:**
- `gtm-skills/personalization-strategist.md` — to decide personalisation tier and write Clay prompts
- `gtm-skills/signal-sourcer.md` — to identify the right signal angle

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

Read `wiki/copy-library.md`. Find entries matching:
- Same signal type
- Same sequence step (Email 1, 2, or 3)
- PRR above 1.5%

If a match exists: state what you are building from and what you are stealing.
If no match exists: state you are starting fresh.

### Step 3 — Check the graveyard

Read the Graveyard section in `wiki/copy-library.md`. Identify angles or structures that have already underperformed. Do not repeat them.

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
5. **Framework** — default to Refine Flow 4-part formula. Use a named framework from `wiki/copywriting-frameworks.md` if the default is not landing.

---

## HARD RULES

- **Word count:** ATL (VP/C-Level) max 60. BTL (Manager/IC) max 90. Default 75 target, 100 ceiling. See wiki/copywriting-101.md (canonical).
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

## THE FORMULA (Refine Flow default)

Every email follows this structure. No exceptions unless a named framework is being tested.

**Part 1 — Personalisation (Why you, why now)**
One sentence proving you looked at them. Must not signal a pitch is coming.

**Part 2 — Who Am I (Social proof first, then what you do)**
Use "I" not "we". Specific numbers and named logos.

**Part 3 — The Offer (Most important part)**
Frame as giving, not selling. Specific outcome + timeframe + risk reversal.

**Part 4 — CTA (One binary yes/no question)**
Prospect replies in 5 words or less.

### Alternative frameworks

When the default formula is not landing, switch to one of the 13 named frameworks in `wiki/copywriting-frameworks.md`:
- **Do the Math** — when ROI is quantifiable
- **Pattern Interrupt / Ask Before Pitch** — leading with a question
- **Upfront Value** — value-first, no pitch
- **Challenge of Similar Companies** — industry-wide pain
- **HOT Outreach** — peak interest → value → CTA

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

- [ ] Under 100 words? (BTL: under 90, ATL: under 60)
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