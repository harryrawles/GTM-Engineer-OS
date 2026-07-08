# SOP: AM & GTME Responsibility Split

When: any time there is ambiguity about who owns a task or client situation.

There are things the GTME owns and things the AM owns. This document removes the grey area so nothing
falls through the cracks.

---

## GTME Owns

- Campaigns: building, testing, and optimising
- Lead list building
- Day-to-day client management and messaging
- Quarterly/performance review calls with clients (the performance case: results, wins, lessons, next-
  quarter strategy). The renewal terms discussed on that same call are the AM's, not GTME's.

---

## AM Owns

- Technical setup: DFY mailbox creation and configuration
- Workspace issues and email throttling
- Domain-level problems (widespread issues, .co flags, etc.)
- Billing
- Renewal terms, contract negotiation, and pricing, including within a GTME-led performance review call

---

## Stuck, But Still Yours

Not every block is an ownership question. If a campaign is stuck and the work is still GTME's, that's not
an AM or manager handoff, it's `sops/gtme-unlock-ladder.md`: Cowork, then the support channel, then
`#grill-my-campaigns`, before it becomes a call.

---

## Beyond the AM: Manager/Team Lead Owns

Some things aren't the AM's either. Legal threats and GDPR/data-exposure incidents escalate to the GTME's
manager/team lead, not just to the GTME, and not to the client until the manager has weighed in. **Aaron is
that manager/team lead** - every other file in this OS that names "Aaron" for a legal, GDPR, public-
presence, or refund escalation is naming this same role, not a separate contact. See
`gtm-skills/incident-responder.md` Protocols C and E.

---

## Beyond the AM: CSM Owns

The relationship layer, when it's under strain, isn't the AM's either. A client that's pushing back,
losing confidence, or consuming disproportionate time gets flagged to the CSM per
`sops/tough-client-involve-csm.md`. CSM provides air cover on the relationship so GTME stays on delivery.
CSM's own process from there (cancellation-save, escalation routing) lives outside this repo entirely, do
not add or link to CSM-owned SOPs here.

---

## Situational Split

For the mechanics of any "bring in / flag / loop in the AM" instruction below, channel, message format,
and who to tag, see `sops/gtme-escalation-to-am.md`.

**Client needs to set up Supersearch.** GTME leads the communication. If the client gets stuck with
sign-up or has issues, bring in the AM.

**Widespread domain issues.** AM leads. If you spot it first, flag it to the AM immediately, they own the
fix.

**Technical glitch or platform bug.** AM leads. You can flag it and keep an eye, but do not attempt to fix
it yourself.

**Campaign not performing.** GTME leads. Copy issue, that is on you. Technical fault, loop in the AM.

**Client is over-extending or being extremely demanding.** GTME leads using
`sops/client-communication-principles.md`. If the client needs to be reminded of scope, bring in the AM to
reinforce it. If it's the relationship itself under strain, not just a scope ask, flag the CSM per
`sops/tough-client-involve-csm.md` instead, or as well.

---

## Where this fits in the OS

This corrects a default assumption baked into several existing skills, that the GTME personally
executes billing and domain-level technical fixes. They don't; the AM does. GTME's job in those situations
is to detect, scope, notify, and manage the client relationship, then hand off execution.

- **Billing.** `gtm-skills/client-request-handler.md` Type J and `gtm-skills/client-offboarder.md` STEP 5
  (Close Billing) previously read as GTME-executed. Both now hand off to the AM.
- **Domain-level and platform-technical fixes.** `gtm-skills/incident-responder.md` Protocol A (blacklist
  removal) and `gtm-skills/deliverability-doctor.md` (Recovery Protocols) previously had GTME personally
  submitting removal requests and making DNS-level changes. Both now note the AM owns execution; the
  existing protocol steps stay as a reference runbook, not a claim that GTME runs them solo by default.
- **Diagnosis vs fix.** `gtm-skills/campaign-optimiser.md`'s diagnostic funnel already stops and hands off
  to `deliverability-doctor.md` when the root cause is infrastructure. That handoff point is exactly where
  "Campaign not performing, technical fault" applies here: GTME still owns the diagnosis, the AM owns the
  infrastructure-level fix once diagnosed.
- **Refunds.** `sops/client-communication-principles.md`'s "Client wants a refund" situational guidance now
  names the AM as the owner of that escalation.
- **Onboarding stays GTME's.** `sops/daily-structure.md`'s Onboarding block (campaigns, lead lists, AI SDR
  configuration) does not include mailbox or domain provisioning, that runs on the AM's separate track in
  parallel. Contract terms (`gtm-skills/client-onboarder.md` Phase 1) come from the AM's already-signed
  deal, GTME confirms them with the client rather than negotiating them.
- **Renewals and QBRs.** `gtm-skills/qbr-writer.md`, `gtm-skills/client-health-scorer.md`, and
  `templates/client-template/overview.md` previously had GTME personally recommending renewal terms,
  running pricing review, and holding "Renewal signed" as a GTME success criterion. All three now treat the
  QBR as GTME building the performance case and the AM leading the terms conversation, per "GTME Owns"
  above.
- **Legal and compliance escalation.** `gtm-skills/incident-responder.md` (Protocols C and E) and
  `gtm-skills/reply-handler.md` previously modeled legal threats and GDPR breaches as the GTME's call to make
  with the client directly. Both now escalate to the GTME's manager/team lead first; client notification
  follows the manager's decision, not the GTME's own judgment call.
- **Wiki knowledge re-scoped to the GTME job.** `wiki/deliverability.md` was a hands-on infrastructure
  manual (DNS setup, blacklist removal steps); it's now a diagnostic reference (benchmarks, symptom-to-
  cause, list verification) with the AM-execution detail removed. `wiki/system-design-process.md` dropped
  its "Recruit Team" step and a reference to an unrelated outside business, out of scope for
  this repo; it's now a 6-step process instead of 7. `wiki/acquisition-systems-theory.md`'s framing no
  longer assumes the reader manages team members or hiring capacity.
- **The relationship layer belongs to CSM, not GTME or the AM.** `sops/tough-client-involve-csm.md` is the
  third handoff this document names, alongside the AM (execution) and the manager (legal/compliance): CSM
  owns the relationship when a client is difficult, disengaged, or consuming disproportionate time.
  `gtm-skills/client-health-scorer.md`'s Red/Critical bands now flag it explicitly.
- **AM escalation now has a concrete procedure.** `sops/gtme-escalation-to-am.md` is the channel
  (#am-vip-handling-updates), message format, and tagging matrix behind every escalation named in this
  document. It also codifies the one case that is a dual-flag rather than a handoff: a client losing
  confidence goes to AM and CSM in parallel, each working their own lever.
- **Client handover is a distinct event from any of the above.** `sops/client-handover.md` covers moving
  an existing client between GTMEs (departure, reassignment, temporary cover), not a task ownership
  question. Aaron's role there (reviewing briefs, assigning incoming GTMEs) is a staffing decision, the
  same person named elsewhere in this document for escalations.
