# Inbound Orchestration

The inbound-led outbound model: detect intent signals, enrich them, qualify them, then trigger outbound BEFORE the prospect raises their hand. Closes the loop between marketing signals and outbound action.

**Why this matters:** cold prospects reply at 6-8%. Inbound signal-triggered outbound replies at 18-22%. Multi-signal stacked hits 35-40%. The biggest leverage in cold email is whether the prospect should be cold in the first place.

> **PRR conversion:** ColdIQ benchmarks use reply rate broadly. PRR is approximately `reply rate × 30-50%`.

---

## The 5 Inbound Signals That Matter

| Signal | Reply Rate | Best Timing | How to Detect |
|--------|-----------|-------------|---------------|
| **Website Visitors** | 25-30% (~8-15% PRR) | Same day | Clearbit Reveal, 6sense, RB2B, Leadfeeder |
| **Job Changes** (0-90 days) | 3x cold baseline | Days 14-45 | Clay job change tracking, LinkedIn, LoneScale |
| **Hiring for Specific Roles** | Budget + growth signal | Within days of posting | PredictLeads, Apollo, LinkedIn |
| **Funding Announcements** | Fresh capital, urgency | 2-4 weeks post-announcement | Crunchbase, Intellizence |
| **Technology Changes** | Active buying window | Immediately | BuiltWith, HG Insights, 6sense |

---

## The Four-Stage Flow

```
Detect → Enrich → Qualify → Activate
```

### Stage 1 - Detect

Capture signals from these sources:

- **Website visitor identification** - de-anonymise company / person visiting your site
- **Content engagement** - downloads, pricing page views, case study reads
- **Social engagement** - LinkedIn post interactions, ad engagement
- **Intent data providers** - 6sense, Bombora (category research)
- **Job change monitoring** - champions moving to new companies
- **Hiring signals** - companies posting roles your solution supports
- **Funding / news** - Crunchbase, press releases, Claygent monitoring

### Stage 2 - Enrich

Run detected signals through Clay (or equivalent):

- Company enrichment (firmographics, technographics, ICP scoring)
- Contact discovery (find the right person at the company)
- Email waterfall (verify contact info)
- ICP fit scoring (A/B/C/D tier)

### Stage 3 - Qualify

Apply the 100-point ICP scoring from `wiki/list-building.md` to determine priority:

| Tier | Score | Action |
|------|-------|--------|
| **A** | 80-100 | Hot - route to sales immediately, trigger personalised sequence |
| **B** | 60-79 | Warm - add to nurture sequence with signal-based messaging |
| **C** | 40-59 | Cool - add to content / awareness campaigns |
| **D** | <40 | Disqualify - do not waste outreach |

### Stage 4 - Activate

Match the tier and signal to the right outbound motion:

| Lead profile | Action | Channel | SLA |
|-------------|--------|---------|-----|
| **A-tier + hot signal** (pricing page, demo no-show) | Slack alert to the GTME, personalised same-day outreach | Email + LinkedIn | <1 hour |
| **A-tier + warm signal** | Premium sequence (cold-email-writer with full personalisation) | Email | <24 hours |
| **B-tier + any signal** | Automated sequence (cold-email-writer with lite hook) | Email | <48 hours |
| **C-tier** | Content drip, LinkedIn connection, long-term nurture | Multi-channel | Ongoing |
| **D-tier** | Disqualify, log to graveyard | None | N/A |

---

## Signal Stacking - The Heat Score Multiplier

The more signals overlap, the hotter the lead:

| Signals stacked | Classification | Action |
|----------------|---------------|--------|
| 1 signal | Warm | Add to standard sequence |
| 2 signals | Hot | Priority outreach within 24h |
| 3+ signals | On fire | Same-day outreach + Slack alert + sales call attempt |

**Example:** Company visited pricing page (signal 1) + recently raised Series B (signal 2) + hiring for the role your product serves (signal 3) = immediate, personalised outreach.

See `wiki/signal-sourcing.md` Step 2 - Signal Scoring for the point-by-point heat score.

---

## Speed-to-Lead - The Single Biggest Conversion Lever

Response time impact on conversion (Velocify, ColdIQ benchmarks):

