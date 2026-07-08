# SOP: Client Communication Principles

When: reference document. The baseline standard for all client communication across the portfolio.

Client comms is 50% results and 50% psychology. A water bottle in a store is less valuable than the same
bottle in an airport. Same product, different environment. Clients are the same.

---

## Communication Principles

These are not situational guidelines. They are the default standard for every client interaction, every
day.

| Principle | What it means |
|---|---|
| Document Your Work | Clients want to feel looked after at all times. Show your working, they often don't understand how much goes into building pipeline. Update them as you go. They will value it. |
| Be Consistent | Over-deliver within reason. If you make an exception once, the client will expect it forever. 5% of clients take 95% of your time, minimise this by sticking to scope. |
| Be Proactive | Deal with errors before the client notices them. We don't want clients pushing us. If you spot a deliverability issue, get in front of it, fix it and report back, or flag it early. When results are underperforming specifically, follow `sops/client-not-getting-results.md` in full. |
| Professional Language | Every message represents Instantly as a brand. No poor grammar, no casual tone. Write as if a screenshot of your message could end up anywhere. |
| Prioritise by Account Value | Weight your time by account value (tier/MRR, as the AM or your manager communicates it, not pulled from billing yourself, billing is AM-owned). High-value accounts and churn-risk clients come first. If a client is stable and happy, focus your effort where it matters most. Structure your week with this in mind. |
| Don't Over-Extend | Your time is a finite resource. Avoid extra calls outside scope and unnecessary one-off work. Use Loom to solve problems efficiently. Only extend if it plays directly toward a high-value or churn-risk account. If a client is consuming disproportionate time regardless of tier, that's `sops/tough-client-involve-csm.md`, not just a time-budgeting call. |
| Don't Over-Communicate | Clients are busy. Update with sincerity and keep it short. Focus on the metrics they care about. Rambling damages trust faster than silence. |

PRR is the north star metric for the OS, always, for every copy and campaign decision (`CLAUDE.md`,
`wiki/copywriting-101.md`). MRR-weighted prioritisation above is about a separate thing, how the GTME spends
time across the portfolio, and is not a competing north star.

---

## Situational Guidance

Common situations you will face day-to-day. Cancellations and refunds are handled by the CSM function, a
separate system outside this OS, do not try to resolve them yourself.

| Situation | Guidance |
|---|---|
| Client wants to cancel | Do not attempt to handle this independently. Buy time, stay warm, and flag to the CSM same day. If a discount comes up, per `sops/churn-prevention.md` the floor is 20% off next month's VIP MRR, minimum $1k MRR, and Ammad must sign off before anything is offered. Never offer one yourself. |
| Client is becoming difficult, disengaged, or consuming disproportionate time, before it's a cancellation | Follow `sops/tough-client-involve-csm.md`. Flag the CSM early, don't wait for it to escalate into the row above. |
| Client wants a refund | Do not make any commitments or promises. Escalate immediately to the AM (billing is AM-owned, per `sops/am-gtme-responsibility-split.md`), using the channel and format in `sops/gtme-escalation-to-am.md`. Tag Aaron if the client has any public presence or significant following. |
| Client wants everything completed "yesterday" | Explain that proper testing takes around a week to understand what is working. For scope demands, refer back to the agreement. For urgency: "I totally understand, to make sure this is done properly it will take {{ETA}}. Is it okay if we take a little extra care so we get a really strong result?" |
| Client wants to write their own copy | Push back. 9 times out of 10 it does not work and they blame us. Explain how outbound copy is different from other channels. If they insist and have actual data showing their copy works, use it as a starting point and optimise from there. |

---

## Where this fits in the OS

- **Document Your Work** is the principle behind the logging discipline already enforced everywhere:
  `clients/{slug}/comms-log.md` (every client-request-handler.md and reply-handler.md interaction) and
  `clients/{slug}/decision-log.md` (every non-trivial call).
- **Be Consistent / Don't Over-Extend** are the reasoning behind `gtm-skills/client-request-handler.md`
  RULES: "Push back on bad asks" and "Don't promise what you can't deliver."
- **Be Proactive** is the client-facing half of `gtm-skills/deliverability-doctor.md` and
  `gtm-skills/incident-responder.md`, getting in front of an issue and reporting it, rather than waiting for
  the client to spot it first. When the issue is results underperforming specifically,
  `sops/client-not-getting-results.md` is the full procedure this principle points to.
- **Professional Language** is the Instantly-brand floor beneath `clients/{slug}/voice.md`. `voice.md` sets
  each client's specific tone; this principle is the baseline every client's voice sits on top of.
- **Prioritise by Account Value** is exactly what `gtm-skills/client-health-scorer.md` operationalises:
  Red/Critical clients first, then Amber, per the Monday portfolio pass in `OPERATING-RHYTHM.md`.
- **Refund handling** is the human script for a rule already enforced at the tooling level: `CLAUDE.md`
  Safety Guard item 4 blocks financial operations outright, and `.claude/hooks/safety-guard.sh` blocks
  `create_refund` and related calls in code. `gtm-skills/client-offboarder.md` also never auto-processes
  refunds, it escalates, specifically to the AM, per `sops/am-gtme-responsibility-split.md`.
- **Cancellation** here is the save attempt, before any decision is final. It is a different moment to
  `gtm-skills/client-offboarder.md`, which runs after the engagement has actually ended. If the save fails
  and the client leaves, offboarding is the next step, not this SOP.
- **Client wants to write their own copy** is the client-facing version of Golden Rule 6 in `CLAUDE.md`
  ("Prefer what already exists") and the never-write-from-memory discipline in `wiki/scientific-method.md`
  and `wiki/copywriting-101.md`. The "testing takes about a week" line for urgency pushback is the same
  7-day latency rule from `wiki/scientific-method.md` Step 1.4, stated for a client instead of for the GTME.
- **Professional Language** also covers what not to say: `sops/campaign-performance-standards.md`'s
  internal PRR/sends-per-reply tiers never get shared with a client. What they see is their own actual
  performance (`gtm-skills/client-report-writer.md`) and the external "1 per 1,000" framing, not our
  internal floor.
- **The situational row above** is the earlier trigger for the same escalation the "Client wants to
  cancel" row already names. `sops/tough-client-involve-csm.md` is the full procedure: what to flag, and
  what CSM does once flagged.
- **The refund row's AM escalation** now has a concrete channel and message format,
  `sops/gtme-escalation-to-am.md`. The "who" (Aaron, for public-presence situations) is unchanged, that
  SOP just adds the "how."
- **The cancellation row's discount detail** comes from `sops/churn-prevention.md`, which also covers
  onboarding-time prevention and the earlier "at-risk" trigger, before a client ever reaches this row.
