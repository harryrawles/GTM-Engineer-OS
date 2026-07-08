---
name: campaign-analyst
description: Pulls campaign data from Instantly, structures it into a top-level health check, campaign-level breakdown, and signal/copy analysis, then outputs a prioritised action list ranked by expected PRR impact.
triggers:
  - "Analyse the campaign data"
  - "what does the data say"
  - "performance review"
  - "how are campaigns performing"
  - "give me an analysis"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/campaign-state.md"
  - "clients/{slug}/icp.md"
  - "clients/{slug}/test-log.md"
writes:
  - "(none - analysis is presented for the GTME's review)"
---

# Skill: Campaign Analyst

**Trigger:** "Analyse the campaign data", "what does the data say", "performance review", "how are campaigns performing", "give me an analysis"

**Context:** Pulling campaign data from Instantly, structuring it, identifying what is working, what is not, and making strategic recommendations. The goal is a clear view of performance and a prioritised action list.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `clients/{slug}/campaign-state.md` - current benchmarks and infrastructure
- `clients/{slug}/icp.md` - ICP to sanity-check list quality
- `clients/{slug}/test-log.md` - what has been tested and what is currently running

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

## BEFORE YOU ANALYSE

Pull from the Instantly API for the active client (via `.claude/bin/instantly.sh` - see `sops/instantly-api.md`):
- All campaigns: sends, PRR, bounce rate (last 30 days)
- Per-campaign and per-step breakdown
- Subject line performance
- Reply categorisation (positive, negative, OOO)

Ask the GTME to paste data if MCP is unavailable.

---

## ANALYSIS FRAMEWORK

### 1. Top-level health check

| Metric | This period | Benchmark | Status |
|--------|-------------|-----------|--------|
| PRR | {{%}} | Per `sops/campaign-performance-standards.md` | Green / Amber / Red |
| Bounce rate | {{%}} | Under 2% (5%+ critical, `wiki/deliverability.md`) | Green / Amber / Red |
| Meetings booked | {{n}} | Client target | Green / Amber / Red |

### 2. Campaign-level breakdown

Rank all active campaigns by PRR. Identify:
- Top performer: highest PRR - what is driving it?
- Bottom performer: lowest PRR - what is the root cause?
- Any campaign with bounce rate over 5% - flag as deliverability issue (critical threshold, `wiki/deliverability.md`)

### 3. Signal analysis

Which signal type is generating the best PRR?
- Is one signal consistently outperforming others?
- Is any signal performing worse than it did in the previous period?
- Are there signals not yet being tested that should be?

### 4. Copy analysis

- Which email step (1, 2, or 3) is generating the most replies?
- If Email 2 or 3 is outperforming Email 1, the Email 1 offer needs work.
- Which subject lines have the highest open rate?
- Are there patterns in positive replies (tone of response, what they referenced)?

### 5. Strategic recommendations

Output a prioritised list of 3 recommended actions. Each action should be:
- Specific (not "improve copy" - "test a shorter CTA in Email 2")
- Tied to a data point
- Ranked by expected impact on PRR

---

## OUTPUT FORMAT

**Period:** {{Date range}}
**Client:** {{CLIENT_NAME}}

**Summary in one sentence:** {{What is the overall picture - up, flat, declining, and why}}

**Top-level metrics:** [table]

**What is working:** [2-3 specific observations with data]

**What needs attention:** [1-2 specific problems with evidence]

**Recommended actions:**
1. {{Highest impact action}}
2. {{Second priority}}
3. {{Third priority}}

**Metrics to watch next week:** {{What to track as an early indicator of improvement}}

---

## QA CHECKLIST

Before presenting the analysis:

- [ ] Every recommended action is specific, not generic ("test a shorter CTA in Email 2", not "improve copy")?
- [ ] Every observation is tied to a data point, not a hunch?
- [ ] Recommendations are ranked by expected PRR impact, highest first?
- [ ] No metric stated without its source (Instantly pull vs GTME-provided)?