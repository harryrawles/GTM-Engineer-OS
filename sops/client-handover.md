# SOP: Client Handover

Who: GTME, AM.

When: a client needs to be transitioned to a new or covering GTME, whether due to a team departure,
internal reassignment, or planned leave.

Every handover requires a completed Handover Brief before the incoming GTME touches anything. No brief,
no handover. The brief is what protects the client relationship during the transition.

---

## Overview

| Owner | Action | When |
|---|---|---|
| Outgoing GTME | Complete the Handover Brief (using `gtm-skills/handover-brief-writer.md`) | Before handover date |
| Aaron | Review brief and assign incoming GTME | Within 24 hours of brief submission |
| Outgoing GTME | Loom walkthrough for complex accounts | Before last day (permanent departure only) |
| Incoming GTME | Review brief and raise questions | Before taking ownership |
| AM | Send client introduction message (Scenarios 1 and 2) | On or before handover date |
| Incoming GTME | Send follow-up message to client | Within 24 hours of the intro message |

---

## The Handover Brief

Complete this for every client being handed over. Share with the incoming GTME and CC the AM. Generate it
with `gtm-skills/handover-brief-writer.md`, which also produces the Client Introduction Message.

- **Client:** name, plan (SalesOS / PerformanceOS), MRR (written as words, no dollar signs).
- **Transition type:** permanent, reassignment, or cover.
- **Handover date.**
- **Outgoing GTME, incoming GTME, and AM name.**
- **Campaign status:** what is currently running, where it is in the testing cycle, and current
  performance (reply rate, leads generated to date).
- **ICP overview:** who we are targeting, what angles have been tested, what has and has not worked.
- **Client personality and comms style:** how they communicate, how often they expect updates, any
  sensitivities or preferences to be aware of.
- **Open action items:** everything in progress or outstanding, campaigns being built, approvals pending,
  Loom videos due.
- **Key wins to date:** results worth referencing, positive replies, meetings booked, moments the client
  was visibly happy.
- **Watch-outs:** anything the incoming GTME needs to know, ongoing concerns, previous complaints,
  anything sensitive.
- **Upcoming milestones:** review calls, campaign launches, renewal dates.

---

## Scenario 1 - GTME Leaving (Permanent)

Timeline: brief must be completed before the GTME's last day.

1. Outgoing GTME completes the Handover Brief for every active client.
2. Aaron reviews all briefs and assigns incoming GTMEs.
3. Outgoing GTME does a Loom walkthrough with the incoming GTME for any complex accounts.
4. Incoming GTME reviews the brief and raises any questions before taking over.
5. AM sends the client introduction message (see Client Communication below).
6. Incoming GTME takes full ownership, transition complete.

---

## Scenario 2 - Client Reassigned Internally

Trigger: client moved due to capacity, performance, or strategic reasons.

1. Aaron initiates the reassignment and notifies both GTMEs.
2. Outgoing GTME completes the Handover Brief within 24 hours.
3. Incoming GTME reviews the brief and asks any clarifying questions.
4. AM sends the client introduction message (see Client Communication below).
5. Incoming GTME takes ownership from the agreed date.

---

## Scenario 3 - GTME on Leave (Temporary Cover)

Trigger: GTME is out for planned or unplanned leave.

1. GTME completes the Handover Brief before going out, or AM completes it if the absence is unplanned.
2. Covering GTME reviews the brief. Their job is to hold things steady, not to make big changes.
3. No new strategies, ICP changes, or major copy overhauls without checking with AM first.
4. All updates are logged so the returning GTME can pick up cleanly.
5. No client introduction needed unless the absence is 2 weeks or longer.
6. If the absence is 2 weeks or longer, use the Scenario 3 client communication template below.

---

## Client Communication - Scenario 1 - Permanent Departure

AM message:

"Hi [Name], just a quick update from our end. [Outgoing GTME] is moving on from the team, and [Incoming
GTME] will be taking over your account from [date]. [Incoming GTME] has been fully briefed on your
campaigns and everything built so far, there will be no disruption to your service. They will be in touch
shortly."

Incoming GTME follow-up:

"Hey [Client Name], [Incoming GTME] here. I've had a full handover and I'm across everything. I'll keep
things moving and will be in touch with updates shortly. Looking forward to working with you."

---

## Client Communication - Scenario 2 - Internal Reassignment

AM message:

"Hi [Client Name] and team. I trust you are well. I wanted to make an official introduction to [Incoming
GTME], a top-performing GTME here on the VIP team. [Incoming GTME] will be taking over as your primary
point of contact going forward.

The reason we are making this change is simple: we want to give you the best possible experience and
output from your relationship with us. [Incoming GTME] is uniquely positioned to do that and is one of
our most experienced team members, capable of giving your campaigns the strategic direction and flawless
execution an ICP and initiative like yours requires.

You need the best of the best, and that is exactly what you are getting. That said, the entire team
remains at your disposal.

[Incoming GTME] will reach out shortly, but has already been fully briefed and you can be sure there will
be no disruption to the service."

Incoming GTME follow-up:

"Hey [Client Name], [Incoming GTME] here. I've had a full handover and I'm across everything. I'll keep
things moving and will be in touch with updates shortly. Looking forward to working with you."

---

## Client Communication - Scenario 3 - Temporary Cover (2 weeks or longer only)

If planned, the assigned GTME sends the message:

"Hi [Client Name] and team. Just a quick heads up, I'm taking some time away and [Incoming GTME] will be
covering your account from [date] to [date]. [Incoming GTME] has been fully briefed and everything will
keep moving without interruption. You are in good hands."

If unplanned, the AM sends the message:

"Hi [Client Name] and team. Just a quick heads up, [Outgoing GTME] is taking some time away and [Incoming
GTME] will be covering your account from [date] to [date]. [Incoming GTME] has been fully briefed and
everything will keep moving without interruption. You are in good hands."

---

## Where this fits in the OS

- **This is a different event to onboarding or offboarding.** `gtm-skills/client-onboarder.md` runs when a
  new client joins; `gtm-skills/client-offboarder.md` runs when an engagement ends. This SOP runs when an
  existing, ongoing client moves from one GTME to another, the client relationship continues without
  interruption.
- **Aaron is the same escalation contact named in `sops/gtme-escalation-to-am.md` and
  `sops/client-communication-principles.md`** for legal/public-presence/refund situations. Here his role is
  reviewing briefs and assigning incoming GTMEs, a staffing decision rather than a client-facing escalation,
  but the same person.
- **The Handover Brief and the Client Introduction Message are both generated by
  `gtm-skills/handover-brief-writer.md`.** Both are presented as drafts, never auto-sent, consistent with
  every other client-facing output in this OS (`gtm-skills/client-report-writer.md`,
  `gtm-skills/client-offboarder.md`).
- **Scenario 3's "no new strategies without checking AM first"** is a tighter version of the caution
  already in `wiki/_active-test-rules.md` and `gtm-skills/campaign-optimiser.md`'s "one variable at a time"
  rule, a covering GTME should be even more conservative than a permanent owner would be.
