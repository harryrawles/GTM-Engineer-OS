# Sample Weekly Review Output

Example of what `gtm-skills/weekly-reviewer.md` produces during a single-client deep review. Use as the quality bar for real reviews.

---

## Input

```
Harry: Run weekly review for {{CLIENT_NAME}}
```

## Output

```
=== Weekly Review - {{CLIENT_NAME}} - 2026-05-29 ===

Pulling Instantly data... done.

[Step 2 - Signal trends]

Signal              | 7-day PRR | Prior week | Trend  | Status
------------------- | --------- | ---------- | ------ | ------
Hiring intent       | 2.3%      | 2.1%       | ↑ 10%  | Healthy
Funding (Series A)  | 0.6%      | 1.8%       | ↓ 67%  | DECLINING - flag
Tech change         | 1.2%      | 1.1%       | ↔      | Stable
Champion job change | 11.2%     | 10.4%      | ↑ 8%   | Healthy (low vol)

⚠ Funding signal declining sharply 4 weeks in a row. Recommend test T-006 (queued): reframe offer to "scale without headcount." Will action after winners logged.

[Step 3 - Winner candidates]

WINNER CANDIDATE - Hiring Signal v4 / Email 1
- Sends: 1,847 (this week) + 4,012 (prior 3 weeks) = 5,859 lifetime
- 7-day PRR: 2.4%
- Lifetime PRR: 2.3%
- Reply rate: 5.1%
- Meetings (7-day): 4
- Signal: 3+ engineering job postings, last 30 days
- Target ICP: Head of / VP Engineering at Series A-C SaaS

Copy:
Subject: hiring speed
Saw the senior eng hires coming in. Most VPs of Eng at this stage are losing 10-15 hrs/week interviewing low-signal candidates from outsourcing firms. We only source from VC-backed product companies - {{NAMED_PROOF_COMPANY}}'s VP closed 4 hires this way, saved $100k vs in-house. Want a sample shortlist?

Log this as a winner? [Harry: Yes]

Why do you think this worked? [Harry: "Saw the senior eng hires coming in" is generic enough to feel personalised without naming the specific roles. Part 2 with the specific 10-15 hr number resonates because it's their daily pain. Closing with "Want a sample shortlist" beats "want a 15-min call" - 0 commitment.]

What is the most stealable element? [Harry: The "sample shortlist" CTA pattern. Lower friction than time ask. Going to test it on Funding campaign Email 1 too.]

Anything you would NOT carry over to another client? [Harry: The $100k {{NAMED_PROOF_COMPANY}} figure. Other clients need their own dollar story.]

Writing to clients/{slug}/copy-library.md... done.
Writing to clients/{slug}/decision-log.md... done.

[Step 4 - Loser candidates]

LOSER CANDIDATE - Funding v2 / Email 1
- Sends: 1,420 this week + 2,470 lifetime = 3,890
- 7-day PRR: 0.5% (was 1.8% in April)
- Reply rate: 2.1%
- Meetings (7-day): 0

Copy:
Subject: runway math
Saw you raised your Series B in March. Most VPs of Eng I talk to at this stage are mapping out a 30-50% headcount increase over 12 months - but the math gets ugly fast. We helped {{NAMED_PROOF_COMPANY_2}} close 4 senior eng roles in 14 days, saved $80k vs in-house. Worth a quick chat?

Log to graveyard? [Harry: Yes - confirmed it's underperforming.]

Root cause? [Harry: Offer is generic for post-funding - "hiring strategy" is what every recruiter pitches. We need a different angle. T-006 will test "scale without headcount."]

Writing to graveyard... done.

[Step 5 - Test status]

T-005 (Email 2 subject: "one role" vs "open role"): Running. Currently 187/300 sends per variant. Latency window starts in 5 days. Will complete next week.

T-006 (Funding Email 1 offer reframe): Queued. Will launch via test-launcher.

[Step 6 - Campaign health update]

| Campaign | Sends 7d | PRR 7d | Meetings 7d | Health | Change |
|----------|---------|--------|-------------|--------|--------|
| Hiring v4 | 1,847 | 2.4% | 4 | Green | ↔ |
| Funding v2 | 1,420 | 0.5% | 0 | Amber→Red | ↓ |
| Champion JC | 38 | 11.2% | 1 | Green | ↔ |

Funding v2 moved to Red status. Stop conditions: PRR <0.4% triggers pause. Currently at 0.5% so still active but on edge. Test T-006 needs to launch this week.

[Step 7 - Client report ready]

=== Weekly Review Complete: {{CLIENT_NAME}} ===

Winners logged: 1 (Hiring v4 Email 1)
Losers logged: 1 (Funding v2 Email 1)
Tests completed: 0
Tests queued for launch: 1 (T-006)
Campaign health: 2 green, 0 amber, 1 red
Signal alerts: 1 (Funding declining)

Ready to generate weekly client report. Run client-report-writer? [Y/N]

Harry: Y
```