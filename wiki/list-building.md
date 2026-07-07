# List Building

ICP definition with 100-point scoring, ABM tier system, account qualification, contact mapping, list hygiene, and data validation. Read before sourcing leads or qualifying accounts.

> Client-specific ICP lives in [clients/{slug}/icp.md](../clients/{slug}/icp.md). This file is the methodology - how to build, score, qualify, and clean.

---

## ICP Framework - 3 Layers

A precise ICP has three layers. Define all three for every client.

### 1. Firmographic (company level)
- **Industry** - primary vertical(s) and adjacent industries
- **Company size** - employee headcount sweet spot (e.g. 51-500)
- **Revenue** - annual revenue range
- **Geography** - HQ location, target markets
- **Growth rate** - headcount growth signals
- **Funding stage** - seed, Series A-C, PE-backed, public

### 2. Technographic
- **Tech stack** - what they currently use (Sales Nav has 35,000+ technology filters)
- **CRM used** - Salesforce, HubSpot, Pipedrive
- **Marketing automation** - Marketo, Pardot, Mailchimp
- **Competitive tools** - using a competitor's product

### 3. Behavioural / intent signals
- Job postings (hiring for roles your product supports)
- Funding events (new budget)
- Leadership changes (new decision-makers open to change)
- Content engagement (LinkedIn buyer intent, Bombora, 6sense)
- Website visits (Clearbit Reveal, Leadfeeder, RB2B)

---

## ICP Scoring System (100 points)

Score every account on these dimensions.

| Criterion | Weight | Scoring |
|-----------|--------|---------|
| Industry match | 20 | Exact = 20, Adjacent = 10, None = 0 |
| Company size | 15 | Sweet spot = 15, Adjacent = 8, Outside = 0 |
| Revenue range | 15 | Sweet spot = 15, Adjacent = 8, Unknown = 0 |
| Geography | 10 | Primary = 10, Secondary = 5, Other = 0 |
| Technology fit | 15 | Complement = 15, Neutral = 8, Competitor = 5 |
| Growth signals | 10 | High = 10, Moderate = 5, Stagnant = 0 |
| Intent signals | 15 | Strong = 15, Some = 8, None = 0 |

### Tier assignment

| Score | Tier | Approach |
|-------|------|----------|
| 90-100 | Tier A | Perfect fit. Maximum resources, multi-threaded ABM, custom outreach. |
| 70-89 | Tier B | Strong fit. Targeted sequences, personalised messaging. |
| 50-69 | Tier C | Moderate fit. Automated nurture, content marketing. |
| Under 50 | Tier D | Poor fit. Exclude from outreach, inbound-only. |

---

## ABM Tier Structure (for prioritising effort)

| Tier | Accounts | Approach | Resources |
|------|----------|----------|-----------|
| **Tier 1 (1:1)** | 10-50 | Fully custom, multi-threaded | Maximum - custom content, executive outreach, direct mail |
| **Tier 2 (1:Few)** | 50-200 | Segment-based personalisation | Medium - industry/persona templates, targeted ads |
| **Tier 3 (1:Many)** | 200-1,000 | Programmatic, automated | Low - automated sequences, broad messaging |

---

## Account Qualification Process

1. **Apply ICP scoring matrix** (100-point system)
2. **Layer intent data** to adjust scores dynamically
3. **Assign ABM tier** based on final score
4. **Map contacts per account** (see contact mapping table)

### Intent data layers

| Layer | Sources | Strength |
|-------|---------|----------|
| **1st-party** | Website visits, pricing page views, content downloads, webinar attendance | Strongest |
| **2nd-party** | G2 buyer intent, TrustRadius, Capterra reviews/comparisons | Strong |
| **3rd-party** | Bombora, 6sense, ZoomInfo Intent, TechTarget | Moderate |
| **LinkedIn-native** | Buyer intent signals, ad engagement, page followers | Moderate |

**Scoring adjustment:** Add 10-20 points for strong 1st-party intent. Add 5-10 for 2nd / 3rd-party. An account scoring 65 (Tier C) with strong 1st-party intent jumps to 75-85 (Tier B).

---

## Contact Mapping per Account

Map all 6 roles for Tier 1 accounts. Tier 2 maps 3-4. Tier 3 maps the decision-maker only.

| Role | Typical titles | Purpose |
|------|---------------|---------|
| Economic buyer | CEO, CFO, VP | Final budget approval |
| Champion | Director, Head of | Internal advocate |
| Technical evaluator | Manager, Architect | Technical fit |
| End user | Analyst, Specialist | Daily product user |
| Blocker | Legal, Compliance | Can slow or stop deal |
| Coach | Any level | Provides insider information |

---

## Lookalike Building

