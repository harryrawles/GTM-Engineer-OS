# Skill: Cold Email Writer

**Trigger:** "Write a cold email", "write me a sequence", "email copy for [campaign]", "cold email for [signal]"

**Context:** Harry manages signal-based email outreach on behalf of {{CLIENT_NAME}}. Emails target decision-makers at businesses that match the client ICP. The tone follows clients/{slug}/voice.md. PRR is the only metric that matters.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `clients/{slug}/copy-library.md` - past top-performing variants for this client
- `wiki/copywriting-101.md` - canonical rules, 4-part formula
- `wiki/psychological-principles.md` - bias mapping per copy stage (which to leverage, which to avoid)

**READ IF CONDITION:**
- `clients/{slug}/decision-log.md` - if optimising or building on a prior decision
- `wiki/atl-btl-messaging.md` - if recipient register (ATL vs BTL) is unclear
- `wiki/personalization-at-scale.md` - if personalisation tier needs to be decided
- `wiki/signal-sourcing.md` - if mapping a signal to a copy angle

**REFERENCE (consult when needed):**
- `best-practices/playbooks/` - reusable campaign playbooks. Check for one matching the client's offer/angle and start from its structure; adapt to the client (fill placeholders from their files, use only Approved Claims from `voice.md`). Never drop playbook copy in verbatim.
- `wiki/copywriting-frameworks.md` - 13 named frameworks for when the default formula has plateaued
- `wiki/subject-lines.md` - 5 subject line formulas
- `wiki/email-benchmarks.md` - what good looks like
- `gtm-skills/personalization-strategist.md` - full personalisation flow
- `gtm-skills/signal-sourcer.md` - full signal analysis
- `gtm-skills/spintax-ninja.md` - full spintax application process, once the copy is drafted

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

## PRE-WRITE PROTOCOL

Run this before writing any copy. Do not skip.

### Step 1 - Pull Instantly data

Call the Instantly API for this client (via `.claude/bin/instantly.sh` - see `sops/instantly-api.md`), pulling campaign performance:
- All active and completed campaigns
- Per campaign: sends, reply rate, PRR, meetings booked
- Per sequence step: which email step is driving the most replies
- Top-performing subject lines

If the Instantly API can't be reached (missing/invalid key), ask Harry to paste the metrics before continuing.

### Step 2 - Surface winning copy

Read `clients/{slug}/copy-library.md`. Find entries matching:
- Same signal type
- Same sequence step (Email 1, 2, or 3)
- PRR above 1%

If a match exists: state what you are building from and what you are stealing.
If no match exists: state you are starting fresh.

### Step 3 - Check the graveyard

Read the Graveyard section in `clients/{slug}/copy-library.md`. Identify angles or structures that have already underperformed. Do not repeat them.

### Step 4 - Decide the campaign style

If this is a new campaign (not a follow-up email in an existing sequence), pick the overall angle using
`wiki/copywriting-101.md` "Choosing a Campaign Style": Offer-Led, Pro-Bono Play, Three Ideas / Creative
Angle, or lead directly with the client's offer if it's already strong. Skip this step when writing a
follow-up email inside a sequence whose style is already set.

### Step 5 - Decide register (ATL vs BTL)

Check the recipient title:
- VP / C-Level / Director / Head of → ATL → read `wiki/atl-btl-messaging.md` ATL section
- Manager / Specialist / Analyst / Coordinator / IC → BTL → read BTL section

### Step 6 - Decide personalisation tier

Use the matrix in `wiki/personalization-at-scale.md`:
- Deal size over $25K + low volume → personalise
- High volume + strong signal → skip personalisation, rely on the signal

### Step 7 - State your starting point

Before writing, output one line:
"Starting point: [building from X / starting fresh - reason]. Style: [Offer-Led/Pro-Bono/Three Ideas/N-A]. Register: [ATL/BTL]. Personalisation: [strong hook / lite hook / none]."

### Step 8 - Map biases per part of the formula

Read `wiki/psychological-principles.md` - specifically the "Biases by Copy Stage" table. For each of the 4 parts of the email, decide:

- **Which 2-3 biases to deliberately leverage** (based on signal × persona × offer context)
- **Which 1-2 biases to avoid triggering** (especially Click-whirr conditioning and Egocentric bias)

Output as a planning block before writing:

```
Bias plan:
- Subject: [leverage X, Y | avoid Z]
- Part 1 (Personalisation): [leverage X, Y | avoid Z]
- Part 2 (Who am I): [leverage X, Y | avoid Z]
- Part 3 (Offer): [leverage X, Y, Z | avoid Z]
- Part 4 (CTA): [leverage X, Y | avoid Z]
```

This planning step keeps bias application intentional. Without it, copy tends to default to whatever bias the writer is most familiar with (usually social proof + scarcity) rather than the optimal combination for the specific context.

