# SOP: 24-Hour Onboarding

Owner: GTME.

This flow is for clients who have purchased the 24-Hour Onboarding upgrade. The Calendly booking is the
trigger, the moment the client books, the clock starts and the GTME is assigned. The AI SDR goes live
immediately with pre-warms. Everything after that is the learning phase. For clients who have not
purchased this upgrade, use `sops/onboarding-documentation.md` instead.

---

## How This Works

The 24-hour onboarding is built around the AI SDR, not campaigns. The goal is to get the AI SDR live and
learning as fast as possible, campaigns come in to support and accelerate that learning phase, not to
replace it. Once the AI SDR is performing well, we scale it up and campaigns become secondary.

The flow in plain terms:
1. Client books via Calendly, GTME assigned immediately.
2. AI SDR turns on with pre-warms, client is live within hours.
3. Onboarding call, align on ICP, offer, and learning phase strategy.
4. Campaigns built, feed the learning phase and supplement AI SDR output.
5. AI SDR learns, improves, scales, campaigns step back.

---

## Step 1 - Calendly Booking (Trigger)

The moment the client books the onboarding call, the GTME is assigned. Do not wait for the call, start
immediately.

First, check the onboarding message. Open #vip-onboarding-message for this client and confirm:
- 24-Hour Onboarding: Yes. If it says No, use `sops/onboarding-documentation.md` instead.
- Check the order form, has the client purchased pre-warms?

If the client has already purchased pre-warms: take them live immediately, don't wait for the onboarding
call. The AI SDR goes on now. Note this in the channel and let the AM know.

If pre-warms haven't been purchased yet: turn on the AI SDR with pre-warms as part of this step and
proceed as normal.

GTME completes before the call:
- All auto-generated docs reviewed.
- Sales call recording reviewed.
- Company analysed, ICP, offer angles, buying signals.
- AI SDR turned on with pre-warms, this is the early go-live.

Message to the client:

"Hi [name], I've been assigned to your account and we've already started.

Your AI SDR is set up and ready to start sending right now. It's pulling from your ICP list so we can
begin testing your offer immediately, no waiting around.

This is our initial offer test. We're going live now so we can gather real data early. On our call we'll
go deeper into your ICPs, review what's landing, and make further refinements from there.

Our onboarding call is confirmed for [time]. I've already reviewed your onboarding form and sales call,
I'll come prepared.

See you soon."

---

## Step 2 - Onboarding Call

30 minutes maximum. The AI SDR is already running, this call is about aligning the learning phase
strategy.

On the call, confirm:
- Has this client run outbound before? What's worked?
- Is the offer strong enough to scale? Challenge it if not.
- ICP confirmed and locked, this feeds everything going forward.
- What does success look like in month one? Agree on a specific number.
- Walk through AI Reply Agent setup and integrations (a separate system to the AI SDR, see "Where this
  fits" below).
- Explain the learning phase, the AI SDR is gathering data, campaigns supplement and accelerate this.
- Confirm the client will review campaigns within 2 hours of submission today.

---

## Step 3 - Learning Phase Build

After the call, build campaigns that support and accelerate the AI SDR's learning. These aren't
standalone campaigns, they feed signal back into the system.

- 2 campaigns built around the confirmed ICP and offer.
- 2 lead lists sourced and validated.
- Loom recorded explaining the approach and how it connects to the AI SDR.
- Everything quality checked, zero errors before submission.

---

## Step 4 - Submission

"Hi [name], campaigns are ready.

Campaigns for approval: Campaign 1, [name] ([link]). Campaign 2, [name] ([link]).

ICPs for approval: ICP 1, [name] ([link]). ICP 2, [name] ([link]).

Loom walkthrough: [link].

These campaigns are designed to work alongside your AI SDR, they feed data into the learning phase and
accelerate results. The goal is for the AI SDR to do the heavy lifting as it learns what's working.

Please review and approve within 2 hours. Any changes, drop them here and I'll turn them around fast."

---

## Step 5 - Revisions (if needed)

"Hi [name], revisions done.

What I changed: [one-line summary].

Campaign 1 (revised): [link]. Campaign 2 (revised): [link].

Confirm and we launch."

If the client requests more than one round of revisions, flag to the AM per
`sops/gtme-escalation-to-am.md`.

---

## Step 6 - Launch Confirmed

"Hi [name], campaigns are live and your AI SDR is actively learning.

Here's what happens now: the AI SDR runs and gathers data on what's resonating, campaigns feed results
back into the learning phase, I'll monitor daily and update you on what's working, and as the AI SDR
improves, we scale it up and let it do more of the work.

You'll hear from me with updates as results come in. Message me here any time."

---

## If the Client Goes Dark

If the client doesn't respond to the submission within 2 hours:
1. Send a follow-up in the channel.
2. Notify the AM (`sops/gtme-escalation-to-am.md`).
3. The AI SDR stays live, pre-warms and learning continue regardless.
4. Document the delay, if it's on the client's side, that's on record.

---

## Where this fits in the OS

- **The Standard and 24-Hour flows are alternates, not a sequence.** Step 1's first checklist item is the
  routing decision, `#vip-onboarding-message` says which one applies. `sops/onboarding-documentation.md`
  now points back here instead of treating this as pending.
- **"AI SDR" and "AI Reply Agent" are two distinct systems, not two names for one thing.** This SOP lists
  them as separate checklist items (AI SDR go-live in Step 1, AI Reply Agent setup in Step 2). This
  resolves the terminology note left in `sops/onboarding-documentation.md`, AI SDR is the autonomous
  sending/prospecting agent, AI Reply Agent handles inbound replies. "AI SDR configuration" in
  `sops/daily-structure.md` refers to the same AI SDR named here.
- **"Turning on the AI SDR with pre-warms" is not mailbox/domain provisioning.** It's activating an
  existing pre-warm pile that the AM maintains (`sops/solving-campaign-issues.md`'s "tap into the pre-warm
  pile" fix), a GTME software action within the sending tool, not GTME provisioning new infrastructure.
  Provisioning new mailbox or domain capacity stays AM's, per `wiki/deliverability.md`'s "When to Flag the
  AM".
- **AM escalation (multiple revision rounds, client going dark) uses the channel and format in
  `sops/gtme-escalation-to-am.md`**, same as every other AM flag in this OS.