| Response time | MQL → SQL conversion | Notes |
|--------------|---------------------|-------|
| Within 5 minutes | 21x more likely to qualify | Live demo / pricing inquiry |
| Within 1 minute | 391% higher conversion | Demo desk inbound |
| Within 1 hour | 53% conversion | Standard SLA for A-tier |
| After 24 hours | 17% conversion | Industry average - but punishes hard |

**The 36-point gap between 1-hour and 24-hour response is the single biggest controllable factor in funnel conversion.**

### Recommended SLAs per signal type

| Signal | SLA |
|--------|-----|
| Demo request | <5 minutes |
| Pricing page (multiple visits) | <1 hour |
| Funding announcement | <72 hours (peak window is weeks 2-8) |
| Champion job change | <24 hours (peak window is days 14-45) |
| Hiring signal | <48 hours |
| Content download | 2-24 hours |

---

## Clay Templates for Inbound Orchestration

If Clay is connected (check `clients/{slug}/campaign-state.md` Tools section):

| Template | What it does |
|---------|--------------|
| Website Visitor → Enrichment → Sequence | De-anonymise → enrich → push to outbound |
| Job Change Tracker | Monitor champion movements → trigger re-engagement |
| Funding Announcement Tracker | Detect funding → enrich → route to sequence |
| Hiring Signal Detector | Detect relevant job posts → enrich → sequence |
| Multi-Signal Stacker | Combine 3+ signals → heat score → prioritise |
| Slack Notification Workflow | Alert on hot inbound signals in real-time |

---

## Inbound Lead Source Performance Benchmarks

Not all inbound channels convert equally:

| Lead source | MQL → SQL conversion | Notes |
|-------------|--------------------|-------|
| SEO (organic search) | 51% | Highest mid-funnel conversion |
| Email marketing | 46% | High mid-funnel, needs nurture downstream |
| Webinars | 30% | Engaged audiences |
| PPC | 26% | Lower mid-funnel, recovers in close rate |
| Events | 24% | Long-term nurture required |

**Key insight:** SEO leads convert at nearly 2x PPC. When a client invests in paid, ask whether organic investment would produce better ROI on the same budget.

---

## Tech Stack for Inbound Orchestration

Detection layer (which client tools are connected determines what's possible):

| Function | Recommended tools |
|---------|-------------------|
| Website visitor ID | Clearbit Reveal, 6sense, RB2B, Leadfeeder, Vector |
| Intent data | 6sense, Bombora, Common Room |
| Champion tracking | Clay, LoneScale, Champify |
| Hiring signals | PredictLeads, Apollo, LinkedIn Jobs |
| Funding signals | Crunchbase, Intellizence, Owler |
| Tech changes | BuiltWith, HG Insights, TheirStack |
| Enrichment | Clay, Clearbit |
| Engagement | Instantly, Smartlead, HeyReach |
| Alerts | Slack, email, Notion |

If a client has zero detection tools → outbound is fully cold-list-based, which limits PRR ceiling. Recommend even one detection tool (Clay + Apollo at minimum) to enable signal-based outbound.

---

## MQL → SQL Handoff Definitions

For clients with structured funnels:

| Stage | Definition |
|-------|-----------|
| **MQL** (Marketing Qualified Lead) | Raised hand via bottom-funnel engagement (demo request, pricing page, content download) |
| **SAL** (Sales Accepted Lead) | Discovery call booked with intended prospect |
| **SQL** (Sales Qualified Lead) | Meeting held; basic needs fit identified |
| **Opportunity** | Active deal with budget, authority, need, timeline (BANT) |

### BANT qualification

To convert an MQL to an Opportunity, gather on the call:
- **Budget** - Do they have budget allocated?
- **Authority** - Are you talking to the decision-maker?
- **Need** - Do they have the problem your client solves?
- **Timeline** - When are they looking to act?

---

## When This Skill Fires

Use `gtm-skills/inbound-activator.md` when:

- An inbound signal lands (website visitor identified, RB2B alert fires, funding news breaks)
- A client request mentions an inbound trigger ("{{PRIMARY_CONTACT}} said RB2B picked up someone from {{company}}")
- Weekly review surfaces an unconverted inbound signal that was missed
- A reply mentions "I was just looking at your page" or similar inbound context

---

## Source Material

Synthesised from:
- ColdIQ GTM Skills `03-revops/lead-management/inbound-orchestration-framework.md`
- ColdIQ benchmarks for response time and signal performance
- Cross-referenced with `wiki/signal-sourcing.md` (our existing signal-detection guide)