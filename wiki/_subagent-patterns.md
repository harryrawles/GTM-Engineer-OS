# Sub-Agent Patterns

How skills use Claude Code's `Agent` tool to spawn isolated agents for specific tasks. Reduces context bias, increases output quality on critical decisions.

**The principle:** when a task benefits from a fresh, unbiased perspective (no session context, no prior assumptions), spawn a sub-agent. The sub-agent reads only what is passed to it and returns a focused result.

---

## When to spawn a sub-agent

| Use case | Why sub-agent | Agent type |
|----------|--------------|-----------|
| Final QA on cold email copy | Main thread may rationalise its own draft. Fresh eyes catch what the writer missed. | `Explore` (read-only) |
| Researching blacklist removal procedure during incident | Main thread context isn't needed. Specific lookup. | `general-purpose` |
| Verifying current platform status (Instantly outage, etc.) | External fact, not session-bound. | `general-purpose` |
| Industry pattern research during weekly synthesis | Wider lookup beyond our data. | `general-purpose` |
| Code review on any script we add to the OS | Bias-free review. | `code-reviewer` |

## When NOT to spawn a sub-agent

| Use case | Why not |
|----------|---------|
| Pulling current Instantly campaign metrics | Use the Instantly MCP directly — sub-agent adds latency for no benefit |
| Writing the actual email copy | Main thread has all the client context — sub-agent would have to reload it all |
| Logging to OS files | Main thread should own writes for atomicity |
| Routine reply categorisation | Pattern matching, doesn't benefit from fresh eyes |
| Quick clarification questions to Harry | Conversational — sub-agents can't do back-and-forth with Harry |

---

## Standard sub-agent invocation pattern

### Pattern 1 — Read-only research (`Explore` agent)

```
Spawn Explore agent with:
- description: "Brief description (3-5 words)"
- prompt: "Self-contained task. What to look up, what to return."

Returns: structured findings.
```

**Always tell the Explore agent:** what to search for, where to look, what format to return. It cannot ask follow-up questions.

### Pattern 2 — General-purpose research (`general-purpose` agent)

```
Spawn general-purpose agent with:
- description: "Brief description"
- prompt: "Full task description with all needed context."

Returns: detailed analysis or research output.
```

Use when the task needs more than just reading files (e.g. WebFetch, multi-step lookup).

### Pattern 3 — Code review (`code-reviewer` agent)

```
Spawn code-reviewer agent with:
- description: "Independent review of {{thing}}"
- prompt: "Context for the review + specific question."

Returns: independent assessment.
```

Use for any non-trivial code or script that lands in the OS.

---

## Cost and latency trade-offs

- **Sub-agent latency:** ~10-30 seconds typical, 60+ for heavy lookups
- **Cost:** roughly 2x token cost vs single-thread for same output (you pay for the spawn + return)
- **Value:** higher quality on the specific subtask, freed context budget in main thread

**Rule of thumb:** spawn a sub-agent when output quality matters more than speed (final copy QA, incident research) and skip when speed matters more (routine ops, replies).

---

## Configuring the sub-agent prompt

The single biggest failure mode is under-briefing the sub-agent. It has no context from the main session. Always pass:

1. **The specific task** — what you want it to produce
2. **The relevant inputs** — files to read, data to evaluate
3. **The output format** — exactly what shape the return should take
4. **The constraints** — what it should NOT do (e.g. "do not invent claims not in offer.md")
5. **The success criterion** — how it knows when it's done

Bad prompt: `"Review this copy."`
Good prompt: `"Read company/voice.md and company/offer.md. Then review the email below against (a) banned words list, (b) approved claims list, (c) word count rules for the recipient register, and (d) voice tone. Return a structured list: PASS items and FAIL items. Do NOT rewrite the copy. Do NOT suggest alternatives. Just flag failures."`

---

## How each skill uses sub-agents

| Skill | When it spawns | Agent type | Purpose |
|-------|---------------|-----------|---------|
| `cold-email-writer.md` | After draft, before final output | `Explore` | Fresh-eyes QA against voice + offer rules |
| `incident-responder.md` | During Protocol A (blacklist) and D (outage) | `general-purpose` | External fact lookup (blacklist status, platform status) |
| `weekly-reviewer.md` | During Step 7 (synthesis) | `general-purpose` | Optional — research industry-wide trends if pattern is unclear |
| `fresh-eyes-reviewer.md` | The skill itself IS the sub-agent invocation | `Explore` | Explicit manual request for review |

---

## Source

Synthesised from:
- ColdIQ frameworks docs (https://ivangfalco.github.io/claude-code-frameworks/) — sub-agent pattern section
- Claude Code Agent tool documentation