**The hard rule - Overdone-It bias:** pick at most 12-15 total biases across the whole email. More than that = manipulative. Less than 6 = bland and forgettable.

---

## BEFORE YOU WRITE

Confirm these inputs. Ask if not already provided:

1. **Signal** - what triggered this outreach? (e.g. company posted 5+ jobs, raised Series A)
2. **Target** - who is the recipient? Title, company type, size
3. **Sequence step** - Email 1, 2, or 3?
4. **Goal of this email** - which value prop to lead with? (make money / save time / save money)

---

## FRAMEWORK DECISION TREE (F5)

```
Email 1 of new campaign + no past data
  → Default: 4-part formula (wiki/copywriting-101.md)

Default formula tested + PRR < 1% after 600+ sends
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

Default formula tested + PRR >= 1%
  → Do not switch. Iterate on sub-variables only (offer phrasing, CTA wording).
```

---

## HARD RULES

- **Word count:** ATL (VP/C-Level) max 60. BTL (Manager/IC) max 90. Default 75 target, 100 ceiling. See `wiki/copywriting-101.md` (canonical).
- No question marks except the CTA.
- Subject line: 2-4 words, lowercase, no spam triggers.
- No links in the body.
- No attachments.
- One CTA only - the prospect should reply in 5 words or less.
- 2:1 ratio - more about them than about you.
- Passes the bar test - could you read this out loud at a bar?
- PRR is the north star. Not open rate. Not reply rate.
- No vanity personalisation. "Saw you hired 3 AEs" not "I admire your passion".
- Each follow-up tests a different cognitive mechanism. Never just bump.
- Use spintax and liquid syntax for scale variations. See `gtm-skills/spintax-ninja.md` for the exact format and process.
- **Subject + preview = a complete thought.** First 50 chars of body show in inbox.
- **Do not mention the signal in the email.** Reference the implication, not the trigger.

---

## THE FORMULA

Default: the 4-part formula (Personalisation → Who Am I → The Offer → CTA). See `wiki/copywriting-101.md` → The Formula section for the canonical structure with bias-tagging per part. Use a named framework from `wiki/copywriting-frameworks.md` only when the framework decision tree below indicates a switch.

---

## SEQUENCE STRUCTURE

| Email | Day | Thread | Purpose | Value prop |
|-------|-----|--------|---------|-----------|
| 1 | Day 0 | Net new | Best angle, strongest offer | Lead value prop |
| 2 | Day 3 | Threaded | Different value prop, shorter | Second value prop |
| 3 | Day 7 | Net new | Completely different angle | Third value prop |
| 4 | Optional | Threaded | Hail mary - low friction | "Is this even on your radar?" |

Rotate across the 3 value props (make money / save time / save money). Never repeat the same one.

---

## QA CHECKLIST

Before outputting any copy, run two passes:

### Pass 1 - Self-check (main thread)
Check every item below. Catches obvious issues.

### Pass 2 - Fresh-eyes review (sub-agent, when output matters)

For any of these conditions, spawn an `Explore` sub-agent for independent QA before output:
- High-stakes campaign launch (first email to a Tier 1 / A-tier prospect)
- New variant being tested (T-XXX entering test-log as Running)
- Copy on a sensitive topic (after a recent objection pattern, after an incident, after client pushback)
- Any time Harry has explicitly asked for a thorough check

**Sub-agent invocation:** see `wiki/_subagent-patterns.md` Pattern 1 (Read-only research) and `gtm-skills/fresh-eyes-reviewer.md` for the template prompt.

Skip Pass 2 for: routine sequence variants, Email 2/3 follow-ups when Email 1 already passed, low-stakes copy.

### QA Checklist Items:

- [ ] Within word count limits (ATL 60 / BTL 90 / default 75-100)?
- [ ] Passes the bar test?
- [ ] Part 1 specific to the signal - not generic?
- [ ] Part 2 uses "I" with a specific number?
- [ ] Part 3 has outcome + timeframe + risk reversal?
- [ ] CTA is one binary question?
- [ ] No question marks except the CTA?
- [ ] No links in the body?
- [ ] No banned words from `clients/{slug}/voice.md`?
- [ ] Uses only approved claims from `clients/{slug}/offer.md`?
- [ ] Different value prop from other emails in the sequence?
- [ ] Subject line 2-4 words, lowercase?
- [ ] Subject + preview reads as a complete thought?
- [ ] Register (ATL/BTL) matches the recipient title?
- [ ] Does NOT mention the signal directly?
- [ ] PRR north star confirmed?

---

## ACTIVE-TEST ENFORCEMENT

Before modifying a campaign or its sequence, check `clients/{slug}/campaign-state.md` for a `TEST ACTIVE` flag and apply the rules in `wiki/_active-test-rules.md`. Refuse changes that touch test constants without an explicit override.