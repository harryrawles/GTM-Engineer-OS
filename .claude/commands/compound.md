---
name: gtm:compound
description: Capture a GTM win to clients/{slug}/copy-library.md and clients/{slug}/decision-log.md while context is hot. Auto-triggers on win phrases. Uses parallel subagents to extract copy, metrics, and the replicable pattern simultaneously.
argument-hint: "[optional: brief context about the win]"
---

# /gtm:compound — Win Capture

Captures a recent GTM win to the right files while the context is fresh. Uses parallel subagents for fast extraction.

**Why this exists:** the weekly-reviewer captures wins on Fridays. This captures wins NOW — in the session where the result landed, before the "why" starts to fade. The two are complementary: /gtm:compound captures the moment, weekly-reviewer promotes it after sample size is confirmed.

---

## Auto-trigger phrases

Invoke automatically when the conversation contains:
- "that worked" / "that crushed it" / "huge win" / "nailed it"
- "this is a playbook" / "we should log this" / "save this for next time"
- "PRR is [number]%" (when number >= 1.5)
- "got [n] replies" / "winning angle" / "that's the hook"
- "better than expected" / "outperformed"

Manual: `/gtm:compound [optional context]`

---

## STEP 0 — Log invocation

Append to `clients/{slug}/session-log.md` Active Log:
```
| YYYY-MM-DD HH:MM | Win capture triggered — [brief context] | gtm:compound | (filled at end) |
```

---

## Phase 1 — Parallel Research

Launch all four as parallel subagents. Each returns TEXT DATA — no file writes in Phase 1.

### Subagent 1 — Metrics Extractor
From the current conversation and `clients/{slug}/campaign-state.md`, extract:
- Campaign name, signal, target ICP/title, sequence step (Email 1/2/3)
- Sends, PRR, reply rate, meetings booked
If a metric is missing, mark `{{CONFIRM}}`.
Returns: structured metrics block.

### Subagent 2 — Copy Extractor
Find the subject line and full email body from the current conversation. If a full sequence was written this session, extract all steps. If copy is not in the conversation, mark `{{CONFIRM}}`.
Returns: full copy block per email step.

### Subagent 3 — Why-It-Worked Analyst
Read `clients/{slug}/copy-library.md` (prior entries for this signal/ICP) and `wiki/psychological-principles.md` (Biases by Copy Stage table). Identify:
- Which specific element drove performance: Part 1 signal reference, Part 2 proof, Part 3 offer framing, Part 4 CTA, sequence structure, personalisation tier?
- Which biases does this copy deliberately leverage?
- The single most portable pattern (works on a different client)
- What is client-specific and should NOT be ported verbatim
Returns: why-it-worked analysis + stealable element + portability verdict.

### Subagent 4 — Replication Strategist
Based on the win type (signal, copy angle, sequence structure, offer framing):
- Which other ICPs or verticals could use this pattern?
- What prerequisites are needed to replicate?
- Portability rating: High (copy-paste with variable swap) / Medium (adapt offer) / Low (highly client-specific)
Returns: replication guidance + portability rating.

---

## Phase 2 — Assembly (orchestrator only — wait for all Phase 1 results)

### copy-library.md entry (Top Performers section)

```
### [DATE] — [CAMPAIGN/SIGNAL NAME] — Email [N]

**Client:** [client_name]
**Signal:** [signal]
**Target ICP:** [title, company type, size]
**Sequence step:** Email [N]
**Sends:** [n] | **PRR:** [x]% | **Reply rate:** [x]% | **Meetings:** [n]

**Subject:** [subject line]

[full body copy]

**Why it worked:**
1. [Specific reason — phrase, structure, data point]
2. [Specific reason]
3. [Specific reason]

**Most stealable element:** [the portable pattern in one sentence]
**Do NOT carry over:** [what is client-specific]
**Biases leveraged:** [list from psychological-principles]
**Portability:** [High / Medium / Low — reason]
```

### decision-log.md entry

```
### [DATE] — Winner logged: [campaign/signal name]

**Type:** Copy winner
**Signal:** [signal] | **ICP:** [target] | **Step:** Email [N]
**PRR:** [x]% ([n] sends)

**Why it worked:** [same 3 reasons as copy-library]
**Stealable element:** [portable pattern]
**Replication targets:** [which clients/contexts — or "TBD — confirm after weekly review"]
```

---

## Phase 3 — Write and confirm

1. Read `clients/{slug}/copy-library.md` — confirm entry does not already exist (match by campaign name + date)
2. Append to `clients/{slug}/copy-library.md` Top Performers section
3. Append to `clients/{slug}/decision-log.md`
4. Update session-log outcome column

Output:
```
=== Win captured — [campaign/signal name] ===

copy-library: entry added to Top Performers
decision-log: entry added

Stealable element: [one line]
Portability: [High / Medium / Low]
Replication: [targets or "TBD"]

Any corrections?
```

---

## Rules

- **PRR gate:** if PRR < 1.5%, ask Harry: "PRR is [x]% — below 1.5% threshold. Log anyway as a notable test result?" If yes, log under "Notable Results" subsection, not Top Performers.
- **Sample size note:** if sends < 300, append: "Warning: Sample size [n] — below 300-send threshold. Treat as directional until confirmed at scale."
- **No duplicates:** check copy-library before writing. If a matching entry exists, ask: "Similar entry from [date] exists — update it or add as a new variant?"
- **Never invent metrics.** Missing metrics get `{{CONFIRM}}` and are surfaced at the end.
- **The why is non-negotiable.** "Good offer" is not a why. Push for the specific phrase, structure, or data point before writing.
- **Compound is for moments, weekly-reviewer is for confirmation.** An entry logged here is working data. Weekly-reviewer confirms it Friday after sample size is verified.