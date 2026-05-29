# Campaign State — Recruitcha (Example)

Live status of all outbound campaigns. Updated by weekly-reviewer every Friday.

**Last updated:** 2026-05-29

---

## Active Campaigns

| Campaign name | Signal | Launch date | Mailboxes | Sends/day | Status | Health |
|--------------|--------|-------------|-----------|-----------|--------|--------|
| Hiring Signal v4 | 3+ eng job postings | 2026-03-10 | 6 | 240 | Active | Green |
| Series A-C Funding v2 | Funded 30-90 days ago | 2026-04-15 | 4 | 160 | Active | Amber |
| Champion Job Change | Former candidate at new co | 2026-05-01 | 2 | 30 | Active | Green (low vol) |

## Tools & Tech Stack

| Tool | Connected | Notes |
|------|-----------|-------|
| Instantly | Yes | Primary sender |
| Clay | Yes | Used for hiring signal enrichment |
| RB2B | No | Not deployed for this client |
| LoneScale | Yes | Champion job change detection |
| Findymail | Yes | Email verification + finder |
| Apollo | No | Not used |
| Slack | Yes | Reply alerts → #recruitcha-instantly |

---

## Campaign Detail

### Hiring Signal v4

**Signal:** 3+ engineering job postings in last 30 days (detected via LoneScale + LinkedIn Jobs scrape)
**ICP slice:** VC-backed SaaS, 20-150 employees, US-based, Series A-C
**Sequence:** 3-step email

| Step | Day | Subject line | Purpose |
|------|-----|-------------|---------|
| Email 1 | Day 0 | hiring speed | Main pitch — 72hr shortlist + TurboTenant case |
| Email 2 | Day 3 | one role | Specific role angle + HealthNote case |
| Email 3 | Day 7 | radar check | Hail mary — "is this on your radar" |

**Current metrics (last 30 days):**
- Sends: 5,824
- Reply rate: 5.1%
- PRR: 2.3%
- Meetings booked: 11
- Bounce rate: 1.2%

**Health:** Green
**Stop conditions:** bounce >4%, PRR <0.8% after 1,000 sends, complaint >0.3%
**Notes:** Email 1 is the dominant driver (1.8% PRR alone). Email 3 underperforms — candidate for next test.

### Series A-C Funding v2

**Signal:** Series A-C funding announced 30-90 days ago (Crunchbase + Intellizence)
**ICP slice:** VC-backed SaaS, all sizes, US
**Sequence:** 3-step email

| Step | Day | Subject line | Purpose |
|------|-----|-------------|---------|
| Email 1 | Day 0 | runway math | Hiring strategy for post-raise |
| Email 2 | Day 3 | scale risk | Common scaling failure pattern |
| Email 3 | Day 7 | timing check | Hail mary |

**Current metrics (last 30 days):**
- Sends: 3,890
- Reply rate: 2.1%
- PRR: 0.6%
- Meetings booked: 2
- Bounce rate: 1.8%

**Health:** Amber
**Stop conditions:** bounce >4%, PRR <0.4% after 1,500 sends
**Notes:** PRR declining 4 weeks straight (was 1.8% in April). Signal may be saturating. Candidate for offer reframe — currently leading with "hiring strategy" but maybe should lead with "scale-without-headcount" angle. Test T-006 planned for next week.

### Champion Job Change

**Signal:** Past candidate landed at new company (detected via LoneScale + Champify)
**ICP slice:** Wherever the champion landed (varies)
**Sequence:** 2-step email

| Step | Day | Subject line | Purpose |
|------|-----|-------------|---------|
| Email 1 | Day 0 | familiar role | Reference past relationship + congrats |
| Email 2 | Day 5 | quick check | Soft follow-up |

**Current metrics (last 30 days):**
- Sends: 142 (low volume — only 5-8 champions land per month)
- Reply rate: 18.3%
- PRR: 11.2%
- Meetings booked: 3
- Bounce rate: 0.7%

**Health:** Green (low volume, high quality)
**Stop conditions:** none — too low volume to risk pause
**Notes:** Best PRR in portfolio. Scale is the constraint, not performance. Worth exploring how to expand the champion pool.

---

## Infrastructure

| Resource | Detail | Status |
|----------|--------|--------|
| Sending domains | recruitcha.co, getrecruitcha.com, recruitchahq.com, withrecruitcha.com | Active |
| Mailboxes | 12 total (3 per domain on 4 domains) | All warmed |
| Warmup status | All green, 10-15/day per mailbox sustained | — |
| Instantly workspace | ws_recruitcha_8a2f | Connected |
| LinkedIn accounts | None — email-only client | N/A |
| Custom tracking domain | track.recruitcha.co (CNAME verified) | Working |

---

## Paused / Completed Campaigns

| Campaign name | Reason | Paused date | Notes |
|--------------|--------|-------------|-------|
| Hiring Signal v3 | Replaced by v4 (won test T-002) | 2026-03-08 | Logged to copy-library graveyard |
| Hiring Signal v2 | Replaced by v3 (won test T-001) | 2026-02-22 | Logged to graveyard |
| Funding v1 | PRR <0.4% after 1,800 sends — root cause: wrong title targeting | 2026-04-10 | Decision logged 2026-04-11 |

---

## Benchmarks for This Client

| Metric | Target | Acceptable | Needs attention |
|--------|--------|-----------|-----------------|
| PRR | 2.0%+ | 1.0-2.0% | Under 1.0% |
| Reply rate | 4.0%+ | 2.0-4.0% | Under 2.0% |
| Bounce rate | Under 1.5% | 1.5-3% | Over 3% |
| Meetings/week | 3+ | 2-3 | Under 2 |

---

## State Notes

- 2026-05-29: Funding campaign PRR declining 4 weeks straight. Test T-006 queued for next week — offer reframe to "scale without headcount" angle.
- 2026-05-22: Pre-launch check passed for Champion Job Change v2 (scope expansion). Not yet launched — waiting on Drew's approval for new champion list.
- 2026-05-15: Hiring v4 Email 1 promoted to canonical Email 1 for similar campaigns. Logged in decision-log.md.