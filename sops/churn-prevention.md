# SOP: Churn Prevention

Who: GTME, AM, CSM.

When: any time a churn signal is detected, dropping engagement, unhappy tone, missed responses, or a
cancellation request.

Clients churn for two main reasons: not enough leads, or enough leads but they've decided to move on
anyway. Either way, catching it early makes all the difference.

---

## Prevention Starts at Onboarding

The best churn prevention happens before a client is ever at risk:

- Walk the client through the Welcome Guide on the onboarding call, set realistic expectations on
  timeline, iteration, and what success looks like.
- Push the client to have as many mailboxes as possible in warmup. This is the onboarding-time version of
  the same mailbox-capacity conversation in `sops/solving-campaign-issues.md`'s deliverability section,
  earlier and cheaper than having it after a deliverability problem has already hit.
- Make sure the client understands the AI Reply Agent setup and the full tool stack.

A client who understands the process is far less likely to panic when week 1 does not deliver instant
results.

`sops/onboarding-documentation.md` is exactly how and when this happens, its Phase 2/3 checklists and
message scripts are the concrete instantiation of this section.

---

## Early Signal, At-Risk Intervention

If you spot any churn signal, dropping reply rate, negative tone, missed responses, or you've already had
to flag a difficult client yourself, act immediately. Do not wait for the client to raise cancellation, by
then it is a much harder conversation.

Follow `sops/tough-client-involve-csm.md`. That SOP is exactly this trigger set, flag the CSM early, before
it becomes a cancellation conversation.

---

## Cancellation Request, Cancellation Save

If a client explicitly raises cancellation or signals they want to leave, do not attempt to handle this
independently. Buy time, stay warm, and flag to the CSM the same day, per
`sops/client-communication-principles.md`'s "Client wants to cancel" guidance.

If a discount is part of the save, know the boundary even though the save conversation itself is CSM's:
the discount floor is 20% off next month's VIP MRR, minimum $1k MRR, and Ammad must sign off before
anything is offered. Never offer a discount yourself, this is a financial commitment
(`CLAUDE.md` Safety Guard item 4) and Ammad's sign-off is required regardless of who is running the save
conversation.

---

## Where this fits in the OS

- **"Early Signal, At-Risk Intervention" is `sops/tough-client-involve-csm.md`, not a separate procedure.**
  Same trigger set (dropping engagement, negative tone, missed responses), same action (flag CSM early).
  This SOP names the churn-specific framing, that SOP is the actual mechanics.
- **The discount floor is new information, not previously captured anywhere in this OS.** It extends
  `sops/client-communication-principles.md`'s "Client wants a refund" row and `CLAUDE.md` Safety Guard item
  4, no GTME-side financial commitment happens without the AM/Ammad sign-off named there.
- **Onboarding-call expectation-setting is a different moment to `gtm-skills/client-onboarder.md`.** That
  skill is the internal data-capture flow (Harry answering questions about the client). The Welcome Guide
  walkthrough is the live client-facing call, a separate moment that happens alongside it.
- **`gtm-skills/client-health-scorer.md`'s churn-risk scoring is the detection half of this SOP.** This SOP
  is the prevention half, onboarding practices that reduce how often a client reaches Amber/Red in the
  first place.
- **CSM's own process once flagged (cancellation-save, at-risk intervention) lives outside this repo
  entirely**, per `sops/am-gtme-responsibility-split.md`. This SOP documents what to watch for and when to
  flag, not CSM's own runbook.
