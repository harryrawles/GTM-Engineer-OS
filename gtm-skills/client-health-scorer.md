---
name: client-health-scorer
description: Computes a 100-point health score per client weekly. Surfaces clients at churn risk. Runs as part of weekly-reviewer batch mode or standalone. Output flags Green/Amber/Red and recommends interventions.
triggers:
  - "Score {{client}} health"
  - "Health check on {{client}}"
  - "Which clients are at risk"
  - "Portfolio health"
  - "Client risk assessment"
reads:
  - "wiki/_skill-context.md"
  - "company/campaign-state.md"
  - "company/comms-log.md"
  - "company/copy-library.md"
  - "company/overview.md"
writes:
  - "company/decision-log.md (if status changes)"
  - "company/_config.md (health field)"
---

# Skill: Client Health Scorer

**Trigger:** "Score [client] health", "Health check on [client]", "Which clients are at risk", "Portfolio health"

**Context:** At 20 clients, knowing which ones are at risk is the most important meta-question Harry will face every Monday. This skill computes a structured health score per client and surfaces churn risk early.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

- `company/campaign-state.md` — current campaign metrics
- `company/comms-log.md` — client sentiment proxy
- `company/copy-library.md` — recent winners (good sign)
- `company/overview.md` — SLA, success criteria

Pull from Instantly MCP: last 4 weeks of campaign data (need trend, not just snapshot).

---

## SCORING — 100 POINTS

### 1. Performance vs Target (40 points)

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| PRR vs target (from overview.md success criteria) | 20 | Hitting = 20, 80% of target = 14, 50% = 8, <50% = 0 |
| Meetings booked vs target | 15 | Hitting = 15, 80% = 10, 50% = 6, <50% = 0 |
| Reply-to-meeting conversion | 5 | >25% = 5, 15-25% = 3, <15% = 1 |

### 2. Trend (15 points)

Compare last 4 weeks against prior 4 weeks.

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| PRR trend | 10 | Improving = 10, Flat = 6, Declining = 0 |
| Meeting volume trend | 5 | Improving = 5, Flat = 3, Declining = 0 |

### 3. Deliverability (10 points)

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| Bounce rate | 5 | <2% = 5, 2-3% = 3, 3-4% = 1, >4% = 0 |
| Warmup status | 3 | All green = 3, Any amber = 1, Any red = 0 |
| Blacklist status | 2 | Clean = 2, Any listing = 0 |

### 4. Engagement Quality (10 points)

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| Positive reply percentage of total replies | 5 | >50% positive = 5, 30-50% = 3, <30% = 1 |
| Negative reply rate | 3 | <5% = 3, 5-10% = 2, >10% = 0 |
| Unsubscribe rate | 2 | <0.5% = 2, 0.5-1% = 1, >1% = 0 |

### 5. Client Sentiment Proxy (10 points)

From `company/comms-log.md` (last 30 days):

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| Tone of recent client messages | 4 | Positive = 4, Neutral = 2, Frustrated/negative = 0 |
| Response latency to client | 3 | All within SLA = 3, Some misses = 1, Multiple misses = 0 |
| Unanswered client requests | 3 | None = 3, 1 outstanding = 2, 2+ outstanding = 0 |

### 6. Operational Hygiene (10 points)

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| Weekly review run on time | 4 | Last 4 weeks = 4, Missed 1 = 2, Missed 2+ = 0 |
| Decision log updated recently | 3 | Within 14 days = 3, 14-30 days = 1, >30 = 0 |
| Tests actively running | 3 | At least one = 3, None = 0 |

### 7. Strategic Position (5 points)

| Sub-metric | Weight | Scoring |
|-----------|--------|---------|
| Renewal date proximity + signals | 5 | >90 days + positive = 5, 30-90 days + positive = 3, Renewal at risk = 0 |

---

## HEALTH BANDS

| Score | Status | Action |
|-------|--------|--------|
| 80-100 | **Green** | Healthy. Maintain rhythm. |
| 60-79 | **Green-Amber** | Performing but watch trends. Consider increasing test cadence. |
| 40-59 | **Amber** | At risk. Active intervention needed within 1 week. |
| 20-39 | **Red** | Critical. Immediate action. Consider proactive client conversation. |
| 0-19 | **Critical / Churn imminent** | Escalate. Crisis playbook. Renewal in jeopardy. |

---

## OUTPUT FORMAT

### Single client

