---
name: spintax-ninja
description: Applies {{RANDOM|...}} spintax to drafted email copy - what to spin vs lock, word-level vs phrase-level spin, spacing standard, and an 11-item QA checklist before output.
triggers:
  - "Apply spintax"
  - "spintax this email"
  - "spin this copy"
  - "add spintax variance"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/voice.md"
  - "wiki/copywriting-101.md, subject-lines.md"
writes:
  - "(none - output is a code block in chat, never saved to a file)"
---

# Skill: Spintax Ninja

**Trigger:** "Apply spintax", "spintax this email", "spin this copy", "add spintax variance"

**Context:** Several hard rules in the OS say to use spintax (`wiki/copywriting-101.md`, `wiki/subject-lines.md`, `gtm-skills/cold-email-writer.md`) but none of them define the exact syntax or process. This skill is that definition: the precise `{{RANDOM|...}}` format, what gets spun versus locked, and the QA checklist that must pass before anything ships.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `clients/{slug}/voice.md` - banned words and approved claims apply to spun variants exactly as they apply to the original copy. A variant is not exempt just because it sits inside a spin group.

**REFERENCE (consult when needed):**
- `wiki/copywriting-101.md` - the hard rule this skill executes ("Spintax and liquid syntax - vary copy at scale")
- `wiki/subject-lines.md` - the subject-line spintax cadence (every 2-3 words) this skill's spacing standard applies to
- `gtm-skills/cold-email-writer.md` - the skill that produces the copy this one spins

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

## Rules

### Format

- Output spintax in `{{RANDOM|option1|option2|option3}}` format (double braces, always using the RANDOM keyword). Never use single braces.
- Preserve all original whitespace, line breaks, and structure.
- Always display output directly in the chat response inside a code block to preserve spacing. Do not save to a file.

### Spacing Standard

Every email block must follow this exact structure, one blank line between every element, no exceptions:

```
[STEP X VARIANT Y]

subject line

--

Body text goes here as a single paragraph.

CTA line

{{RANDOM|Best,|Regards,|Cheers,|Sincerely,}}

{{sendingAccountFirstName}} {{RANDOM|with|@|from|at}} Company Name

{{RANDOM|P.S.|Note:|fyi -|final note -}} {{RANDOM|...}}

--

[NEXT STEP OR VARIANT]
```

Rules:
- One blank line between every element, no exceptions
- This includes: above and below `--`, between salutation and name, between name and PS
- If the body copy spans 3 or more lines, separate distinct sentences or paragraphs with a blank line

### What to Spin

- **Spin:** words or short phrases with semantic weight, verbs, verb phrases, adjectives, adverbs, non-specific nouns.
- **Do not spin:** proper nouns, brand names, personal names/merge tags (e.g. `{{firstName}}`), numbers, statistics, URLs, CTAs (e.g. "Book a call"), and any term the GTME flags as locked.
- Maximum 3 spin instances per sentence.
- Maximum 3 variants per spin group.
- If only 1 good variant exists, use 2 options. If no good variant exists, leave the word as-is.

### Word-Level vs Phrase-Level Spin

- Always try word-level spin first: find 2 strong single-word synonyms.
- If word-level spin produces unnatural, weak, or awkward results, escalate to phrase-level spin: group 2-3 surrounding words and spin the whole phrase.

Example: instead of `{{RANDOM|send|share|forward}}` it over, use `{{RANDOM|send it over|share that with you|forward that across}}`.

- Phrase-level spin groups must stay short (2-4 words) and must not restructure the broader sentence.
- Each phrase variant must slot into the sentence identically. The words before and after the spin group must remain unchanged and grammatically compatible with all variants.

### Quality Bar for Variants

- Every variant must preserve the original meaning without changing the sentence's intent.
- Variants must match the tone and register of the original (formal stays formal, casual stays casual).
- No two variants in the same group may share the same root word.

Bad: `{{RANDOM|help|helping|helped}}` - all share "help".
Good: `{{RANDOM|help|support|assist}}`.

- Do not introduce capitalisation or punctuation that did not exist in the original.

---

## Process

Handle multiple emails sequentially, complete one full email (subject + body) before moving to the next.

For each email:

1. **READ** - Understand the email's intent, tone, and audience. Do not explain this step.
2. **IDENTIFY CANDIDATES** - For each sentence, identify words eligible for spinning (semantic weight, not locked). Select no more than 3 per sentence. Attempt word-level spin first. If it produces weak or unnatural results, escalate to phrase-level spin for that instance.
3. **VALIDATE COMBINATIONS** - For every sentence spun, mentally run all possible combinations of the chosen variants. Confirm each combination is grammatically correct and logically coherent. If any combination fails, revise before proceeding.
4. **QA** - Run the Spintax QA Checklist below. Only output once all answers are "yes".
5. **OUTPUT** - Return the spintaxed email in the same structural format as received (subject line, then body).

---

## Spintax QA Checklist

Answer internally for each question. If any answer is "no", revise and recheck before outputting.

1. Did I spin a maximum of 3 instances per sentence?
2. Did I provide a maximum of 3 variants per spin group?
3. Are all variants true synonyms or equivalent phrases that preserve the original meaning?
4. Do all variants match the tone and register of the original?
5. Do no two variants in any group share the same root word?
6. For phrase-level spin groups: does each variant slot into the surrounding sentence without altering the words before or after the group?
7. Did I leave all locked terms (names, CTAs, stats, brand names, merge tags) untouched?
8. Did I avoid introducing new capitalisation or punctuation?
9. Does every possible combination of spun variants in each sentence read as grammatically correct and logically coherent?
10. Does the output follow the spacing standard, one blank line between every element, no exceptions?
11. Is the output displayed directly in the chat response inside a code block?

---

## Where this fits in the OS

- **This is the concrete definition behind the "use spintax" hard rule.** `wiki/copywriting-101.md` and `gtm-skills/cold-email-writer.md` both say to use spintax for scale variation; neither defines the format. This skill is how.
- **`wiki/subject-lines.md`'s "spintax every 2-3 words" cadence rule applies inside this skill's spacing standard** - the subject line is the first element in the block above.
- **`gtm-skills/test-launcher.md` and `gtm-skills/campaign-launcher.md` each have a QA item confirming spintax is preserved before a test or campaign goes live.** That check is against the format this skill defines.
- **`clients/{slug}/voice.md` constrains variant word choice exactly as it constrains the original copy.** Banned words and off-limits claims cannot enter through a spin group.
- **Pre-existing ColdIQ-sourced material is out of scope for retrofit.** `best-practices/playbooks/*` and `wiki/personalization-at-scale.md` predate this rule and commonly use more than 3 variants per spin group (some sign-off lines run 5-22 variants). Per `CLAUDE.md`'s Source Knowledge policy, uploaded material extends the primary methodology but never overrides it - these stay as reference examples, not rewritten. The 3-max rule governs new spintax this skill produces going forward.
- **`wiki/glossary.md`'s Spintax and Liquid syntax rows stay generic definitions.** This skill is the executable process behind the term.
