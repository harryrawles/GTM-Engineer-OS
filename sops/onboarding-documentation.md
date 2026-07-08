# SOP: Onboarding Documentation

Owner: GTME.

This is the Standard Onboarding flow. It applies to all clients who have not purchased the 24-Hour
Onboarding upgrade. For clients on the 24-Hour Onboarding, see `sops/onboarding-24-hour.md`, the
`#vip-onboarding-message` channel says which flow applies to a given client.

This SOP is the client-facing message cadence and call checklists for the first two weeks of an
engagement. It runs alongside `gtm-skills/client-onboarder.md`, which is the internal data-capture flow
(see "Where this fits" below).

---

## Phase 1 - Client Assignment

On Day 1 of being assigned to a client, message into the client's channel:

"Hi [name], thanks for signing up to partner with the Instantly VIP service.

Here is what we will be doing over the next 2 weeks to launch:

Week 1: onboarding call, post-call breakdown, campaign strategy breakdown, campaigns setup, lead lists
setup, AI SDR setup.

Week 2: confirmed campaigns, confirmed lead lists, campaign scheduled to go live. The launch is 14 days
once your mailboxes have been sent into warmup.

I will keep you updated inside this channel on the progress of your campaigns and lead lists. Any
questions you have, please ask here or on our onboarding call.

A couple of additional details for your reference: what email warmup is and why it's important, and what
the AI reply agent is and how it works."

---

## Phase 2 - GTME Pre-Call Checklist

Complete before the call, regardless of when it's scheduled:
- Read all auto-generated docs.
- Review the sales call.
- Analyse the company for strategic plays and ideas.
- Configure the AI SDR and reply agent.

---

## Phase 3 - GTME In-Call Checklist

- Has this client run outbound before, or had previous success with offers in other channels?
- Does this client understand offer creation?
- Is this client clear on timelines and when we will go to launch?
- Walk the client through the AI reply agent setup and integration.
- Walk the client through any CRM integrations.

---

## Phase 4 - GTME Post-Call Message

"Hi [name], thanks for the call.

Now I will be setting up the following: 2 campaigns with 3 different offer tests, and 2 ICPs (this may
change if something else was discussed on the call).

These will be presented into this channel with a Loom video explaining the approach, for full clarity.
In the meantime, I will update you on my progress as I go so you stay in the loop.

What I need from you: confirm the mailbox and domain order (skip this if already done), confirm you have
your AI reply agent set up in a separate Slack channel, and feel free to discuss with the Account Manager
for any guidance here. When updated, please give me prompt feedback or approval on lead lists and
data-building.

Your go-live date is [date]. If mailboxes/domains aren't confirmed yet: your go-live date will be
confirmed once mailboxes and domains have been purchased."

---

## Phase 5 - GTME Campaign/Lead List Interim Update

Send at least 1 day after the call:

"Update: campaign and lead list building is underway, stay tuned for updates."

---

## Phase 6 - GTME Campaign/Lead List Submission

"Hi [name], please see the following:

Campaigns for approval: Campaign 1, name (link). Campaign 2, name (link).

ICPs for approval: ICP, name (link). ICP, name (link).

I've recorded a short explainer video running you through the approach we are taking (link).

Let me know if you are happy to schedule these campaigns for [date], or if you would like any revisions."

### If revisions are requested

"Hi [name], please see the following revisions:

Campaigns for approval: Campaign 1 (revised), name (link). Campaign 2 (revised), name (link).

ICPs for approval: ICP (revised), name (link). ICP (revised), name (link).

Here is what I have changed: [short, to the point explainer].

Please confirm if you are happy to run this."

---

## Phase 7 - Ready to Launch (3 days before)

"Hi [name], we are ready to launch.

On [launch date] your campaigns will be going live. We will leave these to run for 1 week to gather data
and find out what is working and what is not, our goal is to test different angles and copy.

To align on expectations: this can sometimes hit early, or it can take a series of tests to find the
winning recipe."

---

## Where this fits in the OS

- **This is a different track to `gtm-skills/client-onboarder.md`.** That skill is the internal
  conversational Q&A that fills `clients/{slug}/overview.md`, `icp.md`, `offer.md`, `voice.md`, and
  `campaign-state.md`, Harry answering questions about the client. This SOP is the client-facing message
  cadence and call checklists that run over the same two weeks, alongside it, not instead of it.
  `sops/daily-structure.md`'s Onboarding block covers the internal work; this SOP covers what the client
  actually sees and hears.
- **Phases 2 and 3 are the concrete version of `sops/churn-prevention.md`'s "Prevention Starts at
  Onboarding".** Setting clear timeline expectations and walking the client through the AI reply agent are
  named there as churn prevention; this SOP is exactly how and when that happens.
- **Mailbox/domain provisioning stays AM's.** Phase 4's "confirm the mailbox and domain order" is Harry
  asking the client to confirm, not Harry provisioning anything himself, and it explicitly routes AM
  questions to the AM, consistent with `sops/am-gtme-responsibility-split.md`.
- **Phase 7's launch handoff is where `gtm-skills/campaign-launcher.md` and `gtm-skills/pre-launch-
  check.md` take over.** This SOP is the client communication around the launch date, not the launch
  mechanics themselves.
- **"AI reply agent" and "AI SDR" are two distinct systems, not two names for one thing**, per
  `sops/onboarding-24-hour.md`'s Step 1/Step 2 split. The Phase 1 client message says "AI SDR setup"
  directly now (it used to say "AI inbox management setup," which read like the reply agent's job and
  wasn't). "AI SDR configuration" in `sops/daily-structure.md` refers to the same system.
- **For clients on the 24-Hour Onboarding upgrade, this SOP doesn't apply, use
  `sops/onboarding-24-hour.md` instead.** The `#vip-onboarding-message` channel says which one applies.