```
=== Client Health Score — {{CLIENT_NAME}} — {{date}} ===

OVERALL: {{n}}/100 → {{Band}} {{emoji}}

Breakdown:
1. Performance vs Target    | {{n}}/40
   - PRR (target {{X}}%, actual {{Y}}%)     | {{n}}/20
   - Meetings (target {{X}}, actual {{Y}})  | {{n}}/15
   - Reply-to-meeting conversion             | {{n}}/5

2. Trend                    | {{n}}/15
   - PRR: {{trend}}                          | {{n}}/10
   - Meetings: {{trend}}                     | {{n}}/5

3. Deliverability           | {{n}}/10
   - Bounce {{X}}%                           | {{n}}/5
   - Warmup {{status}}                       | {{n}}/3
   - Blacklist {{status}}                    | {{n}}/2

4. Engagement Quality       | {{n}}/10
   - Positive % of replies                   | {{n}}/5
   - Negative rate                           | {{n}}/3
   - Unsubscribe                             | {{n}}/2

5. Client Sentiment         | {{n}}/10
   - Recent tone                             | {{n}}/4
   - SLA hits                                | {{n}}/3
   - Open requests                           | {{n}}/3

6. Operational Hygiene      | {{n}}/10
   - Weekly review streak                    | {{n}}/4
   - Decision log freshness                  | {{n}}/3
   - Tests running                           | {{n}}/3

7. Strategic Position       | {{n}}/5

Key risks:
- {{specific risk 1}}
- {{specific risk 2}}

Recommended interventions:
- {{action 1}}
- {{action 2}}

Last status: {{previous score}} → Change: {{+/- n}}
```

### Portfolio (all clients)

```
=== Portfolio Health — {{date}} ===

| Client      | Score | Band  | Top risk                              | Action |
|-------------|-------|-------|---------------------------------------|--------|
| Recruitcha  | 78    | Green-Amber | PRR trending down 2 weeks       | Run optimiser |
| {{B}}       | 92    | Green | None                                  | Maintain |
| {{C}}       | 41    | Amber | Client requested 2 changes unanswered | Address requests TODAY |
| {{D}}       | 18    | Critical | Renewal in 14 days, no movement    | ESCALATE — direct call |
...

Clients needing intervention (Amber or below): {{n}}
Clients in critical band: {{n}}

Suggested order of attention:
1. {{Critical client}} — {{specific action}}
2. {{Amber client}} — {{specific action}}
3. ...
```

---

## RULES

- **Run weekly minimum.** Embedded in weekly-reviewer batch mode.
- **Never report a score without breakdown.** A single number without context is noise.
- **Surface trends, not just snapshots.** A 70 trending down to 50 is more urgent than a steady 60.
- **Recommended interventions must be specific.** Not "improve performance" — "run campaign-optimiser on hiring campaign, the PRR drop is concentrated there."
- **Log status changes** to `company/decision-log.md`:
  - Going from Green → Amber
  - Going from Amber → Red
  - Going from Red → Critical
  - Returning from Amber → Green (recovery — worth understanding why)
- **Critical band triggers escalation.** Notify Harry separately, do not bury in batch output.

---

## EXAMPLES

### Example — single client (Amber)

```
Harry: Score Recruitcha health

Claude:
=== Client Health Score — Recruitcha — 2026-05-29 ===

OVERALL: 52/100 → Amber

Breakdown:
1. Performance vs Target    | 21/40
   - PRR (target 2.0%, actual 1.1%)         | 11/20
   - Meetings (target 8, actual 5)          | 9/15
   - Reply-to-meeting conversion 18%         | 1/5

2. Trend                    | 4/15
   - PRR: declining 4 weeks straight        | 0/10
   - Meetings: flat                         | 4/5

3. Deliverability           | 9/10
4. Engagement Quality       | 7/10
5. Client Sentiment         | 6/10
6. Operational Hygiene      | 4/10
   - Weekly review missed 2 of last 4 weeks | 0/4
   - Decision log updated 22 days ago       | 1/3
   - 0 active tests                          | 0/3
7. Strategic Position       | 1/5
   - Renewal in 47 days, no upsell motion

Key risks:
- PRR declining 4 weeks → underlying problem (signal saturation? offer fatigue?)
- Operational hygiene slipped → weekly review skipped twice
- Renewal approaching with no positive momentum

Recommended interventions:
- THIS WEEK: run campaign-optimiser on hiring campaign (root cause analysis)
- THIS WEEK: queue a new test (priority order: offer framing)
- THIS WEEK: run weekly review — restart cadence
- NEXT 7 DAYS: schedule renewal prep call with client

Last status: 71 → Change: -19 (significant decline — escalate to Harry)
```