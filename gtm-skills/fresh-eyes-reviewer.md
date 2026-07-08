---
name: fresh-eyes-reviewer
description: Explicit manual fresh-eyes review on any artefact - cold email copy, ICP definition, offer positioning, campaign launch decision, client response draft. Spawns the dedicated fresh-eyes-reviewer sub-agent (.claude/agents/fresh-eyes-reviewer.md, Read/Grep/Glob only - cannot write) that reads only what is passed to it, returns a structured pass/fail review with no context bias from the main session.
triggers:
  - "Fresh-eyes review this"
  - "Get a fresh-eyes review on {{X}}"
  - "Run independent QA on this"
  - "Review this without bias"
reads:
  - "wiki/_skill-context.md"
  - "wiki/_subagent-patterns.md"
  - "(passes target files to sub-agent - does not read them itself)"
writes:
  - "(nothing - review is for the GTME's evaluation)"
---

# Skill: Fresh-Eyes Reviewer

**Trigger:** "Fresh-eyes review this", "Get a fresh-eyes review on [X]", "Run independent QA on this", "Review this without bias"

**Context:** Sometimes the main session has rationalised something into existence. This skill explicitly spawns the isolated `fresh-eyes-reviewer` sub-agent (`.claude/agents/fresh-eyes-reviewer.md`) to evaluate the artefact with no context bias. The sub-agent reads only what is passed to it, cannot write or run commands (Read/Grep/Glob only), and returns a structured pass/fail review.

**Use this when:**
- About to send copy that feels right but you're not sure
- ICP definition feels narrow or broad - want a second look
- Offer positioning has shifted - verify it still holds together
- Client response draft on a sensitive topic
- Any high-stakes artefact where overconfidence is the risk

---

## STANDARD CONTEXT

See `wiki/_skill-context.md` and `wiki/_subagent-patterns.md`.

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

## STEP 1 - Identify the Artefact

Ask the GTME:
1. **What's being reviewed?** (paste the copy, file content, decision summary, etc.)
2. **What's the standard?** (e.g. "voice + offer rules", "ICP scoring rubric", "campaign launch checklist")
3. **What specifically worries you?** (helps focus the sub-agent)

---

## STEP 2 - Configure the Sub-Agent

Prepare the prompt with:
- **Specific task:** what to evaluate
- **Files to read:** voice.md, offer.md, the artefact itself
- **Output format:** structured pass/fail
- **Constraints:** what NOT to do (no rewriting, no alternatives)
- **Success criterion:** how it knows when it's done

Template prompt for cold email review:
```
Read clients/{slug}/voice.md and clients/{slug}/offer.md. Then read the email below.

Review against these specific rules:
1. Word count (ATL ≤60, BTL ≤90, default 75-100)
2. Banned words from voice.md
3. Approved claims only from offer.md
4. Voice tone match
5. PRR-optimised structure (4-part formula or named framework)
6. No question marks except CTA
7. No links in body
8. Single CTA, binary question
9. Subject 2-4 words lowercase
10. Bar test (sounds natural read aloud)

For each rule, return PASS or FAIL with specific reason.

Do NOT rewrite the email.
Do NOT suggest alternatives.
Do NOT explain the rules.
Just return the structured review.

Email to review:
---
[paste the email]
---
```

---

## STEP 3 - Spawn the Sub-Agent

Use the `fresh-eyes-reviewer` agent type (`.claude/agents/fresh-eyes-reviewer.md`):
- **Structurally read-only** - tools limited to Read/Grep/Glob only, so it cannot write, edit, or run
  shell commands, not just instructed not to
- **No prior context** - starts with nothing but the prompt template below
- **Purpose-built system prompt** - the "never rewrite, never explain the rule, PASS/FAIL only" behaviour
  is baked into the agent itself, not just this skill's instructions
- Description: "Fresh-eyes review of [artefact type]"

---

## STEP 4 - Present the Result

Show the GTME:
- The sub-agent's structured review (PASS / FAIL items)
- The original artefact (so the GTME can see what the review applies to)
- Any clear next action

**Do NOT auto-rewrite based on FAILs.** The review is information for the GTME's judgment. If the review surfaces real issues, the GTME can choose to re-invoke the appropriate skill (cold-email-writer, etc.) with the FAIL context.

---

## STEP 5 - Optional Log

If the review surfaced a non-trivial issue (a FAIL that almost shipped), log a brief note to `clients/{slug}/MEMORY.md` Recent Learnings:

```
{{date}} - Fresh-eyes caught {{specific issue}} that would have shipped. Pattern: {{the underlying rule that failed}}.
```

This helps future sessions catch similar issues earlier.

---

## RULES

- **Always pass the full artefact to the sub-agent.** Do not assume it knows context - it doesn't.
- **Always tell the sub-agent what NOT to do.** Otherwise it will try to be helpful by rewriting, which defeats the purpose.
- **Never override a FAIL silently.** If the review flags something and the GTME decides to ship anyway, document the override in MEMORY.md or decision-log.md.
- **Use the dedicated agent, not a generic one.** `fresh-eyes-reviewer` (Read/Grep/Glob only) is purpose-built for this; don't substitute `Explore` or `general-purpose`, both of which retain broader tool access this review never needs.
- **Single-purpose per invocation.** Don't ask the sub-agent to "review and improve" - review only. Improvements are a separate invocation of the original skill.

---

## EXAMPLES

### Example - Reviewing a cold email before send

```
GTME: Fresh-eyes review this email before I push it to {{PRIMARY_CONTACT}} for approval:

Subject: hiring speed
Saw the senior eng hires coming in. Most VPs of Eng at this stage are losing 10-15 hrs/week interviewing low-signal candidates from outsourcing firms. We only source from VC-backed product companies - {{NAMED_PROOF_COMPANY}}'s VP closed 4 hires this way, saved $100k vs in-house. Want a sample shortlist?

Claude:
Spawning fresh-eyes-reviewer sub-agent for independent review against voice + offer rules...

[~20 seconds]

=== Fresh-Eyes Review Result ===

1. Word count: PASS - 64 words (within default 75-100, well within ATL 60 ceiling if recipient is VP - borderline)
2. Banned words: PASS - no use of "leverage", "synergy", "game-changer", etc.
3. Approved claims: PASS - "{{NAMED_PROOF_COMPANY}} $100k" is in offer.md approved list; "VC-backed product companies" is in differentiators
4. Voice tone: PASS - direct, specific, data-led
5. PRR structure: PASS - 4-part formula intact (Part 1 personalisation, Part 2 social proof with number, Part 3 offer with proof, Part 4 binary CTA)
6. No question marks except CTA: PASS - only CTA has the question
7. No links in body: PASS
8. Single CTA: PASS - "Want a sample shortlist?"
9. Subject 2-4 words lowercase: PASS - "hiring speed" (2 words, lowercase)
10. Bar test: PASS - sounds natural

FAILS: 0
WARNINGS: 1 - At 64 words this works for BTL register (Manager / IC) but is borderline for ATL register (VP / C-Level - should ideally be ≤60 words). If recipient is VP Engineering and considered ATL, trim 4-5 words. If BTL, ship as-is.

OVERALL: SHIP (with awareness of register borderline)
```