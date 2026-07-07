# SOP: AM & GTME Responsibility Split

When: any time there is ambiguity about who owns a task or client situation.

There are things the GTME owns and things the AM owns. This document removes the grey area so nothing
falls through the cracks.

---

## GTME Owns

- Campaigns: building, testing, and optimising
- Lead list building
- Day-to-day client management and messaging

---

## AM Owns

- Technical setup: DFY mailbox creation and configuration
- Workspace issues and email throttling
- Domain-level problems (widespread issues, .co flags, etc.)
- Billing

---

## Situational Split

**Client needs to set up Supersearch.** GTME leads the communication. If the client gets stuck with
sign-up or has issues, bring in the AM.

**Widespread domain issues.** AM leads. If you spot it first, flag it to the AM immediately, they own the
fix.

**Technical glitch or platform bug.** AM leads. You can flag it and keep an eye, but do not attempt to fix
it yourself.

**Campaign not performing.** GTME leads. Copy issue, that is on you. Technical fault, loop in the AM.

**Client is over-extending or being extremely demanding.** GTME leads using
`sops/client-communication-principles.md`. If the client needs to be reminded of scope, bring in the AM to
reinforce it.

---

## Where this fits in the OS

This corrects a default assumption baked into several existing skills, that GTME (Harry) personally
executes billing and domain-level technical fixes. He doesn't; the AM does. GTME's job in those situations
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
  parallel.
