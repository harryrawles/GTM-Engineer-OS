# SOP: GTME Escalation to AM

Who: GTMEs.

When: you hit a situation outside of delivery, technical, billing, scope, or relationship issues that
require AM involvement.

Your lane is campaigns, lead lists, and day-to-day client management. When a situation moves outside
that, billing, technical infrastructure, scope disputes, or a client who needs a more senior voice, bring
in the AM. Do not sit on it. Do not try to handle it yourself.

---

## What Triggers an AM Escalation

Escalate to AM when:

- Technical issue: workspace errors, throttling, mailbox or domain problems, platform bugs.
- Billing or contract: client questions about their invoice, pricing, what is in scope, or renewal terms.
- Scope dispute: client pushing for deliverables outside what was agreed (extra campaigns, additional
  ICPs, more calls than contracted).
- Client needs a senior voice: client losing confidence, asking to speak to management, or needing
  reassurance you cannot credibly give. This is not exclusive to AM, flag the CSM in parallel per
  `sops/tough-client-involve-csm.md`. AM and CSM work their own lane on the same situation, AM has the
  commercial lever (contract, pricing, concessions), CSM has the relationship lever.
- Cancellation or refund signal: do not handle this alone. Flag the CSM the same day per
  `sops/client-communication-principles.md`, and loop AM immediately for the billing/contract side.
- Anything you are unsure is yours: if you are not sure whether it is your problem or the AM's, flag it.
  The cost of flagging unnecessarily is zero. The cost of not flagging and getting it wrong is high.

---

## How to Escalate

Post in #am-vip-handling-updates using this format:

```
VIP Client | [email] | [client name] | VIP MRR $[X]

Hi @[AM name]

Issue: [what is happening, be specific]

Context: [how long they have been a client, any relevant history]

What I've done: [what you have already tried or said to the client]

What I need: [specific ask, direction / AM to contact client / billing fix / etc.]
```

Be specific. "Client is unhappy" is not useful. "Client is questioning why they were billed $4k when
their contract says $2k" is.

---

## Who to Tag

- Standard AM issue: tag @Talha or @George, whoever owns the account on the AM side.
- No assigned AM or unsure: tag @Talha or @George.
- Client MRR $2k+ or situation is serious: tag @Ammad + @Kyra.
- Legal threat, public defamation, or refund demand: tag Aaron, per the existing rule in
  `sops/client-communication-principles.md` for public-presence situations. Do not respond to the client
  until you have direction.

---

## What Happens Next

- AM will acknowledge within the same business day.
- Do not contact the client about the issue until you have direction from AM.
- If the client asks in the meantime: "I'm getting that looked into for you right now, I'll have an
  update shortly."
- Stay across the thread and action anything AM needs from you quickly.

---

## Where this fits in the OS

- **This is the concrete "how" behind every "flag / bring in the AM" instruction in
  `sops/am-gtme-responsibility-split.md`.** That document establishes who owns what; this SOP is the
  channel, message format, and tagging mechanics for actually doing it.
- **Refund and public-presence tagging stays exactly as `sops/client-communication-principles.md` and
  `gtm-skills/client-request-handler.md` Type J already state it: tag Aaron.** This SOP's channel and
  message format apply on top of that, the "who" for that specific situation doesn't change.
- **Cancellation still flags CSM first**, per `sops/client-communication-principles.md` and
  `sops/tough-client-involve-csm.md`. This SOP adds the AM side: billing and contract mechanics run in
  parallel to, not instead of, the CSM save attempt.
- **"Client needs a senior voice" is a dual-flag, not a fork.** AM and CSM
  (`sops/tough-client-involve-csm.md`) both get flagged when a client is losing confidence. Each works
  their own lane, AM the commercial lever, CSM the relationship lever.
- **CSM's own SOPs (cancellation-save, escalation routing) live outside this repo entirely**, per
  `sops/am-gtme-responsibility-split.md`. This SOP names when to loop AM alongside CSM, not CSM's own
  process.
