---
name: skill-forge
description: Auto-creates a new skill file from a detected pattern. Invoked by pattern-detector when Harry replies "forge it" to a pattern detection. Drafts a new skill following OS conventions, saves with forged- prefix for Harry's review before promotion to the routing table.
triggers:
  - "Forge a skill for {{pattern}}"
  - "forge it" (in response to pattern-detector)
  - "Create a skill that automates {{intent}}"
  - "Run /skill-forge"
reads:
  - "wiki/_skill-context.md"
  - "wiki/_subagent-patterns.md"
  - "clients/{slug}/session-log.md (to study the pattern's example prompts)"
  - "gtm-skills/*.md (sample existing skills for format)"
  - "Any existing skills that handle related work (to avoid duplication)"
writes:
  - "gtm-skills/forged-{name}.md (the new skill candidate)"
  - "clients/{slug}/session-log.md (Forged skills tracking table)"
  - "clients/{slug}/MEMORY.md (adds to Active Focus for review)"
  - "clients/{slug}/decision-log.md (forging rationale)"
---

# Skill: Skill Forge

**Trigger:** "Forge a skill for [pattern]", "forge it" (in response to pattern-detector), "Create a skill that automates [intent]"

**Context:** This skill takes a pattern detected by `gtm-skills/pattern-detector.md` and drafts a new skill that automates the repeated workflow. The result is saved as `gtm-skills/forged-{name}.md` with a `forged-` prefix so it is clearly an auto-generated candidate awaiting review, not a canonical OS skill.

**Why this exists:** the OS only becomes exponentially improving if patterns turn into reusable skills. Pattern-detector finds the patterns. Skill-forge crystallises them.

**Safety:** forged skills are NEVER auto-promoted to CLAUDE.md routing table. They land as candidates with `forged-` prefix. Harry reviews, refines, and then manually promotes by renaming (drop the prefix) and adding to the routing table.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## INPUTS

From pattern-detector or direct invocation:
- **Pattern intent name** (e.g. `diagnose-campaign-performance`)
- **Example prompts** that triggered the detection (3+ historical prompts)
- **Frequency** (N times in N days)

---

## STEP 1 — Confirm Scope

Before drafting, confirm with Harry:

1. **Skill name proposal.** Default: `forged-{intent-name}` (e.g. `forged-quick-diagnose`). Ask if Harry wants a different name.
2. **Trigger phrases.** Show the 3+ example prompts. Propose 3-5 trigger phrases that should auto-invoke the new skill. Get confirmation.
3. **Scope check.** Compare the pattern intent against existing skills:
   - If 80%+ overlap with an existing skill → ASK Harry: "An existing skill `{{name}}` already handles most of this. Should we update that skill instead of forging a new one?"
   - If 30-80% overlap → propose forging a thinner skill that orchestrates the existing one. (Often the right answer is a chain, not a new skill.)
   - If under 30% overlap → genuine net-new skill, proceed.

**Output of Step 1:** a one-paragraph scope statement Harry confirms before drafting.

---

## STEP 2 — Study the Pattern

Read the example prompts in detail. Identify:

1. **What does Harry do today** when this prompt fires? (Which sub-skills, which files, which manual steps?)
2. **What are the inputs?** (Specific information Harry provides each time)
3. **What is the output?** (What gets produced or decided)
4. **What is the cognitive overhead?** (Why is this worth automating — what is slow without a skill?)
5. **What are the variations?** (How do the prompts differ? The skill must handle all variations.)

Read existing skills that handle related work — both for inspiration on format AND to avoid duplication.

---

## STEP 3 — Draft the Skill

Generate a new skill file following OS conventions. Required structure:

```markdown
---
name: forged-{{intent-name}}
description: {{One-sentence description of what the skill does, written like a CLAUDE.md routing entry.}}
triggers:
  - "{{primary trigger phrase}}"
  - "{{variation 1}}"
  - "{{variation 2}}"
reads:
  - "wiki/_skill-context.md"
  - {{other relevant files based on pattern}}
writes:
  - {{files this skill updates}}
forged_from:
  - pattern: "{{intent-name}}"
  - example_prompts: {{count}}
  - detected: {{date}}
  - status: pending_review
---

# Skill: {{Human-readable name}}

**Trigger:** {{trigger phrases}}

**Context:** {{Why this skill exists, distilled from the pattern Harry has shown.}}

**Forged from pattern:** detected on {{date}}. See ``clients/{slug}/session-log.md`` Forged skills table.

---

## STANDARD CONTEXT

See ``wiki/_skill-context.md``.

## SKILL-SPECIFIC READS

{{Pull from what Harry typically reads when running this manually}}

---

## STEP 1 — {{First step}}

{{Step content based on what Harry actually does}}

## STEP 2 — {{Second step}}

{{Step content}}

## STEP N — {{Final step}}

{{Step content}}

---

## RULES

- {{Rules Harry should follow when this skill runs — derived from the pattern}}

---

## EXAMPLES

### Example 1

{{Use one of the historical prompts as the example, with the expected output}}
```

