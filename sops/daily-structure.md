# SOP: GTME Daily Structure

When: every working day. This is the default operating structure for how Harry's time gets split within a
single working day.

This is a guide, not a rigid schedule. If there are no onboards on a given day, use that time for campaign
updates instead. The priority order is what matters, not the clock times.

This SOP covers the hours between the two existing daily checkpoints in `OPERATING-RHYTHM.md`: the 10-minute
Morning Check and the 5-minute End of Day Wrap. Those two stay as written; this fills in what happens
between them.

---

## Block 1 - Onboarding

Time: 2-3 hours. Priority: first.

New client onboards always come first. Set up campaigns, lead lists, and AI SDR configurations before
anything else. Run via `gtm-skills/client-onboarder.md`. Mailbox and domain provisioning is a separate,
parallel track owned by the AM, not part of this block (`sops/am-gtme-responsibility-split.md`).

---

## Block 2 - Client Management

Time: 2-3 hours. Priority: second.

Respond to ongoing messages, campaign requests, and copy revisions.

- All client messages must be responded to within 24 hours.
- New campaign updates delivered within 3 days.

---

## Block 3 - Meetings

Time: 2-3 hours. Priority: third.

Block off a window that overlaps at least 3 hours with US business hours. Do not let clients book meetings
in the middle of other blocks, it kills your productivity.

---

## Friday Rule

Use Fridays (the quieter day) to batch campaign updates. Depending on urgency, updates can be pushed to
Friday so clients receive everything by end of week or Monday, still within the 5-7 day expectation window.
Internally the target is 4 days.

---

## Where this fits in the OS

- **`OPERATING-RHYTHM.md`** defines the daily checkpoints (Morning Check, End of Day Wrap) and the weekly
  theme per day (e.g. "Wed: net new copy / new client onboarding"). This SOP is the tactical priority order
  *within* any given day: onboarding jumps the queue whenever one is pending, regardless of which day's
  theme it lands on.
- **`clients/{slug}/overview.md`** SLA & Commitments section holds the per-client response-time commitment
  (default `{{e.g. Within 24 hours weekdays}}`). The 24-hour acknowledgement and 3-day campaign-update
  figures here are the OS-wide default that field should match unless a specific client's contract says
  otherwise.
- **`gtm-skills/client-request-handler.md`** STEP 3 enforces the acknowledgement SLA on every inbound
  request; this SOP is where that 24-hour default comes from.
- **`gtm-skills/client-onboarder.md`** is Block 1 in practice - the skill that runs during the onboarding
  block.
