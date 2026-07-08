---
name: signal-sourcer
description: Designs and scores signal-based campaign strategy - signal selection and ranking, the scoring framework and action thresholds, and signal-to-play design with response SLAs.
triggers:
  - "What signals should we target"
  - "build a signal-based campaign"
  - "signal scoring"
  - "which signals work for {{client}}"
  - "design a signal strategy"
  - "score these leads"
  - "what is the next signal to test"
reads:
  - "wiki/_skill-context.md"
  - "wiki/signal-sourcing.md, buying-triggers.md"
  - "clients/{slug}/icp.md, offer.md"
writes:
  - "clients/{slug}/test-log.md (signal experiments logged)"
---

# Skill: Signal Sourcer

**Trigger:** "What signals should we target", "build a signal-based campaign", "signal scoring", "which signals work for {{client}}", "design a signal strategy", "score these leads", "what is the next signal to test"

**Context:** Signal-based outbound is the highest lever on PRR (raw reply rate lift is roughly 2-3x for
single-signal, 3-4x for multi-signal, over cold - see `wiki/signal-sourcing.md`). This skill designs and
scores signal strategy for a client.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `wiki/signal-sourcing.md` - the 6 core signals, scoring framework, freshness rules, 11 GTM plays
- `clients/{slug}/icp.md` - client ICP to filter which signals apply
- `clients/{slug}/offer.md` - what the client sells to map signal → angle

**REFERENCE (consult when needed):**
- `wiki/buying-triggers.md` - 137-trigger taxonomy across inbound/postbound/bridgebound/outbound
- `best-practices/playbooks/` - check for a reusable playbook matching the client's offer/angle to start the campaign from (adapt per client; never use verbatim)
- `wiki/email-benchmarks.md` - response time SLAs and performance benchmarks

---

## ROUTING TABLE

| Request | Route to |
|---------|----------|
| "Which signals should we target?" | Signal selection (Step 1 below) |
| "Score these leads / build a scoring system" | Scoring framework (Step 2) |
| "Design a play for {{signal}}" | Play design (Step 3) |
| "Outbound feels saturated, what is next?" | Read `wiki/buying-triggers.md` - escalate to bridgebound triggers |
| "How fast do we need to act on {{signal}}?" | Freshness rules in `wiki/signal-sourcing.md` |

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

## STEP 1 - Signal Selection

For a new campaign, work through this:

1. **What does the client sell?** Read `clients/{slug}/offer.md`.
2. **Who buys it?** Read `clients/{slug}/icp.md`.
3. **What changes in the prospect's world right before they buy?** That is the signal.
4. **Cross-reference** with the 6 core signals in `wiki/signal-sourcing.md`:
   - Former customers and alumni users
   - New leadership (under 90 days)
   - High-intent website / content
   - Tech stack change
   - Expansion (funding, region, product)
   - Hiring or downsizing
5. **Pick 2-3 signals to test first.** Rank by:
   - How predictive is it of buying intent?
   - What is the detection cost?
   - How saturated is it (are competitors targeting too)?

Output: 2-3 ranked signals with detection tool, timing window, and copy angle for each.

---

## STEP 2 - Scoring Framework

For a client with multiple signals firing per lead:

1. Read the scoring table in `wiki/signal-sourcing.md`.
2. Assign point values per signal type (Tier 1: 50-100, Tier 2: 20-49, Tier 3: 5-19).
3. Apply recency multiplier (1.5x for last 24h, decreasing to 0.3x past 30 days).
4. Define action thresholds (matches `wiki/signal-sourcing.md`'s action-thresholds table exactly):
   - 150+ = drop everything, manual outreach within 1 hour
   - 100-149 = personalised sequence within 24 hours
   - 50-99 = automated nurture, monitor
   - 20-49 = marketing nurture, this week
   - Under 20 = monitor only

Output: a scoring rubric in `clients/{slug}/test-log.md` or as a Clay formula.

---

## STEP 3 - Signal-to-Play Design

For each signal, design a play with these 7 components:

1. **Trigger** - exactly what fires it
2. **Qualification** - does the account match `clients/{slug}/icp.md`?
3. **Timing** - response SLA (see `wiki/email-benchmarks.md`)
4. **Sequence** - channel and step count
5. **Messaging template** - angle tied to the signal (not the signal itself)
6. **Owner** - who actions it (the GTME vs automated)
7. **Escalation** - what happens if no response

Use the 11 plug-and-play plays in `wiki/signal-sourcing.md` as starting points.

---

## RULES

- **Do not mention the signal in the email copy.** Prospects know what triggered the outreach. Reference the implication, not the signal.
- **Act fast.** Hot signals expire in 3-7 days. Stale signals revert to cold.
- **Stack signals for heat scoring.** 3+ signals firing = reach out same day.
- **Use 0-credit detection first** (Serper, Claygent). Only spend enrichment credits on accounts that pass qualification.
- **Log every signal experiment** in `clients/{slug}/test-log.md`. Signal sourcing is iterative.

---

## QA CHECKLIST

Before handing off the signal strategy:

- [ ] Each signal ranked with a stated reason (predictive value, detection cost, saturation)?
- [ ] Response SLA assigned per signal matches its Tier in `wiki/signal-sourcing.md`?
- [ ] Copy angle references the implication of the signal, not the signal itself?
- [ ] Signals cross-checked against `clients/{slug}/icp.md`, not applied generically?