The draft does NOT have to be perfect. It is a candidate. Harry will refine.

---

## STEP 4 — Save with `forged-` Prefix

Save the new file to:

```
gtm-skills/forged-{{name}}.md
```

The `forged-` prefix is **mandatory and load-bearing**:
- Signals this skill is auto-generated, not yet vetted
- Excludes it from CLAUDE.md routing table by default
- Reminds future-Harry to review before promoting

---

## STEP 5 — Log the Forging

### Update `clients/{slug}/session-log.md` Forged skills table:

```
| forged-{{name}} | {{intent-name}} | {{date}} | Pending review | (blank until promoted) |
```

### Update `clients/{slug}/MEMORY.md` Active Focus:

```
- 🆕 Forged skill: `gtm-skills/forged-{{name}}.md` — created {{date}} from {{N}} repeating prompts. Review and either promote (rename to drop `forged-` prefix + add to CLAUDE.md routing) or delete.
```

### Update `clients/{slug}/decision-log.md`:

```
### {{date}} — Forged new skill: {{name}}

**Context:**
- Pattern detected: {{N}} matching prompts in {{period}}
- Example prompts: {{list}}

**Decision:**
Forged `gtm-skills/forged-{{name}}.md` to automate this repeating workflow.

**Why:**
- High frequency ({{N}} in {{period}}) suggests genuine recurring need
- Existing skills do not cover this scope (or cover <30% of it)
- Estimated time saved: {{rough estimate per invocation}}

**Outcome (to update):**
- Review by: {{Harry, within 7 days}}
- Decision: promote / refine / delete
```

---

## STEP 6 — Output to Harry

Show Harry:

```
=== Skill Forged: forged-{{name}} ===

Saved to: gtm-skills/forged-{{name}}.md
Forged from pattern: {{N}} prompts matching "{{intent-name}}" in {{period}}

Next steps for you:
1. Review the draft: gtm-skills/forged-{{name}}.md
2. Refine the content if needed (it is a draft, not perfect)
3. To PROMOTE: rename file (drop `forged-` prefix) + add row to CLAUDE.md routing table
4. To DELETE: just remove the file. The pattern will not be re-suggested (already in Forged skills table).

The next time you make a prompt matching this pattern, the OS will route to the forged skill candidate (even before promotion). Test it in real use before promoting.
```

---

## RULES

- **Never promote a forged skill yourself.** The `forged-` prefix must remain until Harry manually renames. Promotion is the operator's call.
- **Always confirm scope first.** Do not draft until Harry confirms the proposed skill name, triggers, and that it does not duplicate an existing skill.
- **Match OS conventions.** New skill must follow the same frontmatter + standard context + steps + rules + examples structure as canonical skills.
- **Cite the pattern.** The forged skill must include a `forged_from:` block in frontmatter and a reference in the first section. Provenance matters.
- **One skill per forge run.** Do not forge multiple skills in a single invocation. If multiple patterns surfaced, handle them one at a time.
- **Forged skills are routable.** Even before promotion, future invocations matching the pattern can route to `gtm-skills/forged-{{name}}.md`. This lets Harry test in real use.

---

## EXAMPLES

### Example — Forging from a diagnose-campaign pattern

```
Harry: forge it

Claude:
=== Confirming scope before drafting ===

Proposed name: forged-quick-diagnose
Proposed triggers:
  - "Quick diagnose [campaign]"
  - "Why is [campaign] off"
  - "What's wrong with [campaign]"

Scope check:
  - 60% overlap with existing chain-diagnose-campaign (which is the full diagnostic flow)
  - The pattern is for FAST, single-glance diagnoses without invoking the full chain
  - Recommend: forge a thinner skill that runs just campaign-optimiser + immediate output (no specialist routing, no test queuing)
  - Net-new value: ~30% (the "quick" variant Harry asks for is faster than the chain)

Confirm? (Y to draft / N to skip / M to modify)

Harry: Y

[skill-forge drafts gtm-skills/forged-quick-diagnose.md]
[updates session-log, MEMORY, decision-log]
[shows Harry the next steps]
```
