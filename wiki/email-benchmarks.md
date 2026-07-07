# Email Benchmarks

Industry benchmarks for calibrating expectations, setting KPIs, and diagnosing performance. Read this before agreeing targets with a client or judging whether a campaign needs intervention.

---

## Performance by Outreach Type

| Outreach Type | Reply Rate |
|---------------|------------|
| Cold outreach (no signal) | 6-8% |
| Single signal-based | 18-22% |
| Multi-signal stacked (3+) | 35-40% |
| Website visitor follow-up | 25-30% |
| Champion job change | 20-25% |
| Signal + ABM multi-touch | 36% meeting rate |

> Note: ColdIQ measures "reply rate" broadly. Our primary KPI is **Positive Reply Rate (PRR)** - replies expressing interest, excluding negatives and OOOs. PRR runs roughly 30-50% of the reply rate above. So 18-22% reply rate = ~6-11% PRR.

---

## PRR Benchmarks (Primary KPI)

**The KPI: PRR ≥ 1% → scale.** A 5% reply rate with 20% of those replies positive is a 1% PRR - that
already clears the bar. Do not confuse the raw reply rate with PRR; PRR is the fraction of *sends* that
are positive replies, not the fraction of *replies* that are positive.

| Tier | PRR | Status |
|------|-----|--------|
| Scale | 1%+ | Scale, do not change copy |
| Acceptable | 0.5-1% | Iterate primary variable |
| Underperforming | Under 0.5% | Diagnose root cause urgently |

---

## Open and Click Rate Benchmarks

| Metric | Baseline | Good | Great |
|--------|---------|------|-------|
| Open rate | 20-40% | 50% | 60%+ |
| Click rate | 2-5% | 5-8% | 10%+ |

**Important:** Open rate is largely vanity. iOS / Apple Mail Privacy Protection auto-fetches images, inflating opens. PRR is what matters.

---

## Deliverability Benchmarks

| Metric | Target | Warning | Critical |
|--------|--------|---------|----------|
| Bounce rate | Under 2% | 2-5% | Over 5% |
| Spam complaint rate | Under 0.1% | 0.1-0.3% | Over 0.3% |
| Unsubscribe rate | Under 0.5% | 0.5-1% | Over 1% |

---

## Volume Benchmarks

| Variable | Recommended |
|----------|-------------|
| Cold emails per mailbox per day | 30-50 (max 50-100) |
| Mailboxes per domain | 2-3 |
| Domains per sender | 3-5 |
| Minimum sample for split test | 300 sends per variant |
| Warmup volume during active campaigns | 10-20/day per mailbox |

---

## Email Length Benchmarks by Persona

| Target | Max sentences | Max words |
|--------|--------------|-----------|
| ATL (VPs, C-Level, Directors) | 2-3 | 60 |
| BTL (Managers, ICs) | 3-4 | 90 |
| Canonical standard | 4 (per formula) | ATL 60 / BTL 90 / default 75 |

---

## Sequence Performance Norms

### Email 1
- Highest open rate
- Sets the tone
- Most important to optimise
- Should produce ~60% of total sequence replies

### Email 2 (Day 3)
- 40-60% of Email 1 opens
- Different angle
- Shorter than Email 1
- ~25% of total sequence replies

### Email 3 (Day 7-14)
- New subject line, new thread
- Fresh angle
- Delegation ask effective ("Is this even on your radar?")
- ~10-15% of sequence replies

### Email 4 (Break-up - optional)
- Often surprisingly high reply rate
- Creates urgency
- Clean exit
- ~5-10% of sequence replies

If Email 2 or 3 outperforms Email 1, the Email 1 offer needs work.

---

## Quick Diagnostics - Symptom to Cause

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Low opens (under 30%) | Subject line or deliverability | A/B test subjects, check spam score |
| Opens but no replies | Message relevance | More personalisation, shorter copy, different offer |
| Replies but no meetings | Weak CTA or poor qualification | Clearer ask, better targeting |
| High unsubscribe | Too aggressive or wrong ICP | Reduce frequency, refine targeting |
| Bounce rate climbing | List quality or domain reputation | Re-verify list, check blacklists |
| PRR declining over time | List fatigue or burned signal | Refresh ICP, change signal type |

---

## Optimisation Priority Order

### If open rate is low (under 30%)
1. Test subject lines (2-4 word formulas)
2. Check sender reputation (Postmaster Tools / SNDS)
3. Verify deliverability (DNS, blacklists)
4. Test send times

### If reply rate is low (under 2%)
1. Improve relevance / personalisation
2. Shorten the message
3. Strengthen the CTA
4. Add specific social proof
5. Test a different framework (see wiki/copywriting-frameworks.md)

### If meeting book rate is low (under 20% of replies)
1. Qualify better in the message
2. Improve CTA clarity
3. Reduce friction to book
4. Follow up faster (under 5 minutes ideal)

---

## Response Time Benchmarks

| Signal type | Best practice | Industry average | Impact |
|------------|--------------|-----------------|--------|
| Inbound demo | Under 5 min | 42 hours | 21x more likely to qualify at 5 min vs 30 min |
| Website visitor (high intent) | Under 1 hour | 24-48 hours | 10x higher conversion same-day |
| Champion job change | Under 24 hours | 1-2 weeks | 3x higher win rate as first mover |
| Funding announcement | Under 72 hours | 1-2 weeks | Window closes as competitors swarm |
| Intent surge | Under 24 hours | Not tracked | 50% of value lost after 7 days |

---

## ColdIQ Benchmarks (from 250K+ emails)

| Metric | Target |
|--------|--------|
| Open rate | 50%+ |
| Positive reply rate | 5-8% |
| Meeting book rate | 2-4% |
| Variance between worst/best variant | 13x gap |

Aggressive but achievable with strong signals + personalisation + tight copy.

---

## Source Material
Synthesised from ColdIQ email-metrics-benchmarks skill and signal-sourcer performance data.