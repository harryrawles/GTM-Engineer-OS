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
| Be Proactive | Deal with errors before the client notices them. We don't want clients pushing us. If you spot a deliverability issue, get in front of it, fix it and report back, or flag it early. |
| Professional Language | Every message represents Instantly as a brand. No poor grammar, no casual tone. Write as if a screenshot of your message could end up anywhere. |
| Play Toward Our North Star | Prioritise MRR. High-value accounts and churn-risk clients come first. If a client is stable and happy, focus your effort where it matters most. Structure your week with this in mind. |
| Don't Over-Extend | Your time is a finite resource. Avoid extra calls outside scope and unnecessary one-off work. Use Loom to solve problems efficiently. Only extend if it plays directly toward our North Star. |
| Don't Over-Communicate | Clients are busy. Update with sincerity and keep it short. Focus on the metrics they care about. Rambling damages trust faster than silence. |

**A note on "North Star":** this table's North Star is MRR, and it answers a different question to the
OS's other north star. `CLAUDE.md` and `wiki/copywriting-101.md` set PRR as the north star for every copy
and campaign decision. The North Star here is for a different decision: how Harry allocates time and
attention across the portfolio. Both stand at once, because they govern different choices, PRR for what to
write, MRR for who gets the time this week.

---

## Situational Guidance

Common situations you will face day-to-day. For cancellations and serious escalations, always follow the
dedicated SOPs.

| Situation | Guidance |
|---|---|
| Client wants to cancel | Do not attempt to handle this independently. Buy time, stay warm, and flag to the CSM same day. Follow the CSM Cancellation Save SOP. |
| Client wants a refund | Do not make any commitments or promises. Escalate immediately. Follow the CSM Escalation Routing SOP (serious escalation). Tag Aaron if the client has any public presence or significant following. |
| Client wants everything completed "yesterday" | Explain that proper testing takes around a week to understand what is working. For scope demands, refer back to the agreement. For urgency: "I totally understand, to make sure this is done properly it will take {{ETA}}. Is it okay if we take a little extra care so we get a really strong result?" |
| Client wants to write their own copy | Push back. 9 times out of 10 it does not work and they blame us. Explain how outbound copy is different from other channels. If they insist and have actual data showing their copy works, use it as a starting point and optimise from there. |

The CSM Cancellation Save SOP and CSM Escalation Routing SOP referenced above are not yet in this repo.
When they're added (drop them in `sops/`), update this table to link to them directly.

---

## Where this fits in the OS

- **Document Your Work** is the principle behind the logging discipline already enforced everywhere:
  `clients/{slug}/comms-log.md` (every client-request-handler.md and reply-handler.md interaction) and
  `clients/{slug}/decision-log.md` (every non-trivial call).
- **Be Consistent / Don't Over-Extend** are the reasoning behind `gtm-skills/client-request-handler.md`
  RULES: "Push back on bad asks" and "Don't promise what you can't deliver."
- **Be Proactive** is the client-facing half of `gtm-skills/deliverability-doctor.md` and
  `gtm-skills/incident-responder.md`, getting in front of an issue and reporting it, rather than waiting for
  the client to spot it first.
- **Professional Language** is the Instantly-brand floor beneath `clients/{slug}/voice.md`. `voice.md` sets
  each client's specific tone; this principle is the baseline every client's voice sits on top of.
- **Play Toward Our North Star (MRR)** is exactly what `gtm-skills/client-health-scorer.md` operationalises:
  Red/Critical clients first, then Amber, per the Monday portfolio pass in `OPERATING-RHYTHM.md`.
- **Refund handling** is the human script for a rule already enforced at the tooling level: `CLAUDE.md`
  Safety Guard item 4 blocks financial operations outright, and `.claude/hooks/safety-guard.sh` blocks
  `create_refund` and related calls in code. `gtm-skills/client-offboarder.md` also never auto-processes
  refunds, it escalates.
- **Cancellation** here is the save attempt, before any decision is final. It is a different moment to
  `gtm-skills/client-offboarder.md`, which runs after the engagement has actually ended. If the save fails
  and the client leaves, offboarding is the next step, not this SOP.
- **Client wants to write their own copy** is the client-facing version of Golden Rule 6 in `CLAUDE.md`
  ("Prefer what already exists") and the never-write-from-memory discipline in `wiki/scientific-method.md`
  and `wiki/copywriting-101.md`. The "testing takes about a week" line for urgency pushback is the same
  7-day latency rule from `wiki/scientific-method.md` Step 1.4, stated for a client instead of for Harry.
