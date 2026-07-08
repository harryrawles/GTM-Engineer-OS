---
name: Optimization test
about: Track an active split test through to conclusion
title: '[TEST] '
labels: optimization-test
assignees: harryrawles
---

## Test setup

**Client:** {{CLIENT_NAME}}
**Test ID:** {{T-001 / sequential}}
**Variable tested:** {{e.g. Email 1 offer framing}}
**Hypothesis:** {{What you expect and why}}

## Configuration

| Field | Control | Variant |
|-------|---------|---------|
| Description | | |
| Sample target | 300 sends | 300 sends |
| Launch date | | |
| Expected completion | | |

## Constants (held fixed)

- ICP
- Sending domains
- Send volume per day
- Sequence step
- Other: {{list}}

## Tracking

- [ ] Logged to `clients/{slug}/test-log.md` as "Running"
- [ ] Latency window noted (+1 week post final send)
- [ ] Daily metric tracking spreadsheet started

## Results (fill at completion)

| Metric | Control | Variant |
|--------|---------|---------|
| Sends | | |
| PRR | | |
| Meetings | | |

**Winner:** Control / Variant / Inconclusive
**Conclusion:** {{What was learned}}
**Next test:** {{Variable to test next}}

## Post-completion

- [ ] Updated `clients/{slug}/test-log.md` to "Completed"
- [ ] Logged decision to `clients/{slug}/decision-log.md`
- [ ] If winner → added to `clients/{slug}/copy-library.md`
- [ ] If loser → added to graveyard
- [ ] Next test queued