Process for building lookalike lists from best customers:

1. Export top 10-20 customers (by revenue, LTV, or NPS)
2. Analyse common attributes: industry, size, geography, tech stack, growth stage
3. Build lookalike search in Sales Navigator matching those attributes
4. Use "Similar Companies" feature on company pages
5. External tools: Ocean.io, Clearbit, Apollo.io, Clay

---

## List Hygiene and Data Validation

### Critical metrics

| Metric | Target | Danger zone |
|--------|--------|-------------|
| Bounce rate | Under 1% | Over 3% = pause campaigns immediately |
| Spam complaint rate | Under 0.1% | Over 0.3% = investigate |
| Email deliverability | 95%+ | Under 90% = infrastructure issue |

### Data decay rates

- **Email addresses:** 22-30% annual decay (~2.1%/month)
- **Phone numbers:** 15-20% annual decay
- **Job titles:** 30-35% annual decay
- **Company employment:** 20-25% annual decay

### List hygiene schedule

| Frequency | Action |
|-----------|--------|
| **Before every campaign** | Full email verification on entire list |
| **Weekly** | Monitor bounce rates, remove hard bounces |
| **Monthly** | Re-verify risky and catch-all emails |
| **Quarterly** | Full re-verification, update job titles, purge unengaged (no opens/clicks in 90 days) |
| **Bi-annually** | Complete data refresh from LinkedIn, re-verify all |
| **Annually** | Full ICP audit, rebuild lists from scratch |

**Rule:** Re-verify any list older than 30 days before sending.

### Verification result categories

| Category | Action |
|----------|--------|
| Valid / deliverable | Safe to send (target: 95%+ of list) |
| Invalid / undeliverable | Remove immediately |
| Risky / accept-all (catch-all) | Send cautiously or sub-verify with ListKit |
| Unknown | Treat as risky, do not send |
| Disposable | Remove (temporary email) |
| Role-based (info@, sales@) | Remove - higher spam complaint risk |
| Toxic / spam trap | Remove immediately |

### Verification tools

| Tool | Cost | Accuracy | Best for |
|------|------|----------|----------|
| ZeroBounce | $0.008/email | 98%+ | High-volume, agencies |
| NeverBounce | $0.008/email | 99.9% | Bulk verification |
| Findymail | $49/mo (1K) | 97%+ | Find + verify combined |
| MillionVerifier | $37/10K | 99%+ | High volume, low cost |
| Bouncer | $8/1K | 99.5% | EU compliance focus |

### Tool selection by volume

- Under 1K/month → Findymail ($49, finds + verifies)
- 1K-10K/month → NeverBounce ($0.008/email, 99.9% guarantee)
- 10K+/month → MillionVerifier ($37/10K, best cost)
- EU-focused → Bouncer or Dropcontact (GDPR-compliant)
- Catch-all heavy → add ListKit / Listman.io as secondary

### Bounce handling workflow

```
Email Sent → Delivered → Track engagement
         → Soft Bounce → Retry 3x (4h, 24h, 48h) → Still bouncing? → Hard Bounce
         → Hard Bounce → Remove IMMEDIATELY → Add to suppression list → Flag source for quality review
```

---

## Worked Examples

### Example 1 - HR software to mid-market
ICP definition:
- **Firmographic:** 200-2,000 employees, $20M-$500M revenue, US/Canada
- **Technographic:** Using BambooHR, Workday, or ADP
- **Behavioural:** Hiring HR roles, posting about "employee experience"

Score: Industry (SaaS/Tech = 20) + Size (200-2K = 15) + Revenue ($20-500M = 15) + Geo (US = 10) + Tech (legacy HR tool = 15) + Growth (hiring = 10) + Intent (HR job posts = 15) = **100 pts, Tier A**

### Example 2 - Prioritising 500 accounts
1. Apply ICP scoring matrix across all 500
2. Sort by score
3. Top 10-50 (Tier A, 90+ pts) = Tier 1 ABM with custom outreach
4. Next 50-150 (Tier B, 70-89) = Tier 2 with segment-based sequences
5. Remaining (Tier C, 50-69) = Tier 3 automated
6. Below 50 = exclude
7. Layer intent data from G2 / Bombora to re-rank

### Example 3 - Building from best customers
1. Export top 20 customers by ARR
2. Identify patterns (e.g. all SaaS, 100-500 employees, US-based, using HubSpot, Series A-C funded)
3. Build Sales Nav search matching these attributes
4. Use Ocean.io for automated lookalike expansion
5. Score new accounts against the same matrix

---

## Source Material
Synthesised from ColdIQ GTM Skills list-building master skill - define-icp, qualify-accounts, clean-validate sub-skills and data-validation resource.