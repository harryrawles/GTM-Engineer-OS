# Signal Sourcing

Signal-based outbound is the highest lever on PRR. Cold lists hit 6-8% reply rate (~2-3% PRR). Single-signal hits 18-22% reply rate (~6-11% PRR). Multi-signal (3+) hits 35-40% reply rate (~12-20% PRR).

> **PRR conversion:** ColdIQ benchmarks use `reply rate` (broad — includes negatives and OOOs). Our primary KPI is **PRR** (positive reply rate). Rough conversion: `reply rate × 30-50% ≈ PRR`. Apply this when comparing to our targets.

Use this file to:
1. Decide which signals to target for a client
2. Score and prioritise leads when multiple signals fire
3. Time outreach to the optimal window per signal
4. Map each signal to a copy angle

---

## Performance Benchmarks (cite these to clients)

| Approach | Reply rate | Contract value |
|----------|-----------|----------------|
| Cold outreach (no signal) | 6-8% (~2-3% PRR) | Baseline |
| Single signal-based | 18-22% (~6-11% PRR) | 2-3x baseline |
| Multi-signal stacked (3+) | 35-40% (~12-20% PRR) | 3-4x baseline |
| Signal + ABM multi-touch | 36% meeting rate | Highest |

---

## The 6 Core Buying Signals (ranked by purchase correlation)

### 1. Former customers and alumni users
Past users of the product at new companies. Trust already established. Known playbook. Fastest path to proof of value.
- **Source:** CRM cross-reference, LinkedIn champion tracking, Clay, LoneScale, Champify
- **Angle:** "Saw you joined {{new_company}} — we worked together at {{previous_company}}. Same problem still relevant?"

### 2. New leadership (under 90 days in role)
New leaders have a mandate for early wins, vendor amnesty (no loyalty to current stack), and budget air cover.
- **Source:** LinkedIn job changes, press releases, Clay, LoneScale, Champify
- **Peak engagement window:** Days 14-45 in role
- **Angle:** Anchored on the first-90-day mandate, never on the job change itself

### 3. High-intent website and content
Pricing page, competitor comparisons, demo, integrations. Active evaluation.
- **Source:** RB2B, Common Room, Vector, Warmly, Koala
- **Reply rate:** 25-30% (they already know you)
- **Act within:** 24-48 hours
- **Angle:** Never mention you saw the visit — reference the topic they viewed

### 4. Tech stack change
Removal or new adoption of a tool in the relevant category. Fresh pain from transition, new gaps in workflow.
- **Source:** BuiltWith, HG Insights, TheirStack, Claygent
- **Window:** Active for 30-60 days
- **Angle:** Reference the gap created by the change, not the change itself

### 5. Expansion (funding, new region, new product)
Board targets create urgency. Scale pain emerges. Standardisation moment.
- **Source:** Crunchbase, PredictLeads, press releases, job postings
- **Window:** 2-4 weeks after announcement
- **Angle:** Tied to the specific stage shift their funding implies

### 6. Hiring or downsizing
Hiring = ramp pressure, efficiency mandate. Downsizing = do-more-with-less mandate.
- **Source:** LinkedIn company growth, layoff news, PredictLeads, Trigify
- **Angle:** Specific to the role being hired (or eliminated)

---

## Signal Tier System and Response SLAs

### Tier 1 — Drop-everything signals (under 1 hour)

| Signal | Action | Channel |
|--------|--------|---------|
| Demo request | Personal follow-up + calendar link | Email + phone |
| 3+ pricing page visits (VP+) | Personalised email referencing pricing | Email |
| Champion job change to target account | Congratulations + re-engagement | LinkedIn + email |
| Multiple stakeholders from same account | Map buying committee, multi-touch | All channels |

### Tier 2 — Act-today signals (under 24 hours)

| Signal | Action | Channel |
|--------|--------|---------|
| Funding round (over $10M) | "Congrats" + relevant case study | Email |
| Relevant job posting | Connect hiring pain to your solution | LinkedIn + email |
| Bombora surge score 70+ | Reference their research area | Email |
| G2 comparison activity | Send competitive battlecard | Email |

### Tier 3 — Act-this-week signals (under 72 hours)

| Signal | Action | Channel |
|--------|--------|---------|
| Funding round (under $10M) | Lighter congrats + nurture | Email |
| 3+ content articles read | Send related premium content | Email |
| Webinar attendance | Recording + related offer | Email |
| Industry news mention | Comment on news + soft touch | LinkedIn |

### Tier 4 — Monitor and nurture (automated)
Single website visit, email open without click, social follow — context only, not triggers on their own.

---

## Signal Scoring Framework

Build a score per lead. Trigger different actions at different thresholds.

### Tier 1 — Hot signals (50-100 points)

| Signal | Points |
|--------|--------|
| Demo / pricing request | 100 |
| 3+ pricing page visits in 7 days | 80 |
| Champion job change to target | 75 |
| Multiple stakeholders from same account | 70 |
| Product trial signup | 65 |
| G2 comparison with competitors | 60 |
| 5+ website visits in 2 weeks | 50 |

### Tier 2 — Warm signals (20-49 points)

