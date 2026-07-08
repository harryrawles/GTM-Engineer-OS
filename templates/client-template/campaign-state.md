# Campaign State - {{CLIENT_NAME}}

Live status of all outbound campaigns. Update this file when campaigns launch, pause, change, or are retired.

**Last updated:** {{DATE}}

---

## Active Campaigns

| Campaign name | Signal | Launch date | Mailboxes | Sends/day | Status | Health |
|--------------|--------|-------------|-----------|-----------|--------|--------|
| {{Name}} | {{Signal type}} | {{Date}} | {{n}} | {{n}} | Active | Green / Amber / Red |

---

## Tools & Tech Stack (W4)

Tracks what tooling is configured for this client. Affects which signals can be detected and which workflows can run.

| Tool | Connected | Notes |
|------|-----------|-------|
| Instantly | {{Yes/No}} | Primary sender |
| Clay | {{Yes/No}} | If used for enrichment |
| RB2B | {{Yes/No}} | Website visitor detection |
| LoneScale / Champify | {{Yes/No}} | Champion job change detection |
| Findymail | {{Yes/No}} | Email verification |
| Apollo | {{Yes/No}} | Lead database |
| HeyReach | {{Yes/No}} | LinkedIn (if multichannel) |
| Slack | {{Yes/No}} | Reply alerts |
| Notion | {{Yes/No}} | Client comms / context |

---

## Campaign Detail

### {{Campaign Name 1}}

**Signal:** {{What trigger this campaign targets}}
**ICP slice:** {{Which subset of ICP this campaign targets}}
**Sequence:** {{n}}-step email

| Step | Day | Subject line | Purpose |
|------|-----|-------------|---------|
| Email 1 | Day 0 | {{Subject}} | Main pitch |
| Email 2 | Day 3 | {{Subject}} | Follow-up, different angle |
| Email 3 | Day 7 | {{Subject}} | Final touch |

**Current metrics (last 30 days):**
- Sends: {{n}}
- Reply rate: {{%}}
- PRR: {{%}}
- Meetings booked: {{n}}
- Bounce rate: {{%}}

**Health:** Green / Amber / Red
**Notes:** {{Any issues, things to watch, or context}}

---

## Infrastructure

| Resource | Detail | Status |
|----------|--------|--------|
| Sending domains | {{List domains}} | Active / Warming |
| Mailboxes | {{n}} mailboxes across {{n}} domains | Active |
| Warmup status | {{All warmed / some warming}} | - |
| Instantly workspace | {{Workspace name / URL}} | Connected |
| LinkedIn accounts | {{n accounts}} | {{Status}} |

---

## Paused / Completed Campaigns

| Campaign name | Reason | Paused date | Notes |
|--------------|--------|-------------|-------|
| {{Name}} | {{Why paused}} | {{Date}} | {{What to do if reactivating}} |

---

## Benchmarks for This Client

| Metric | Great or better | Good | Below standard or worse |
|--------|--------|-----------|-----------------|
| PRR | 0.5%+ | 0.2-0.5% | Under 0.2% |
| Bounce rate | Under 2% | 2-5% | Over 5% |
| LinkedIn acceptance | 35%+ | 20-35% | Under 20% |

PRR bands per `sops/campaign-performance-standards.md`. Bounce bands per `wiki/deliverability.md`. Raw
reply rate is not tracked as a separate benchmark - PRR is the only reply-based metric judged against a
target, see `sops/campaign-performance-standards.md` for why.

---

## State Notes

{{Anything about the current state that does not fit the tables above - deliverability concerns, list quality issues, signals performing differently than expected, etc.}}