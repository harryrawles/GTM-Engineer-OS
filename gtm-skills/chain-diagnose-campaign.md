---
name: chain-diagnose-campaign
description: Performance diagnostic chain. Runs primary campaign-optimiser diagnosis, then conditionally routes to the right specialist (deliverability-doctor, list-builder, signal-sourcer, or cold-email-writer for new variant). Avoids the "manually invoke 5 skills to figure out what's wrong" workflow.
triggers:
  - "Diagnose [client] [campaign]"
  - "Why is [campaign] underperforming"
  - "Run /diagnose-campaign"
  - "Investigate [campaign] performance"
  - "[Campaign] is broken"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/_config.md, MEMORY.md, campaign-state.md, decision-log.md, copy-library.md, test-log.md"
invokes:
  - "gtm-skills/campaign-optimiser.md (always)"
  - "gtm-skills/deliverability-doctor.md (conditional)"
  - "gtm-skills/list-builder.md (conditional)"
  - "gtm-skills/signal-sourcer.md (conditional)"
  - "gtm-skills/cold-email-writer.md (conditional - if new variant recommended)"
  - "gtm-skills/test-readiness-check.md (conditional - if test recommended)"
  - "gtm-skills/test-launcher.md (conditional - if test approved)"
writes:
  - "clients/{slug}/decision-log.md (diagnosis + action taken)"
  - "clients/{slug}/campaign-state.md (health rating update)"
  - "clients/{slug}/test-log.md (if test queued)"
---

# Skill: Chain - Diagnose Campaign

**Trigger:** "Diagnose [client] [campaign]", "Why is [campaign] underperforming", "Run /diagnose-campaign", "Investigate [campaign] performance"

**Context:** Campaign performance diagnostic chain. Runs the primary `campaign-optimiser` diagnosis first to identify root cause category, then conditionally invokes the right specialist skill - without making the GTME manually route between deliverability-doctor, list-builder, signal-sourcer, etc.

**Why this exists:** when a campaign tanks, root cause could be deliverability, list quality, signal saturation, or copy fatigue. Manually invoking each diagnostic in turn wastes time. This chain runs the primary diagnosis once, then routes intelligently.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## STEP 0 - Pull Metrics (always)

**Log this invocation first.** Append a row to `clients/{slug}/session-log.md` Active Log per `wiki/_skill-context.md` "Session-Log Write" rules. Format: `| YYYY-MM-DD HH:MM | {{paraphrased prompt}} | chain-diagnose-campaign | (filled at end) |`. Sub-skills invoked later will write their own rows.

Then read:
- `clients/{slug}/campaign-state.md` - which campaign, what is the recent trend
- `clients/{slug}/MEMORY.md` - any prior watch-outs on this campaign
- Pull from the Instantly API (via `.claude/bin/instantly.sh` for the active client): last 14 days metrics per campaign

Output a quick metric snapshot:

```
Campaign: [name]
Last 7 days: PRR [X]%, bounce [Z]%, meetings [n]
Last 30 days trend: [improving / flat / declining]
Health rating per campaign-state.md: [Green/Amber/Red]
Active test: [yes/no - if yes, note T-ID]
```

If active test is running on this campaign - surface the strict-block constraint immediately. Diagnose is read-only against active tests; any recommended fix that touches constants requires the override pattern.

---

## STEP 1 - Run Primary Diagnostic (always)

Invoke `gtm-skills/campaign-optimiser.md`. This produces a root cause hypothesis with confidence level.

The optimiser's decision tree categorises root cause as one of:
1. **Deliverability** - bounce/spam/warmup issues
2. **List quality** - ICP drift, stale list, false-positive signals
3. **Signal** - signal saturated, signal type fatiguing, wrong signal for current ICP
4. **Offer** - Part 3 of formula not landing
5. **Copy** - Part 1/2/4 issues, register mismatch, banned words slipped through
6. **Sequence** - value props not rotating, follow-up timing wrong, Email 1 vs Email 2/3 imbalance
7. **Personalisation** - tier wrong for volume × ACV
8. **Volume / pacing** - sending too fast, list too small for sustainable pace