| Signal | Points |
|--------|--------|
| Series A/B/C funding | 45 |
| Relevant job posting | 40 |
| Bombora topic surge (70+) | 40 |
| Case study download | 35 |
| LinkedIn engagement with your content | 30 |
| Webinar attendance | 25 |
| 3+ blog post visits | 20 |

### Tier 3 — Cool signals (5-19 points)

| Signal | Points |
|--------|--------|
| Company news (expansion) | 15 |
| Single website visit | 10 |
| Industry report download | 10 |
| Email open (no click) | 5 |
| Social follow (no engagement) | 5 |

### Recency multiplier

| Recency | Multiplier |
|---------|-----------|
| Last 24 hours | 1.5x |
| Last 7 days | 1.2x |
| Last 14 days | 1.0x |
| Last 30 days | 0.7x |
| 30+ days ago | 0.3x |

### Action thresholds

| Score | Heat | Action | SLA |
|-------|------|--------|-----|
| 150+ | Red hot | Immediate manual outreach | Under 1 hour |
| 100-149 | Hot | Personalised sequence | Under 24 hours |
| 50-99 | Warm | Automated nurture + monitor | Under 72 hours |
| 20-49 | Cool | Marketing nurture | This week |
| 0-19 | Cold | Monitor for signal changes | Ongoing |

---

## Signal Freshness Rules

| Signal | Fresh until | Optimal window | Decay |
|--------|------------|---------------|-------|
| Champion job change | 30 days | 0-14 days | Fastest — act immediately |
| LinkedIn post engagement | 30 days | 0-7 days | Fast |
| Pricing page visits | 7 days | 0-3 days | Very fast |
| Conference / event | 21 days | -7 to +7 days | Fast |
| Tech stack change | 60 days | 0-30 days | Moderate |
| New executive hire | 90 days | Days 14-30 | Moderate |
| Hiring activity | 60 days | 14-30 days | Moderate |
| Funding news | 90 days | Weeks 2-8 | Moderate |
| Series C deployment | 180 days | Weeks 5-12 | Slow |
| G2 / review activity | 90 days | 0-30 days | Moderate |
| Negative competitor reviews | 180 days | 0-60 days | Slow |
| Company news / PR | 30 days | 7-30 days | Moderate |

**Freshness rules for outreach:**
- Within optimal window → prioritise, reference directly
- Fresh but past optimal → use as context, do not lead with it
- Expired → drop from signal-based messaging, revert to ICP-based

---

## Signal Detection — 30 Triggers with Tools

### Funding and financial

| Trigger | Detection | Window |
|---------|-----------|--------|
| Series A+ funding | Crunchbase, PredictLeads, Owler, PitchBook | 0-90 days |
| Revenue milestone | News monitoring, Serper | 30-60 days |
| IPO filing / preparation | SEC filings, Crunchbase | 60-180 days |
| M&A activity | Crunchbase, PredictLeads, news | 30-90 days |
| New investment round | Clay + Intellizence | 0-60 days |

### Hiring and team changes

| Trigger | Detection | Window |
|---------|-----------|--------|
| New executive hire | LinkedIn (Clay / Lima), Sales Nav | Days 14-30 |
| Hiring surge (5+ roles) | LinkedIn Jobs, PredictLeads, Clay | 30-90 days |
| SDR / BDR hiring | LinkedIn, PredictLeads | 14-60 days |
| Department expansion | LinkedIn headcount data | 30-90 days |
| Champion job change | Clay, LoneScale, Champify | 0-30 days |

### Technology and digital

| Trigger | Detection | Window |
|---------|-----------|--------|
| New tech adoption | BuiltWith, HG Insights, TheirStack | 30-90 days |
| Tech stack removal | BuiltWith, HG Insights | 0-30 days |
| Website redesign | Claygent + web scrape | 30-60 days |
| New product launch | News, Serper, company blog | 14-60 days |
| Running LinkedIn ads | Serper API | Active = active budget |

### Competitive and vendor intelligence

| Trigger | Detection | Window |
|---------|-----------|--------|
| Negative G2 / Capterra reviews | Zenrows + G2 / Capterra | 0-90 days |
| Competitor contract expiry | PredictLeads, intent data | 60-90 days before renewal |
| Competitor downgrade / churn | BuiltWith (tech removal) | 0-30 days |
| Pricing page visits | RB2B, Common Room, Vector | 0-7 days |
| Comparison shopping | G2 buyer intent, 6sense | 7-30 days |

### Product and business events

| Trigger | Detection | Window |
|---------|-----------|--------|
| Geographic expansion | News, LinkedIn, PredictLeads | 30-90 days |
| New office / location | News, Google Maps | 30-90 days |
| Regulatory change impact | Industry news, Serper | 0-60 days |
| Conference attendance | Event sites, LinkedIn | -14 to +7 days |
| Partnership announcement | News, LinkedIn posts | 14-60 days |

### Marketing and reputation

| Trigger | Detection | Window |
|---------|-----------|--------|
| LinkedIn post engagement | Clay, Trigify, Teamfluence | 0-7 days |
| Content topic shift | Company blog monitoring | 30-60 days |
| Award / recognition | News, Serper | 14-30 days |
| PR / media mention | Serper, Google News | 7-30 days |
| Community engagement | PhantomBuster, Clay | 0-14 days |

---

## Signal Sources by Data Party

### 1st-party (your own / client own — strongest)
CRM (HubSpot, Salesforce, Attio) · Product usage (Mixpanel, Amplitude) · Meeting forms · Gated content · Marketing sequences · Website visitors (Common Room, RB2B, Vector)

### 2nd-party (partner data — strong)
Partner signals (Crossbeam, PartnerStack) · Warm intros (LinkedIn, The Swarm) · Review sites (G2, Capterra) · Champion moves (Clay, LoneScale, Champify) · Ad insights · LinkedIn engagement (Clay, Teamfluence, Trigify)

### 3rd-party (public data — moderate to strong)
Technographic (BuiltWith, HG Insights, TheirStack) · Job openings (Clay, PredictLeads) · Firmographic (Apollo, Amplemarket, Cognism) · People data (Sales Nav, Clay) · Web data (Apify, Zenrows) · Social (PhantomBuster, Trigify) · Funding (Crunchbase, Owler, PitchBook)

---

## 11 Plug-and-Play GTM Plays

### Play 1 — New team members
**Signal:** Company added a hire in a relevant department (2-4 weeks ago).
**Template:**
```
Noticed {{company}} just added {{new_hire_name}} to the {{department}} team.
Growing teams usually means {{relevant_challenge}}.
We helped {{similar_company}} handle this by {{solution}}.
Worth a quick chat?
```

### Play 2 — Skills targeting
**Signal:** LinkedIn profile lists a specific skill.
**Use:** Target by listed skills, not just titles. More precise.
Examples: Salesforce skill → Salesforce add-ons. Python → developer tools. HubSpot → marketing automation.

### Play 3 — Role targeting
**Signal:** Unusual job title indicates company priority.
Examples: "Happiness Manager" → employee wellbeing budget exists. "RevOps Manager" → RevOps is a priority. "Growth Engineer" → technical growth function.

### Play 4 — Industry-level research (create your own signal)
**Signal:** Survey ICP experts on a topic they care about. Opens conversation with a value-first approach.
**Template:**
```
Hey {{first_name}} — we are surveying {{role}} experts on {{topic}}.
We have a page listing {{insight_type}} used at {{company_types}}.
Want to contribute? [link]
```

### Play 5 — Resources for ICs (evergreen)
**Signal:** New SDRs / ICs starting roles continuously. Automated, always-on.
**Template:**
```
Hey {{first_name}}, congrats on the new role at {{company}}.
We compiled our highest-converting cold email frameworks (used by 364 SDRs already).
Here they are: [link]
Good luck.
```

### Play 6 — Leaving employees
**Signal:** Team member recently left a relevant department (1-2 weeks ago).
**Template:**
```
Saw {{former_employee}} recently left {{company}}.
That usually creates a gap in {{function_area}}.
We have been helping companies like {{similar_company}} cover that gap with {{solution}}.
Worth exploring?
```

### Play 7 — Companies without dedicated employees
**Signal:** No one with a specific title at the company.
Examples: No Content Manager + $5M+ revenue = content gap. No DevOps Engineer + growing eng team = DevOps need.

### Play 8 — Bad reviews targeting
**Signal:** Negative G2 / Capterra review of competitor with identifiable reviewer.
**Template:**
```
Just saw your review of {{competitor}}.
We tested 3 alternatives that do not suck.
Shall I send the report over?
```

### Play 9 — AI-generated ideas
**Signal:** Create personalised value through AI research.
**Template:**
```
Based on {{company_description}}, here are 3 ideas:
[1] {{AI_generated_idea_1}}
[2] {{AI_generated_idea_2}}
[3] Hire a sales prospecting agency to start generating leads on autopilot.
I would probably give better ideas with more context. Want to chat?
```

### Play 10 — Website visitor coordination
**Signal:** Visitor hits pricing page.
**Sequence:**
1. Alert triggers within 2 minutes
2. Personalised email within the hour
3. LinkedIn connection next day
4. Soft follow-up day 3

### Play 11 — Inbound followers
**Signal:** New LinkedIn follower matches ICP.
**Template:**
```
Hey {{first_name}}, thanks for the follow.
Noticed you are a {{title}} at {{company}}.
Most {{title}}s I talk to are dealing with {{common_problem}}.
Is that on your radar?
```

---

## Workflow Tips

- **Do not mention the signal explicitly in copy.** Prospects know what triggered the email. Reference the implication, not the signal.
- **Act fast.** Hot signals expire in 3-7 days.
- **Stack signals for heat scoring.** 3+ signals = reach out same day.
- **Signal-based outreach = 3-4x higher contract values** vs spray-and-pray.
- **Use 0-credit detection first** (Serper, Claygent) for initial filtering. Only spend credits on accounts that pass qualification.

---

## Source Material
Synthesised from ColdIQ GTM Skills (sachacoldiq/ColdIQ-s-GTM-Skills) signal-sourcer master skill resources.