Optimiser output: one root cause + confidence + recommended next action.

---

## STEP 2 - Route to Specialist (conditional)

Based on the optimiser's root cause:

### Cause = Deliverability
→ Invoke `gtm-skills/deliverability-doctor.md`. Full triage protocol. Stop the bleed.

**Pause-point:** show the GTME the deliverability assessment and recovery plan before any infrastructure change.

### Cause = List quality
→ Invoke `gtm-skills/list-builder.md` STEP 6 - Audit Mode. Re-verifies the current list against ICP. Output: % of leads that still match ICP, count of false positives, list refresh recommendation.

**Pause-point:** show the GTME the audit results. Decide: refresh list, tighten ICP, or both.

### Cause = Signal
→ Invoke `gtm-skills/signal-sourcer.md`. Surface signal performance trend (matches Step 2 of weekly-reviewer). Recommend pivot to alternative signal from `wiki/signal-sourcing.md` plays.

**Pause-point:** show the GTME the alternative signal proposal. Decide: pivot signal, refresh current signal angle, or hold.

### Cause = Offer / Copy / Sequence / Personalisation
→ Diagnose deeper using optimiser's output. If a copy change is needed: invoke `gtm-skills/cold-email-writer.md` to draft a new variant.

**Pause-point:** show the GTME the variant proposal.

### Cause = Volume / pacing
→ No specialist invocation. Output recommended pacing change. The GTME actions in Instantly directly.

---

## STEP 3 - Queue Corrective Test (conditional)

If Step 2's specialist recommends a corrective test (e.g. new variant, signal pivot, list segment), invoke `gtm-skills/test-readiness-check.md` on the proposed test.

- If READY → invoke `gtm-skills/test-launcher.md` (subject to GTME confirmation)
- If NOT READY → output gaps, return to Step 2 for re-planning

This ensures any diagnostic-driven fix gets tested under the scientific method, not just deployed by gut feel.

---

## STEP 4 - Update State + Logs (always)

After diagnosis + action:

1. Update `clients/{slug}/campaign-state.md`:
   - Health rating (Green/Amber/Red) per current metrics
   - Note any infrastructure or signal changes
   - Note any active test launched as a result

2. Write to `clients/{slug}/decision-log.md`:
   - Diagnosis findings
   - Specialist invoked
   - Action taken
   - Expected impact + when to verify

3. Update `clients/{slug}/MEMORY.md` Active Focus if this campaign is now under watch.

---

## CHAIN OUTPUT FORMAT

```
=== Chain Complete: Diagnose Campaign - [campaign] ===

Primary diagnosis: [root cause category]
Confidence: [High/Medium/Low]
Evidence: [specific data point]

Specialist invoked: [which skill]
Recommendation: [specific change]
Expected impact: [PRR lift / cost reduction / etc.]

Test queued: [yes/no - if yes T-ID and readiness verdict]

Files updated:
- campaign-state.md (health → [rating])
- decision-log.md (diagnosis entry)
- test-log.md (if test queued)

Next: [what the GTME should action - manual step in Instantly, await test result, etc.]
```

---

## RULES

- **Run primary diagnostic first, every time.** Do not skip campaign-optimiser to "save time" - its root cause categorisation is what makes routing intelligent.
- **One specialist per chain run.** If diagnosis surfaces multiple issues, action the highest-confidence one first. Subsequent runs handle the others.
- **Respect active-test strict block.** If a test is running and the recommended fix touches a constant, surface the override pattern. Do not auto-invalidate tests.
- **Pause at every specialist invocation.** The chain is decision support, not auto-execution.
- **Always log to decision-log.** Future-GTME needs to know why X campaign got fixed in Y way at Z date.
