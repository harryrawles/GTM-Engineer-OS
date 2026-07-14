# Changelog

All notable changes to the GTM Engineer OS.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and uses semantic versioning.

---

## [3.8.1] - 2026-07-13

### Added - standing campaign-naming convention: `Instantly | ` prefix

Every campaign created via the OS must now be named starting with `Instantly | ` (e.g. `Instantly |
{{Client}} | {{Campaign description}}`). Documented in `wiki/instantly-api-reference.md` (Campaign object
`name` field), `gtm-skills/test-launcher.md` (campaign creation process), and `gtm-skills/campaign-launcher.md`
(pre-flight checklist, item 3) so it's enforced both at creation time and at the launch gate. Surfaced when
a client's GTME had to rename a campaign the OS created without the prefix - applies to all clients, not
just the one that surfaced it.

---

## [3.8.0] - 2026-07-13

### Added - copy density guidance and the opening-hook-question exception

`wiki/copywriting-101.md` Hard Rules gained two refinements surfaced during a client copy review:
a paragraph-grain rule ("group 2-3 related sentences into one paragraph, split only on a genuinely new
idea" - the fix for copy that reads as either one dense block or, over-corrected, one clause per line),
and an explicit exception to "no question marks except the CTA" allowing one opening hook question
("Is {{company}} doing X yet?") as Part 1, since it functions as the pattern-break rather than a mid-body
aside. Both are general copywriting principles, not client-specific, so they went to the shared wiki
rather than staying in that client's `voice.md` alone (which also documents the client-specific Good/Bad
examples that prompted the change).

### Fixed - test-launcher.md STEP 4 described manual-only Instantly setup

`gtm-skills/test-launcher.md` STEP 4 said "the skill does not have write access to Instantly campaigns"
and walked the GTME through pasting copy into the UI by hand. This was stale relative to `CLAUDE.md`'s
actual architecture (the OS calls the Instantly API v2 directly via `.claude/bin/instantly.sh`, with writes
gated by explicit GTME approval, not routed around entirely). Replaced with the real process: pulling the
existing `sequences` array before a `PATCH` (which replaces the whole field, not just a delta), creating a
Draft campaign via `POST /campaigns` for a full-rewrite test, and treating lead-loading/activation as
separate gated actions from campaign creation.

### Added - Complete-modification framing note in test-readiness-check.md

Check #11 (single-variable confirmation) now notes the Complete-modification-level exception: when a
control is confirmed dead and the rewrite is total, the genotype should be framed as one `Stimulus(Vn)`
unit, not decomposed into separately-tracked variables (Content, CTA, Structure) that each look like they
are independently changing. Framed as a single Stimulus, the check passes cleanly, which is what Complete
modification means by definition. Discovered when a client's T-001 tripped this warning unnecessarily on
first framing.

### Added - client-onboarder.md Phase 5 checks for a pre-existing Instantly workspace

Phase 5 previously assumed every onboarding is a blank slate ("leave campaign performance metrics blank -
populate after first campaign runs"). A client's onboarding revealed a live, already-running campaign only
once the API key was loaded - this was a GTME handover, not a net-new signing, and the old instruction
would have left `campaign-state.md` blank instead of seeded with real, already-existing performance data.
Phase 5 now checks `GET /campaigns` once the key is in place and, if any campaigns already exist, pulls
analytics/accounts/step data and flags the account as pre-existing rather than treating it as a fresh start.

---

## [3.7.0] - 2026-07-08

### Added - dedicated fresh-eyes-reviewer sub-agent

Added `.claude/agents/fresh-eyes-reviewer.md`, this OS's first custom Claude Code sub-agent type: a
structurally read-only QA reviewer (tools limited to Read/Grep/Glob - cannot write, edit, or run shell
commands) with "never rewrite, never explain the rule, PASS/FAIL only" baked into its own system prompt.

Repointed `gtm-skills/fresh-eyes-reviewer.md` STEP 3 from the generic `Explore` agent type to this
dedicated one. `Explore` retained Bash access (theoretically capable of a write, even though nothing
instructed it to); the dedicated agent closes that off at the tool-definition level instead of relying on
prompt instructions alone. The rubric itself stays dynamic, passed in per-invocation as before, since
fresh-eyes reviews five different artefact types with five different standards - only the constant
meta-behaviour moved into the agent definition.

No effect on the compounding loop: the sub-agent only reads and returns a review, never writes to
`copy-library.md`, `test-log.md`, `decision-log.md`, or `session-log.md` - those writes stay in the parent
skill exactly as before.

Updated `wiki/_subagent-patterns.md` (new Pattern 4, corrected the `fresh-eyes-reviewer.md` row),
`CLAUDE.md` (repo structure diagram + Shared Brain list), and `INDEX.md` to document `.claude/agents/`.

---

## [3.6.0] - 2026-07-08

### Added - find-skills vendored into .claude/skills/

Vendored `find-skills` (source: [vercel-labs/skills](https://github.com/vercel-labs/skills), path
`skills/find-skills`) into `.claude/skills/find-skills/`, alongside the existing `skill-creator`. Helps
discover and install skills from the open skills.sh ecosystem (`npx skills find` / `npx skills add`) for
general-purpose (non-GTM-specific) capability gaps.

**Modified from upstream:** Step 6 ("Offer to Install") originally ran `npx skills add <pkg> -g -y`
(unattended, global) once the user said go ahead. Changed to always state the exact command and wait for
an explicit yes, and to install locally to the project rather than machine-wide - matching this OS's
approval-before-write model (`CLAUDE.md` → *Safety Guard*: nothing writes or installs without asking
first). No upstream license file was found for this source repo (GitHub reports none); noted in
`.claude/skills/README.md` in place of a `LICENSE.txt`, since a skill installed through it is third-party
code from outside this OS's own review.

Updated `.claude/skills/README.md` and `INDEX.md` to list the new skill.

---

## [3.5.1] - 2026-07-08

### Fixed - final structure review

Reviewed the whole repo's folder/file structure for how well it supports Claude's actual navigation
pattern (explicit path references via `CLAUDE.md`'s routing table and `INDEX.md`, not directory browsing).
Verdict: structurally sound, no reorganization needed - `gtm-skills/` and `wiki/` staying flat is correct
given how they're actually discovered, `frameworks/README.md`'s index-plus-promotion-destination pattern
is working as designed, and `INDEX.md` already documents every directory including small utility folders.

One real gap found: `best-practices/README.md` said "content is uploaded later" without mentioning that
`best-practices/playbooks/` already holds 26 real files - anyone landing on that README specifically would
think the folder was empty. Fixed to match `frameworks/README.md`'s better pattern (index what's here,
state what lands here next).

---

## [3.5.0] - 2026-07-08

### Added - full Instantly v2 API reference

`sops/instantly-api.md` covered only the auth model and ~14 common endpoints, then punted to the raw
OpenAPI URL for everything else. Vendored a comprehensive reference instead: `wiki/instantly-api-reference.md`
covers all ~150 endpoints across every resource (campaigns, leads/lists/subsequences, accounts/warmup,
inbox/email/verification, workspace/members/billing/API keys, webhooks, audit logs/background jobs,
enrichment, custom tags, lead labels, inbox placement testing, DFY orders, CRM actions, blocklist), sourced
directly from the live OpenAPI spec and developer docs, not summarized from memory. Each entry has method,
path, key parameters, response shape, read/write classification, and known gotchas (rate limits, batch
caps, async job patterns, credit costs).

Notable findings worth knowing before building against this API:
- No native bulk-activate/bulk-pause endpoint for campaigns exists server-side, despite tool names implying
  one - bulk behaviour is a client-side loop.
- `/leads/move` and `/leads/bulk-assign` are async background jobs (202/job-id), not synchronous.
- **Webhooks have no signature verification mechanism** - only a caller-defined static header. A skill
  that needs to trust inbound webhook payloads must implement its own shared-secret check.
- DFY email account orders charge a card immediately on a real (non-`simulation:true`) call, with no
  separate confirm step.
- Bare `DELETE /block-lists-entries` (no ID) wipes the entire blocklist.
- Email templates and Custom Prompt Templates have no public documentation despite being usable as MCP
  tools - flagged as undocumented/unstable surface.

`sops/instantly-api.md` now points to the new reference instead of the raw spec URL. `INDEX.md` updated.

---

## [3.4.0] - 2026-07-08

### Fixed - pre-onboarding readiness review (all 19 findings)

Full remediation pass on the pre-onboarding readiness review (blocker + 7 high + 9 medium + 2 low). Real
client onboarding starts after this pass.

**Blocker - safety-guard rewritten to default-deny.** `.claude/hooks/safety-guard.sh`'s block-list had
drifted behind the live Instantly MCP surface - roughly 13 write operations (custom tags, prompt
templates, lead labels, inbox placement, workspace members, phone-number delete, and others) were
executing with no approval gate. Rewrote the matching model: every MCP tool call is now checked against a
curated exact-match `ALLOWED_READS` list built from the actual connected tool inventory (not a
prefix/suffix guess - naming isn't consistent enough for that to be safe, e.g. `move_leads_to_campaign_or_list`
ends in `_list` but is a mutation, `leads_update_interest_status` ends in `_status` but is a mutation).
Anything not on `ALLOWED_READS` or the categorized `BLOCKED_OPS` list now blocks by default, closing the
whole class of gap rather than just the specific ops found. `tests/ci/test-safety-guard.sh` extended to
cover the previously-missing operations, the default-deny fallthrough, and confirms native Claude Code
tools (Read, Grep, etc.) never touch this logic.

**High - onboarding path.**
- `gtm-skills/client-onboarder.md`'s Completeness Report checked for zero `{{PLACEHOLDER}}` values across
  every `clients/{slug}/*.md` file, which can never pass since 7 of the 13 template files intentionally
  keep placeholders until real entries accrue. Scoped to the 6 files the skill actually writes.
- STEP 0.3 copied (not moved) `credentials.template.md` into every client's secrets folder, leaving a
  stray placeholder file behind permanently. Now renames it.
- Added `## STANDARD CONTEXT` to `client-onboarder.md` - the only one of 31 skills missing it.
- Added fields with nowhere to land: "Approved logos" row in `offer.md`, "Industry Vernacular" section in
  `voice.md`, "Tracking domain" row in `campaign-state.md`'s Infrastructure table.
- Added `assigned_am` to `_config.md`'s Identity table (a real per-client fact) and wired it into
  onboarder Phase 1. Did not add a persistent "owning GTME" field - each GTME runs their own instance of
  this OS, so within one repo there is only ever one GTME; `handover-brief-writer.md`'s incorrect claim
  that it writes "owning GTME" to `MEMORY.md` (no such field existed) is removed. `decision-log.md`
  (outgoing/incoming GTME + AM, already logged at STEP 5) is the durable record a handover leaves behind.

**High - numeric drift.**
- `gtm-skills/eod-report-writer.md`'s stagnant-account threshold ("PRR Amber or Red, under 1%") didn't
  match the real Amber/Red bands (under 0.5%, per `sops/campaign-performance-standards.md`) and cited
  `wiki/email-benchmarks.md`, which doesn't use Amber/Red terminology at all. Fixed to under 0.5% with the
  correct citation.
- Two stray "4%" bounce mentions missed by the v3.1.0 fix pass, now 5%: `wiki/diagrams.md`'s optimisation
  flowchart, `templates/client-template/overview.md`'s example pause-trigger line.

### Changed - medium/low cleanup

- Fixed 7 capitalization slips left by the v3.3.0 de-branding pass ("**Context:** the GTME..." should read
  "The GTME" when sentence-initial or immediately after a bold label).
- Dropped stale unlabeled "reply rate" fields (outside the two named PRR exceptions) from
  `gtm-skills/chain-diagnose-campaign.md`, `.github/ISSUE_TEMPLATE/optimization-test.md`,
  `examples/sample-client-report.md`, `examples/sample-weekly-review.md` - these were stale relative to
  the actual skills, which already produce PRR-only output.
- Standardized Aaron's possessive phrasing to "the GTME's manager/team lead" in `incident-responder.md`
  and `reply-handler.md` (previously read "their manager/team lead" in those two files only).
- Added an anchor definition for "Ammad" (the discount sign-off authority) in `sops/churn-prevention.md`,
  matching how "Aaron" is anchored in `sops/am-gtme-responsibility-split.md`.
- Added a Golden Rule 4 extension in `CLAUDE.md`: raw prospect exports never get pasted into a tracked
  file, only `secrets/` is git-ignored, everything else relies on judgment.
- Extended `tests/ci/check-secrets.sh` with an Instantly-key/workspace-id field-value pattern, a JWT
  pattern, and a connection-string-credential pattern (previous coverage was OpenAI/Slack/GitHub/AWS-key
  shaped only, with nothing for the one credential this repo actually exists to protect).
- Backfilled `## QA CHECKLIST` sections on the 9 skills that had none: `list-builder.md`, `icp-builder.md`,
  `handover-brief-writer.md`, `incident-responder.md`, `reply-handler.md`, `campaign-optimiser.md`,
  `weekly-reviewer.md`, `client-report-writer.md`, `client-offboarder.md`.

### Known, deliberately not changed

- `best-practices/` (outside `playbooks/`) and `frameworks/` (outside its `wiki/` redirect) are empty
  pending the compounding loop generating real learnings to promote - left as-is, not stubbed.
- `gtm-skills/pattern-detector.md`'s STEP 0 resolves the active client rather than writing the session-log
  row (that happens in STEP 4, once it knows the downstream skill) - a labeling deviation from the pattern
  every other skill follows, but functionally required here, not changed.
- The two deliberate "Harry" sign-off exceptions from v3.3.0 (`qbr-writer.md`, `client-report-writer.md`)
  remain untouched.

---

## [3.3.0] - 2026-07-08

### Changed - De-branding for multi-GTME template distribution

This OS is now distributed as a shared template for every GTM Engineer at Instantly.ai, not just its
original author. Every occurrence of "Harry" used as a generic placeholder for "the person operating this
OS" is now "the GTME" (or "GTME" for dialogue labels and sign-off name-tags), across ~90 files in
`gtm-skills/`, `wiki/`, `sops/`, `templates/client-template/`, `examples/`, `tests/`, `raw/`, `.claude/`,
`.github/`, and the root docs. All 3 "Refine Flow" mentions (Harry's separate, unrelated business) are
also removed.

**Deliberate exceptions kept as-is** (confirmed with Harry before this pass):
- **Aaron** stays a named, specific escalation contact everywhere (legal/GDPR/refund routing) - not
  genericized. Every GTME using this template inherits the same named manager reference.
- **Copyright/ownership** - `LICENSE`, `CLAUDE.md` ("Managed by: Harry Rawles"), and `README.md`
  ("Designed for one human (Harry)...", "Built for Harry Rawles") still name Harry Rawles as the
  repo's owner/author. This is a legal/authorship fact, not an operator placeholder.
- **Methodology attribution** - the "provided by Harry Rawles" / "provided by Harry" source-material
  credits in `wiki/acquisition-systems-theory.md`, `wiki/darwinian-acquisition-theory.md`,
  `wiki/first-principles-client-acquisition.md`, `wiki/offer-creation-theory.md` (x2),
  `wiki/psychological-principles.md`, `wiki/system-design-process.md`, and the "Harry's iteration
  process" citation in `wiki/scientific-method.md` stay as real historical authorship credit.
- **Generated-deliverable sign-off defaults** - `gtm-skills/qbr-writer.md`'s "Prepared by: Harry Rawles"
  and `gtm-skills/client-report-writer.md`'s "Sign off as Harry, not as the company" instruction are
  untouched.
- **GitHub identifiers** - the `harryrawles` issue-template assignees and the `harryrawles/gtm-meta-os`
  path referenced in this changelog are untouched.
- **CHANGELOG.md itself** is historical record and was not retroactively edited for either "Harry" or
  "Refine Flow" mentions in past entries.

Also fixed one item outside strict scope: `gtm-skills/test-launcher.md`'s sample test-email address
(`harry@refineflow.co`) combined both terms in a live example - replaced with "the GTME's own inbox."

---

## [3.2.0] - 2026-07-08

### Changed - Consistency audit fix pass (Medium + Low, closes the [3.1.0] backlog)

Resolves all 13 Medium and 7 Low findings deferred from the [3.1.0] audit pass. Nothing left outstanding
from the original 5-pass audit.

#### Fixed - wording and cross-reference gaps
- **M1** - `sops/solving-campaign-issues.md` now draws the same activation-vs-provisioning line as
  `wiki/deliverability.md`: tapping the pre-warm pile is GTME's, provisioning new capacity is the AM's.
- **M2** - `gtm-skills/handover-brief-writer.md` now asks planned-vs-unplanned at Step 1 for Temporary
  Cover, before collecting fields, so brief authorship actually follows `sops/client-handover.md`
  Scenario 3 instead of defaulting to whoever invokes the skill.
- **M3** - `wiki/glossary.md`'s acquisition funnel corrected from "6-stage" to "7-stage" (it always listed 7).
- **M4** - added AI SDR, AI Reply Agent, and Cowork to `wiki/glossary.md` - previously undefined despite
  being load-bearing, footnote-requiring terms across `sops/`.
- **M13** - `gtm-skills/signal-sourcer.md`'s action thresholds now match `wiki/signal-sourcing.md` exactly
  (20-49 = marketing nurture this week, not lumped into "monitor only" with everything under 50).
- **L1** - `gtm-skills/cold-email-writer.md`'s two ATL title lists now agree (Director/Head of included in
  both).
- **L2** - "Personalization" → "Personalisation" in `wiki/copywriting-101.md`'s Formula header and
  `wiki/offer-framework.md`, matching the OS's British-English default and the rest of both files.
- **L3** - `wiki/glossary.md`'s BTL list now includes "Coordinator," matching `wiki/atl-btl-messaging.md`
  and `gtm-skills/cold-email-writer.md`.
- **L4** - `INDEX.md`'s Tests table now lists `check-em-dash.sh` and correctly counts 4 CI checks (was 3).
- **L5** - `gtm-skills/client-offboarder.md`'s output template now names the actual single-repo
  `clients/_archived/{slug}-{{YYYY-MM}}/` path instead of stale per-client-repo rename text.

#### Fixed - built the missing capability rather than trimming the promise
- **M6** - `gtm-skills/campaign-optimiser.md` gained an 8th diagnosis check, Volume/pacing (sends/mailbox/day,
  list size vs. send rate, warmup timing), so `gtm-skills/chain-diagnose-campaign.md`'s "Volume/pacing"
  routing branch is now backed by a real check instead of an undefined category.
- **M7** - `gtm-skills/list-builder.md` gained a real STEP 6 - Audit Mode (re-score an active list against
  the current ICP, output % still in-ICP, false-positive count, and a refresh/tighten-ICP recommendation),
  so the chain's "audit mode" invocation now does what it always claimed to.
- **M8** - `gtm-skills/deliverability-doctor.md` and `gtm-skills/incident-responder.md` now cross-reference
  each other with an explicit severity-based handoff: deliverability-doctor is the triage/diagnosis entry
  point, confirmed-Critical situations (blacklist live, bounce over 5%, platform-wide outage) go straight
  to incident-responder.

#### Changed - full scaffolding consistency (L7)
Backfilled YAML frontmatter (`name`/`description`/`triggers`/`reads`/`writes`) onto the 13 skills that were
inline-Trigger-prose-only: `campaign-analyst.md`, `campaign-optimiser.md`, `client-onboarder.md`,
`client-report-writer.md`, `cold-email-writer.md`, `deliverability-doctor.md`, `eod-report-writer.md`,
`icp-builder.md`, `list-builder.md`, `personalization-strategist.md`, `signal-sourcer.md`,
`spintax-ninja.md`, `weekly-reviewer.md`. Every one of the 31 skills in `gtm-skills/` now has the same
header shape.

---

## [3.1.0] - 2026-07-08

### Changed - Consistency audit fix pass (Critical + High)

A 5-pass audit across `gtm-skills/`, `wiki/`, `sops/`, and their neighbors found 6 Critical, 7 High (one
missed on the first pass, see below), 13 Medium, and 7 Low findings - contradictions, gaps, and structural
inconsistencies working against the goal of a controlled, repeatable system. This pass fixes every
Critical and High finding; Medium/Low are documented below as a known-issues backlog for a later pass, per
the same staging approach used for the [3.0.0] CLAUDE.md audit.

#### Fixed - numeric contradictions
- **PRR benchmark scale** (`sops/campaign-performance-standards.md`) is now the single source of truth
  everywhere PRR is mentioned. Purged or relabeled every raw-reply-rate figure that had been mislabeled as
  PRR (`wiki/email-benchmarks.md`'s ColdIQ table, `wiki/copywriting-frameworks.md`, `wiki/signal-sourcing.md`'s
  signal-lift figures, `gtm-skills/reply-handler.md`'s promotion threshold). Raw reply rate is no longer
  tracked as an operative benchmark anywhere except one named exception.
- **Raw reply rate as a deliberate, labeled exception**: `wiki/deliverability.md` and
  `sops/solving-campaign-issues.md` keep raw reply rate for inbox-placement diagnosis (a different question
  to PRR), now explicitly labeled as the exception rather than left ambiguous. Removed the redundant raw
  "Reply rate" row/field from `templates/client-template/campaign-state.md`, `gtm-skills/campaign-analyst.md`,
  `gtm-skills/client-report-writer.md`, and `gtm-skills/weekly-reviewer.md`'s winner-candidate output.
- **Bias count per email**: deleted the orphaned "3-5 total" rule in `wiki/copywriting-101.md` that
  contradicted its own Formula section and `gtm-skills/cold-email-writer.md`'s 12-15/floor-6 rule.
- **Bounce rate**: adopted Harry's authoritative scale (under 2% healthy, 2-5% acceptable but investigate,
  over 5% critical/pause) everywhere - `gtm-skills/incident-responder.md`, `campaign-optimiser.md`,
  `campaign-launcher.md`, `client-health-scorer.md`, `weekly-reviewer.md`, `deliverability-doctor.md`
  (which had disagreed with itself), and `list-builder.md`'s recovery target (1% → 2%).
- **Campaign-update SLA**: `sops/daily-structure.md` collapsed to 3 days everywhere - it had contradicted
  itself between Block 2 and its own Friday Rule paragraph.
- **Subject-line test sample size**: `wiki/subject-lines.md` now matches `wiki/scientific-method.md`'s
  canonical 200 sends/variant (was 100).
- **Refund-demand escalation**: `sops/gtme-escalation-to-am.md` now tags Aaron only if the client has
  public presence, matching `sops/client-communication-principles.md` - was previously unconditional.

#### Fixed - escalation hierarchy
- **Aaron is Harry's manager/team lead** - this is now stated explicitly and canonically in
  `sops/am-gtme-responsibility-split.md`. Every legal/GDPR escalation path (`gtm-skills/incident-responder.md`
  Protocols C and E, `gtm-skills/reply-handler.md`, `wiki/deliverability.md`) now names Aaron directly
  instead of a generic "manager/team lead" that read as a separate, undefined contact.
- **Incident severity table carve-out**: `gtm-skills/incident-responder.md`'s Critical-tier default
  ("client immediately") now explicitly notes that Protocols C and E override it with Aaron's sign-off
  gating client contact - the table and the protocols no longer disagree on timing.
- **"AI inbox management" ambiguity removed**: `sops/onboarding-documentation.md`'s Phase 1 client message
  now says "AI SDR setup" directly instead of the ambiguous "AI inbox management setup," which read like
  the AI Reply Agent's job.

#### Fixed - skill scaffolding (repeatability)
Retrofitted every flagged skill to the same standard shape - no tiering, per Harry's call. Added a
`STANDARD CONTEXT` reference (inheriting `MEMORY.md`/`voice.md`/active-client resolution from
`wiki/_skill-context.md`) to: `weekly-reviewer.md`, `client-report-writer.md`, `campaign-analyst.md`,
`campaign-optimiser.md`, `deliverability-doctor.md`, `icp-builder.md`, `list-builder.md`,
`personalization-strategist.md`, `signal-sourcer.md`. Added a QA checklist to: `campaign-analyst.md`,
`client-health-scorer.md`, `client-request-handler.md`, `icp-builder.md` (via list-builder handoff),
`inbound-activator.md`, `personalization-strategist.md`, `qbr-writer.md`, `signal-sourcer.md`,
`deliverability-doctor.md`. Fixed `skill-forge.md`'s missing STEP 0 Active Log row (direct invocations
were invisible to `pattern-detector.md`) and `test-launcher.md`'s STEP 0 heading (was folded into another
step's heading, breaking the scan pattern).

#### Known issues (deferred - Medium/Low, documented not fixed this pass)
- **M1** - `sops/solving-campaign-issues.md`'s "tap into the pre-warm pile" sits next to "pre-warm
  provisioning" without the activation-vs-provisioning distinction drawn in `wiki/deliverability.md`.
- **M2** - `gtm-skills/handover-brief-writer.md` doesn't ask planned-vs-unplanned at brief-creation time,
  though `sops/client-handover.md` Scenario 3 assigns authorship differently for each.
- **M3** - `wiki/glossary.md`'s "6-stage acquisition funnel" lists 7 stages.
- **M4** - AI SDR, AI Reply Agent, and Cowork are load-bearing terms absent from `wiki/glossary.md`.
- **M6** - `gtm-skills/chain-diagnose-campaign.md` routes to a "Volume/pacing" root cause that
  `campaign-optimiser.md`'s diagnosis framework doesn't define.
- **M7** - the same chain invokes an "audit mode" on `list-builder.md` that doesn't exist.
- **M8** - `deliverability-doctor.md` and `incident-responder.md` share near-identical triggers
  ("blacklisted," "bounce spike") with no rule for which fires first.
- **M13** - `gtm-skills/signal-sourcer.md` collapses signal scores under 50 into "monitor only";
  `wiki/signal-sourcing.md`'s own action-threshold table gives the 20-49 band an active nurture task.
- **L1** - `gtm-skills/cold-email-writer.md` gives two slightly different ATL title lists in one file.
- **L2** - "Personalization" vs "Personalisation" spelling drift against the OS's British-English default.
- **L3** - `wiki/glossary.md`'s BTL title list omits "Coordinator," present in two other files.
- **L4** - `INDEX.md`'s Tests table is missing `check-em-dash.sh` and undercounts the CI check total.
- **L5** - `gtm-skills/client-offboarder.md`'s output template has leftover per-client-repo rename text
  from an earlier architecture; STEP 7's actual instructions are already correct.

---

## [3.0.0] - 2026-07-07

### Changed - BREAKING: Instantly access moves from MCP to the direct API v2, per client

The OS no longer reaches Instantly through an MCP server. Each client's workspace is now called directly
via the Instantly API v2 (<https://api.instantly.ai/api/v2>) using **that client's** API key, through a
single wrapper. This is a better fit for the isolation model - only ever one client's key is loaded per
call, and the key *is* the workspace selector, so the "wrong workspace" failure mode disappears.

#### Added
- **`.claude/bin/instantly.sh`** - per-client Instantly API wrapper. Usage:
  `.claude/bin/instantly.sh [--client SLUG] METHOD PATH [JSON_BODY]`. Resolves the active client (or an
  inline `--client` override), reads `instantly_api_key` from `clients/{slug}/secrets/credentials.md`
  **inside the script**, and calls the API. The key is passed to curl via a stdin config, so it never
  appears in argv, the process list, chat, or `.claude/sessions/*.jsonl`.
- **`sops/instantly-api.md`** - endpoint reference + read/write map + per-client setup/rotation guide.

#### Changed
- **`.claude/hooks/safety-guard.sh`** - new verb-based gating for the wrapper: `GET` (and the read-only
  `POST /leads/list`) run automatically; `POST`/`PATCH`/`PUT`/`DELETE` are blocked pending approval. Also
  blocks raw `curl`/`wget` to `api.instantly.ai` (would leak the key) and blocks printing a real
  `clients/*/secrets/credentials.md`. The existing MCP-operation and dangerous-bash gates are retained.
- **`tests/ci/test-safety-guard.sh`** - 14 new cases covering the wrapper read/write matrix, the raw-curl
  block, and the credentials-print block (passes on the no-jq regex path too).
- **`.github/workflows/ci.yml`** - makes `.claude/bin/*.sh` executable and shellchecks it.
- **`_config.md` schema:** `instantly_mcp_server` + `mcp_connected` → **`instantly_api_configured`**.
  `credentials.template.md` notes the key is consumed by the wrapper (field name `instantly_api_key`
  must stay exact).
- **Docs + skills reworded** from "Instantly MCP" to the API wrapper: `CLAUDE.md` (Credentials & Instantly
  Access, structure diagram), `wiki/_skill-context.md` (new *Instantly Access* section), `MCP-SETUP.md`
  (Instantly section rewritten as API-first; Notion/Clay/Slack stay MCP), `HOOKS-SETUP.md`, `INDEX.md`,
  `README.md`, and every skill that pulls Instantly data (`weekly-reviewer`, `cold-email-writer`,
  `campaign-optimiser`, `campaign-analyst`, `campaign-launcher`, `client-report-writer`,
  `client-health-scorer`, `chain-diagnose-campaign`, `chain-weekly-review-full`, `deliverability-doctor`,
  `client-request-handler`, `qbr-writer`, `eod-report-writer`, `client-offboarder`, `client-onboarder`,
  `pre-launch-check`) plus `wiki/scientific-method.md` and `wiki/_subagent-patterns.md`.

#### Migration
- For each existing client: generate an Instantly API key in that workspace, paste it into
  `clients/{slug}/secrets/credentials.md → instantly_api_key` (git-ignored), set
  `instantly_api_configured: true` in `_config.md`, and verify with
  `switch to {client}` → `.claude/bin/instantly.sh GET /campaigns`.
- No `.gitignore` change needed - `clients/*/secrets/` was already ignored.

#### Verification
- `bash tests/ci/test-safety-guard.sh` passes (reads allowed, writes/sends/raw-curl/credential-prints
  blocked). Live smoke test: wrapper reached the API and returned `[HTTP 401]` on a bad key with the key
  absent from output.

---

## [2.26.0] - 2026-07-04

### Added - Recruitment / staffing MPC playbook

- `best-practices/playbooks/recruitment-staffing.md` - MPC (Most Placeable Candidate) candidate-marketing
  playbook for recruitment/staffing clients generating job orders proactively. Leads with an exclusive,
  quantified-candidate heads-up (not an agency pitch); two subject-lined spintax variants and a suggested
  4-touch scaling structure. Guardrails: only market a genuine MPC, only claim real exclusivity/scarcity, and
  keep the candidate anonymised until the hiring manager opts in (no candidate PII across clients). Merge
  fields/spintax kept verbatim.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.25.0] - 2026-07-04

### Added - AI calling-agent (pro-bono dealership) playbook

- `best-practices/playbooks/ai-calling.md` - AI voice/phone-automation playbook for high-call-volume
  businesses (example: car dealerships), led by a pro-bono/pilot offer around lead capture and 24/7 coverage.
  Two ultra-short spintax variants, binary relevance CTA. **Ships with two prominent guardrails:** keep
  "pro-bono" genuine (not upsell bait), and clear AI-calling behaviour against TCPA / robocall rules before
  promising a working agent (liability can land on the dealership too) - flagged as blocked pending client +
  compliance sign-off. Merge fields/spintax kept verbatim.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.24.0] - 2026-07-04

### Added - Marketing 3 / review-management (reputation) playbook

- `best-practices/playbooks/marketing-3.md` - reputation/review-management playbook for local businesses,
  built on an observational review-reference hook with a fully spintaxed template and multiple CTA variants.
  **Ships with a prominent compliance guardrail** - claiming to delete/guarantee removal of genuine Google
  reviews conflicts with Google policy and consumer-protection law, so the guaranteed-removal language is
  flagged as blocked pending legal sign-off and the copy directs users to lawful phrasing (flag policy-
  violating reviews, respond, rebuild rating). Merge fields/spintax kept verbatim. Distinct from
  `marketing.md` (competitor-insights) and `marketing-2.md` (local traffic).
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.23.0] - 2026-07-04

### Added - Booking-SaaS / experiential-product playbook

- `best-practices/playbooks/booking-saas.md` - friction-removal + discount-hook playbook for experiential /
  booking products (travel, hospitality, lifestyle). Binary "hotel vs Airbnb" framing, ready-access hook,
  incentive, curiosity CTA, opt-out. Brand → `{{COMPANY}}`, incentive → `{{DISCOUNT}}`. **Ships two variants
  with a prominent compliance guardrail:** a recommended safe variant (offer to set up access / one-click
  invite) as the default, and the original pre-created-credentials variant gated behind legal sign-off +
  consented flow (flagged as blocked pending client approval per the OS Safety Guard; passwords must be
  system-generated, never a predictable format).
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.22.0] - 2026-07-04

### Added - Gaming / gamified-classroom teacher-outreach playbook

- `best-practices/playbooks/gaming.md` - gamified classroom/engagement product playbook for direct teacher
  outreach: low-friction free pilot, role relevance, deliberately simple and non-technical (avoid
  "AI/platform/solution" buzzwords). Value points, why-it-works, execution tips. Brand genericised to
  `{{COMPANY}}`. The source provided no email copy, so an illustrative starter draft (clearly labelled) was
  written from the stated strategy for the client to rewrite in voice.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.21.0] - 2026-07-04

### Added - B2C email-marketing / free-flow-rebuild playbook

- `best-practices/playbooks/b2c-email-marketing.md` - eComm retention playbook that opens with a free,
  concrete deliverable (rebuilding the highest-leverage flows - example: Shopify Welcome + Abandoned
  Checkout) to prove value before pitching. Single email, why-it-works, execution tips. Brand genericised to
  `{{COMPANY}}`; "only run if you can actually deliver better flows" guardrail.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.20.0] - 2026-07-04

### Added - Funding 2 / personalized-growth-ideas playbook

- `best-practices/playbooks/funding-2.md` - funding-outreach playbook that leads with AI-personalised growth
  ideas, then softly transitions into funding as the way to execute them. Includes the idea-generation prompt
  (with word cap, 7th-grade language, location use, no-spam-words constraints), value points, why-it-works,
  and execution tips. Brand genericised to `{{COMPANY}}`; merge/enrichment fields kept verbatim. Guardrail:
  the AI ideas must be real and specific or don't run it (use `funding.md` for the direct angle). Distinct
  from the fast-capital `funding.md`.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.19.0] - 2026-07-04

### Added - SaaS 3 / QA-engineer curiosity-hook playbook

- `best-practices/playbooks/saas-3.md` - testing/reliability tool playbook aimed directly at QA and test
  engineers, built on a specific curiosity insight ("the 3 test paths where accuracy drops fastest when the
  UI changes") and a near-zero-friction CTA. Ships as one ultra-short knowledge-first email with an
  "actually have the insight/list before hooking" guardrail. Merge fields kept verbatim. Complements
  `saas-2.md` (leadership-facing) with a QA-native angle.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.18.0] - 2026-07-04

### Added - SaaS 2 / dev-tools in-workflow automation playbook

- `best-practices/playbooks/saas-2.md` - developer-workflow tool playbook (example: MCP-powered autonomous
  QA inside the IDE) aimed at product & engineering leadership. Workflow-integration + shipping-velocity
  framing, single lightweight overview email. Brand genericised to `{{COMPANY}}` and supported IDEs to
  `{{SUPPORTED_IDES}}` with a "don't claim integrations that don't exist" guardrail. Distinct from the
  vertical-pricing `saas.md`.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.17.0] - 2026-07-04

### Added - Media placement playbook

- `best-practices/playbooks/media.md` - media-placement / content-partnership playbook that positions an
  owned audience as a high-trust distribution channel (not ad inventory). Example built around education
  brands reaching parents; three angles, founder-led signature block, opt-out throughout. Branded source
  genericised - founder/company/credibility/audience-size → `{{FOUNDER_NAME}}`, `{{FOUNDER_TITLE}}`,
  `{{CREDIBILITY_MENTION}}`, `{{AUDIENCE_SIZE}}` - with an "approved audience figures + real signatory only"
  guardrail.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.16.0] - 2026-07-04

### Added - Home services / reviews & local-visibility playbook

- `best-practices/playbooks/home-services.md` - value-first playbook for review management / local SEO /
  reputation tools sold to home-service and trades businesses. Analysis-led framing ("studied hundreds of
  businesses") with three practical quick wins, four angles, opt-out throughout. Named audit tool genericised
  to `{{AUDIT_TOOL}}`, with a "the audit/analysis must be real - actually run the business-specific audit
  before sending" guardrail. Merge fields kept verbatim.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.15.0] - 2026-07-04

### Added - Franchising / decision-clarity playbook

- `best-practices/playbooks/franchising.md` - buyer-side franchise-guidance playbook for experienced
  professionals exploring ownership. Clarity-before-commitment framing (guides, quizzes, frameworks over
  pitches), four angles, opt-out throughout, and a "keep it buyer-side, never a single-brand pitch"
  guardrail. Merge fields kept verbatim (incl. `{{City}}` / custom `{{lcsi}}`).
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.14.0] - 2026-07-04

### Added - Vertical-SaaS automation playbook

- `best-practices/playbooks/saas.md` - purpose-built vertical-SaaS automation playbook (real-time pricing /
  data sync) aimed at ops + technical buyers. Risk+speed framing, "industry-specific not generic",
  technical-readiness proof, and a free-trial friction remover. Seven angles, opt-out throughout. Branded
  source genericised - brand → `{{COMPANY}}`, named reference customers → `{{NOTABLE_CUSTOMERS}}`, trial
  terms → `{{TRIAL_OFFER}}` - with a "re-skin the vertical + approved logos/claims only" guardrail. Sample
  copy stays precious-metals-specific to illustrate the pattern.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.13.0] - 2026-07-04

### Added - Medical / rehab ministry-outreach playbook

- `best-practices/playbooks/medical-rehab.md` - addiction-recovery / family-restoration playbook for
  partnering rehab programs with churches. Equip-don't-pitch framing: pastoral tone, gospel + clinical care
  integration, family-restoration focus, feedback-not-commitment CTAs. Four angles, opt-out throughout.
  Explicit **sensitive/health-adjacent guardrail** - clinical and outcome claims must be substantiated and
  approved, never implying guaranteed results; tone stays compassionate and non-pressuring. Merge fields
  kept verbatim.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.12.0] - 2026-07-04

### Added - Merchandise / apparel playbook

- `best-practices/playbooks/merchandise.md` - trust-first apparel/merch-printing playbook for churches and
  community-led buyers. Leads with experience + risk-reduction resources (lessons-learned guide, visual
  mockups, best-practices guide, buyer's guide) across four angles, opt-out throughout, and a
  volume/experience-claims-must-be-approved guardrail. Merge fields kept verbatim.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.11.0] - 2026-07-04

### Added - Med spas / wellness peptide-program playbook

- `best-practices/playbooks/med-spas.md` - education-first playbook for med spas and wellness clinics
  expanding into wellness/recovery/longevity peptides alongside aesthetics. Six angles (wellness expansion,
  local-market context, longevity add-ons, metabolic support, retention/adherence, patient experience),
  opt-out throughout. Explicit **regulated/medical guardrail** - peptide, sourcing, and outcome claims must
  be substantiated and approved; language stays educational, never prescriptive/promissory. Merge fields
  kept verbatim (incl. `{{City}}` / `{{State}}`).
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.10.0] - 2026-07-04

### Added - Investment 2 / VC-education playbook

- `best-practices/playbooks/investment-2.md` - VC/PE education-program playbook built on the credibility-gap
  angle: lead with the "no track record" problem, anchor with real alumni/deal outcomes, offer a guide or
  white paper instead of pitching enrolment. 5-email sequence plus ultra-short / LinkedIn DM / SMS variants
  and opt-out throughout. Heavily branded source genericised - brand → `{{COMPANY}}`, named deal companies →
  `{{NOTABLE_DEALS}}` - with a "verified/approved credibility claims only" guardrail. Distinct from the
  raise-focused `investment.md`.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.9.1] - 2026-07-04

### Changed

- Renamed `best-practices/playbooks/local-traffic-conversion.md` → `marketing-2.md` (and updated its title
  to "Marketing 2"). Content unchanged; README index updated.

---

## [2.9.0] - 2026-07-04

### Added - Local traffic & website-conversion playbook

- `best-practices/playbooks/marketing-2.md` (originally added as `local-traffic-conversion.md`) - value-first playbook for local businesses, trades,
  and professional service firms selling marketing / SEO / CRO / traffic partnerships. Three angles (local
  traffic partnerships, trade website-readiness guide, professional-services conversion gaps), each with an
  A/B variant, local relevance, opt-out language, and a "have the guide/options ready before the hook"
  guardrail. Merge fields kept verbatim (incl. `{{City}}` and custom `{{lcsi}}`). Distinct from the
  competitor-insights `marketing.md`.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.8.0] - 2026-07-04

### Added - Influencer-marketing / curated-creator-list playbook

- `best-practices/playbooks/influencers.md` - value-first influencer-marketing playbook for SaaS / SI
  founders and marketing leaders, built on a hand-curated creator list offered with no upfront pitch.
  4-email sequence plus ultra-short / LinkedIn DM / SMS variants, opt-out language throughout, and a
  "deliver a real curated list, never scraped" guardrail. Merge fields kept verbatim (incl. custom `{{SI}}`).
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.7.0] - 2026-07-04

### Added - HNWI / private-aviation playbook

- `best-practices/playbooks/aviation.md` - high-net-worth / executive outreach led by a discreet,
  low-commitment "pricing overview" hook with a trust-building opt-out line. Includes a 3-email sequence
  plus ultra-short / LinkedIn DM / SMS variants. Brand genericised (`FusionJets` → `{{COMPANY}}`); merge
  fields kept verbatim.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.6.0] - 2026-07-04

### Added - Athletic directors / coaches playbook

- `best-practices/playbooks/athletic-directors.md` - leadership/culture/player-development platform pitched
  to athletic directors and coaches. Reusable pattern: credibility (endorser) + scannable feature list +
  ultra-low-friction "reply 'demo'" CTA. Heavily branded source genericised - brand → `{{COMPANY}}`,
  endorser → `{{NOTABLE_ENDORSER}}`, and product modules turned into a `{{FEATURE_N}}` template block
  (with an illustrative example) so no client's product names leak into another's campaign.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.5.0] - 2026-07-04

### Added - Marketing / competitor-insights playbook

- `best-practices/playbooks/marketing.md` - B2B marketing / demand-gen playbook using a competitor-insights
  curiosity hook (ships as a single short, high-reply email). Merge fields kept verbatim (incl. the custom
  `{{lcsi}}` industry field); includes a "you must be able to deliver the tactics you promise" guardrail.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.4.0] - 2026-07-04

### Added - Retail / shelf-expansion playbook

- `best-practices/playbooks/retail.md` - retail shelf-expansion playbook for F&B / CPG brands (abstracted
  from a CPG campaign; client figures genericised to `{{RETAILERS_PER_WEEK}}`, `{{RETAIL_NETWORK_SIZE}}`,
  `{{CLIENT_COUNT}}`). Positions an AI platform as a faster/cheaper alternative to brokers, with seasonal
  urgency and a soft "point me to the right contact" CTA.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.3.0] - 2026-07-03

### Added - Investment / raise playbook

- `best-practices/playbooks/investment.md` - investor raise playbook (abstracted from an early-stage
  fundraising campaign; brand and raise details genericised to `{{COMPANY}}`, `{{NOTABLE_BACKERS}}`,
  `{{ANCHOR_INVESTMENT}}`, `{{SECTOR}}`, `{{TECH_DESCRIPTION}}`). Credibility-first structure: social proof +
  scarcity + low-friction ask (intro / deck / private overview), with an explicit "investor claims are
  regulated territory - verified + approved only" guardrail.
- Indexed in `best-practices/playbooks/README.md`. No skill wiring needed - `cold-email-writer`,
  `signal-sourcer`, and `chain-build-campaign` already consult the `best-practices/playbooks/` folder.

---

## [2.2.0] - 2026-07-03

### Added - Shared campaign playbooks

- `best-practices/playbooks/` - new shared-layer home for reusable, **client-agnostic** campaign playbooks.
  Available to every client; each playbook is a proven campaign structure (goal, ICP, messaging, sequence,
  when to use/avoid) written with `{{PLACEHOLDER}}` values to adapt per client.
- `best-practices/playbooks/funding.md` - funding / fast-capital playbook (abstracted from a Tiger Capital
  campaign; brand genericised to `{{COMPANY}}` + approved-terms placeholders).
- `best-practices/playbooks/README.md` - playbooks index + the no-client-data rule.
- Wired in: `CLAUDE.md` (Shared Layer note) and `INDEX.md`; `cold-email-writer`, `signal-sourcer`, and
  `chain-build-campaign` now consult `best-practices/playbooks/` and adapt (never drop in verbatim; fill
  from the active client's files, using only Approved Claims from `voice.md`).

---

## [2.1.0] - 2026-07-03

### Added - EOD report writer (daily end-of-day report)

- `gtm-skills/eod-report-writer.md` - new skill. Portfolio-wide daily report that reconstructs the day
  from `.claude/sessions/*.jsonl` (the session-logger hook's raw trail) cross-referenced with each
  client's `session-log.md`, `comms-log.md`, `decision-log.md`, `campaign-state.md`, and `test-log.md`.
  Categorises outcomes by client into MOVED / BLOCKED / NEXT and outputs a plain-text Slack message.
  Runs in portfolio mode (no active client required); defaults the reporter to Harry. Never auto-sends -
  draft only, enforced by the Safety Guard.
- `examples/sample-eod-report.md` - worked example (brand-agnostic placeholders).
- Fills the "Daily - End of Day Wrap" slot in `OPERATING-RHYTHM.md`, previously manual logging.
- Wired into the `CLAUDE.md` routing table and `INDEX.md` (Reporting and Relationship + Examples).

### Why this matters

The end-of-day wrap was the one daily-cadence step with no skill behind it. The session-logger hook
(v1.6.0) already captures every prompt and tool call to `.claude/sessions/`; this skill turns that raw
trail into the outcomes-based report Harry posts to the team, so the day's work is summarised from the
audit trail rather than reconstructed from memory.

---

## [2.0.0] - 2026-07-03

### Changed - BREAKING: single-client OS → multi-client GTM Engineer OS

Restructured the repo in place from a single-client template (one `company/` folder, `{{CLIENT_NAME}}` in
the root files) into a multi-client OS: one shared layer plus a fully isolated `clients/{slug}/` folder per
client, one active client per session. No client data ships in the repo - this migration produces the
reusable template framework only.

#### Added
- **`clients/`** - one isolated folder per client (git-tracked except `secrets/`). Starts empty.
- **`_state/active-client`** - git-ignored pointer to the current active client slug (the active-client model).
- **Shared-layer folders** `frameworks/`, `sops/`, `best-practices/` - each with a README; content uploaded later.
- **`templates/client-template/secrets/credentials.template.md`** - shape-only credentials file (no real keys).
- **Active-client resolution (STEP 0)** in `wiki/_skill-context.md`, `pattern-detector.md`, and `/gtm:compound`;
  portfolio-mode enumeration of `clients/` (skips `_`/`.`-prefixed folders like `clients/_archived/`).

#### Changed
- Root **`CLAUDE.md`** replaced with the multi-client hub (active-client model, isolation golden rules, safety guard, routing).
- **`company/` → `templates/client-template/`** via `git mv` (history preserved); added `slug` + `tier` to `_config.md`;
  `template_version` now sourced from `VERSION`.
- All shared-layer `company/` path references rewritten to `clients/{slug}/` (gtm-skills, wiki, examples, tests,
  issue templates, `/gtm:compound`, hook comment).
- **`client-onboarder`** now creates `clients/{slug}/` from the template + sets the active client + writes the
  git-ignored `credentials.md`; no longer edits shared `CLAUDE.md`/`INDEX.md`.
- **`client-offboarder`** promotes ABSTRACTED learnings to the shared layer (no raw client data) and archives the
  client *folder* (`git mv` to `clients/_archived/`) instead of a per-client repo.
- **`weekly-reviewer` / `chain-weekly-review-full`** portfolio mode now enumerates `clients/` directly - the
  anticipated "meta-OS" is this repo (removed "deferred until meta-OS exists" / manual client list).
- Guides rewritten for multi-client flow: `README.md`, `BOOTSTRAP.md`, `OPERATING-RHYTHM.md`, `MCP-SETUP.md`,
  `HOOKS-SETUP.md`, `INDEX.md`.
- **`.gitignore`** now ignores `clients/*/secrets/`, `_state/active-client`, and `**/.env`.

#### Preserved (unchanged content)
- All GTM skill logic and knowledge in `gtm-skills/`, `wiki/`, `examples/`, `tests/`, `assets/`, `raw/`, `.github/`
  (only `company/` path references and single-client framing updated).

---

## [1.6.0] - 2026-05-31

### Added - Lifecycle hooks + /gtm:compound win-capture command

#### Hooks (`.claude/hooks/` + `.claude/settings.json`)

Three hooks that fire unconditionally via the OS lifecycle - they cannot be skipped by a skill, unlike CLAUDE.md instructions.

- **`.claude/hooks/safety-guard.sh`** (PreToolUse) - physically blocks dangerous tool calls before execution (exit code 2). Scoped to: Instantly campaign mutations (activate, pause, delete, update sequence, delete leads, suppress contacts, modify email accounts), external messaging (Gmail, Slack), financial operations (Stripe), destructive data operations, and dangerous bash patterns (git push --force, rm -rf, DROP TABLE, curl|sh). The prior CLAUDE.md Safety Guard was instructions to Claude. This is a hard block at the OS level.
- **`.claude/hooks/session-logger.sh`** (UserPromptSubmit, PreToolUse, PostToolUse, PostToolUseFailure, Stop, PreCompact, SessionEnd) - logs every event to `.claude/sessions/<session_id>.jsonl`. Distinct from `company/session-log.md` (the per-client AI-readable skill invocation log). The JSONL files are gitignored and stay local.
- **`.claude/hooks/notify.sh`** (Stop, PermissionRequest, SessionStart, SessionEnd, SubagentStop, Notification) - cross-platform desktop notifications. macOS (osascript), Linux (notify-send), Windows (PowerShell toast).
- **`.claude/settings.json`** - wires all three hooks to 11 lifecycle events.

#### Slash command (`.claude/commands/compound.md`)

- **`/gtm:compound`** - real-time win capture. Auto-triggers on "that worked" / "huge win" / "this is a playbook". Uses four parallel subagents (Metrics Extractor, Copy Extractor, Why-It-Worked Analyst, Replication Strategist), then assembles and writes to `company/copy-library.md` Top Performers + `company/decision-log.md`. Complements weekly-reviewer: compound captures in the moment, weekly-reviewer confirms on Friday after sample size is validated.

#### Supporting files

- **`HOOKS-SETUP.md`** - installation guide (chmod, jq, Instantly tool name verification, troubleshooting).
- **`.gitignore`** - added `.claude/sessions/` to exclude JSONL audit logs from commits.

### Why this matters

The prior Safety Guard was markdown instructions. The safety-guard.sh hook is the difference between "Claude is told not to do this" and "Claude physically cannot do this" - enforced on every tool call regardless of which skill is running.

The /gtm:compound command closes the time gap between when a win happens and when it gets logged. Without it, wins are reconstructed from memory on Friday. With it, the full copy, metrics, and why-it-worked are captured in the session where the result landed.

---

## [1.5.0] - 2026-05-31

### Added - Two-tier Friday review (triage + full review on flagged clients only)

Running full reviews on all 20 clients every Friday took 5-6 hours - the original "3-4 hours" estimate required a batch mode that did not exist. This release closes that gap.

#### `gtm-skills/weekly-reviewer.md`
- **New section: TWO-TIER MODE SELECTION** - documents when to use quick-review vs full review
- **New section: QUICK-REVIEW MODE - Triage Pass** - 2-minute triage check per client. Runs four gates (G1 winner candidate, G2 loser candidate, G3 test completing, G4 signal declining). Green-pass clients get a one-line health stamp and move on; flagged clients escalate to full review. Writes a session-log row per client. Does not log winners, diagnose losers, or analyse tests - it only checks whether those things need doing.

#### `gtm-skills/chain-weekly-review-full.md`
- **New section: PORTFOLIO TRIAGE MODE** - Friday portfolio entrypoint for 20 clients. Sweeps all clients via quick-review triage (~40 min total), outputs a portfolio table, then runs single-client full review only on flagged clients. Honest time estimate embedded: 2.5-4 hours depending on how many clients are flagged.
- **Updated trigger list** - added "Friday portfolio triage", "Run triage for all clients", "Portfolio sweep"
- **Updated RULES** - replaced deferred batch-mode note with instruction to use Portfolio Triage Mode

#### `OPERATING-RHYTHM.md`
- **Friday section rewritten** - three-step flow: (1) portfolio triage ~40 min, (2) full review on flagged clients only ~15-20 min each, (3) reports ~45 min. Time estimate updated to 2.5-4 hours.
- **Total weekly time estimate** updated from ~28 hours to ~20-25 hours.

### Why this matters

The math discrepancy was: operating rhythm claimed 3-4 hours for 20 clients on Friday; weekly-reviewer stated 15-20 min per client in single mode (= 5-6 hours). The batch mode that would have bridged this was marked "deferred until meta-OS exists". This release solves the problem within the existing per-client structure by adding a triage gate - most clients in a stable portfolio need only a 2-minute health stamp on any given Friday. No meta-OS required.

Typical distribution: 5-8 clients flagged per Friday out of 20. The rest are a 2-minute Green pass.

### Planned - v1.6.0

**Meta-OS (`harryrawles/gtm-meta-os`)** - a portfolio-level repo that formalises the clients list (replacing the verbal list in Portfolio Triage Mode), enables cross-client pattern surfacing (winning frameworks replicating across clients), and provides a single view of portfolio health. Build after 4-6 real Friday reviews - triage data will reveal which clients cluster as perennially flagged vs perennially green, shaping the meta-OS architecture.

---

## [1.4.2] - 2026-05-31

### Removed - Recruitcha example client

The OS shipped with a fully-filled `examples/recruitcha-completed-os/` directory plus inline "Recruitcha / Drew / TurboTenant / HealthNote" worked examples scattered across skills and sample files. This release scrubs all named-client references in favour of the template's `{{PLACEHOLDER}}` convention.

- **Deleted** `examples/recruitcha-completed-os/` (7 files: README + 6 filled company/*.md).
- **Scrubbed** 16 files across `gtm-skills/`, `examples/sample-*.md`, `tests/`, `company/`, and `wiki/inbound-orchestration.md`. Replacements: `Recruitcha` → `{{CLIENT_NAME}}`, `Drew` / `Drew Ryan` → `{{PRIMARY_CONTACT}}`, `TurboTenant` → `{{NAMED_PROOF_COMPANY}}`, `HealthNote` → `{{NAMED_PROOF_COMPANY_2}}`, `getrecruitcha.com` → `{{SENDING_DOMAIN}}`.
- **Updated** `CLAUDE.md` File Structure block and `INDEX.md` Examples table to drop the deleted directory.

### Why this matters

Cloning the template to 20 clients meant each client OS shipped with a named competitor's worked-example data embedded throughout. Cleaner template, no risk of accidental cross-client name leakage in copy/QBR outputs that get reviewed inattentively.

### Verification

`grep -ri "recruitcha\|drew ryan\|turbotenant\|healthnote" .` returns zero matches across the repo.

---

## [1.4.1] - 2026-05-31

### Fixed - Session-log writes now implemented across all skills

The v1.4.0 auto-improvement loop was non-functional: the mandate in `wiki/_skill-context.md` said every skill must write to `company/session-log.md` at the START of execution, but only 2 of 28 skills (pattern-detector, skill-forge) actually did so. Pattern-detector had no data to detect from. This release closes that gap.

- **26 skills updated** with a new `## STEP 0 - Log Invocation (mandatory)` section that appends a row to `company/session-log.md` Active Log before any other work. Format and rules cite `wiki/_skill-context.md` to keep the canonical source single.
- **4 skills already had a STEP 0** (chains + test-launcher) - those received an inline "**Log this invocation first.**" directive at the top of their existing STEP 0 to add the log-write without renumbering downstream steps.
- **`CLAUDE.md` Session Start Protocol strengthened** with explicit "Every skill writes its own session-log row" paragraph. Chains write their own row in addition to the sub-skill rows.

### Fixed - Orphaned skill `inbound-activator.md` now routed

`gtm-skills/inbound-activator.md` existed but was missing from the CLAUDE.md routing table - invisible to users despite being a substantive 11KB skill covering signal capture → enrichment → qualification → tier-routed outbound activation. Now wired in under "Operations and crises".

### Updated - CLAUDE.md

- Routing table: added `inbound-activator` (4 trigger phrases) and a new "Helper skills" subsection documenting `fresh-eyes-reviewer` as a sub-agent invoked by other skills (not user-facing).
- File Structure block refreshed to list all 28 skills (was 20), and `company/` directory now shows `MEMORY.md` and `session-log.md`.
- Clarified `forged-quick-diagnose.md` example in pattern-detector docs as illustrative-only (file does not exist in template).

### Why this matters

Without per-skill session-log writes, the pattern-detector cannot find repeating prompts and the OS cannot auto-improve. v1.4.0 advertised "exponential improvement" but shipped without the data producers. v1.4.1 is the release that actually makes the loop work.

### Verification

After cloning v1.4.1 for a new client, invoke any 3 skills in sequence. `company/session-log.md` Active Log should show 3+ rows, one per invocation, written at START of each skill (so even a mid-execution failure leaves an audit trail).

---

## [1.4.0] â€” 2026-05-31

### Added â€” Auto-improvement loop (the exponential mechanism)

The OS now detects repeating patterns in how Harry uses it and auto-creates skills to automate them. Every Claude Code session runs pattern detection FIRST.

- `gtm-skills/pattern-detector.md` â€” new skill. Runs at the start of every Claude session per the new CLAUDE.md Session Start Protocol. Reads `company/session-log.md` (last 90 days), compares the current prompt against historical prompts by abstract intent, surfaces a one-line note when 3+ matches found. Never blocks work â€” surfaces and proceeds. Respects "Rejected pattern suggestions" so dismissed patterns stay dismissed.
- `gtm-skills/skill-forge.md` â€” new skill. Invoked when Harry replies "forge it" to a pattern detection. Drafts a new skill following OS conventions and saves to `gtm-skills/forged-{name}.md` with mandatory `forged-` prefix. Never auto-promotes â€” Harry reviews and renames to canonical once vetted in real use.
- `company/session-log.md` â€” new per-client invocation log. Every skill writes a row at the START of execution. Three sections: Active Log (last 90 days), Pattern Detection State (Rejected pattern suggestions + Forged skills), Archive (older than 90 days). This is the substrate that makes the OS exponentially improving.

### Updated

- `CLAUDE.md` â€” new "Session Start Protocol (mandatory)" section. Mandates pattern-detector runs FIRST every session. Routing table now includes pattern-detector (automatic trigger) and skill-forge (triggered by "forge it" response or direct invocation).
- `wiki/_skill-context.md` â€” `company/session-log.md` added to Standard Reads. New "Session-Log Write (mandatory for every skill)" section requires every skill to append a session-log row at the START of execution.
- `company/MEMORY.md` template â€” new "Forged Skills (pending review)" section between Recent Learnings and Archive. Lists auto-forged skills awaiting Harry's review/promotion. "How Skills Update This File" updated to include pattern-detector and skill-forge.

### How "exponential" works

- Session 1-10: log accumulates, no patterns yet.
- Session ~15: pattern-detector notices you've asked variants of "diagnose X campaign metrics" 4 times in 30 days â†’ surfaces tentative pattern.
- Session ~20: pattern hits 5+ matches â†’ confirmed detection. Harry replies "forge it" â†’ skill-forge drafts `gtm-skills/forged-quick-diagnose.md` for review.
- Session ~22: Harry reviews, refines, renames to drop `forged-` prefix, adds to CLAUDE.md routing. Future similar prompts auto-route to the new skill in 1 step instead of 5.
- After 6 months: ~10-20 custom skills tailored specifically to YOUR usage patterns, all automated.

The OS gets demonstrably faster with use. That is the exponential part.

### Safety rails

- Pattern detection NEVER auto-forges. Always requires Harry's explicit "forge it" reply.
- Forged skills carry the `forged-` prefix until Harry manually promotes (rename + add to routing). Forged skills are NOT in the canonical routing table.
- Rejected patterns are permanently sticky â€” once Harry says "skip this", the pattern signature lives in `company/session-log.md` Rejected pattern suggestions and never re-surfaces.
- Session log is per-client (in `company/`), so no cross-client data leakage.
- Pattern-detector writes its own session-log entry; recursion is fine because the detector recognises its own entries and skips them.

### Architectural note

User declined lifecycle hooks earlier (SessionStart, SessionEnd, etc.). This implementation achieves "constant pattern watching" without hooks by mandating that pattern-detector runs first at EVERY user-initiated session. "Constant" from the user's perspective = "every time the OS is active." True background detection between sessions would require revisiting the hooks decision.

---

## [1.3.0] â€” 2026-05-30

### Added â€” Multi-skill chains (intelligent skill composition)

Three new "chain" skills that compose existing skills end-to-end with smart routing (only invoke what is actually needed for the context) and operator pause-points between stages. Synthesised from the multi-agent slash command pattern in `janskuba/go-to-market-orchestrator`, adapted to our markdown-native architecture.

- `gtm-skills/chain-build-campaign.md` â€” full campaign creation chain. Assesses state first, then conditionally invokes icp-builder, list-builder, signal-sourcer, personalization-strategist (skipped when not needed), then always runs cold-email-writer, pre-launch-check, campaign-launcher. Iterating a winner runs ~3 steps in 25 min vs running each of 7 skills individually for ~90 min.
- `gtm-skills/chain-diagnose-campaign.md` â€” performance diagnostic chain. Always runs campaign-optimiser to categorise root cause, then routes to the right specialist (deliverability-doctor / list-builder / signal-sourcer / cold-email-writer for variant), optionally queuing a corrective test via test-readiness-check + test-launcher.
- `gtm-skills/chain-weekly-review-full.md` â€” Friday compounding loop. End-to-end: client-health-scorer â†’ weekly-reviewer (full 8 steps including synthesis) â†’ conditional test promotion via test-readiness-check + test-launcher â†’ client-report-writer. The single command for the most important recurring activity in the OS.

### Updated

- `CLAUDE.md` â€” new "Multi-skill chains (recommended entry points for common workflows)" section in the routing table, placed above setup/operating-rhythm. Existing skill entries updated to note which chain invokes them.
- `INDEX.md` â€” new "Multi-Skill Chains (start here for common workflows)" section at the top. Existing skill rows annotated with chain context.

### Why this design

The user explicitly chose chains over lifecycle hooks (which were the bigger architectural addition from janskuba's repo). Reasoning: chains keep operator visibility (you see every step, can pause and edit) while hooks would silently auto-fire on Claude Code lifecycle events. For a solo operator managing client work, visibility beats automation.

Chains use **smart routing** â€” they assess state in Step 0 and only invoke sub-skills that are actually needed. Skip conditions are explicit and transparent (every skip is logged with a reason). This was the user's explicit constraint: "use only the specific skills you need."

### Deferred from janskuba analysis (not added)

- Lifecycle hooks (Stop, SessionEnd, PostToolUse, SessionStart) â€” user chose to stay fully Harry-triggered
- 17 GTM content prompts (sales decks, case studies, one-pagers, LinkedIn carousels, proposals) â€” user chose to stay cold-email-only
- Python orchestrator + REST API handlers (17 platforms) â€” we use MCP-based integration
- Executable tests + DRY_RUN + installer/validator scripts â€” user chose to stay markdown-only
- Role-based starter packs (founder/sales/marketing/ops/design) â€” we have one client OS template by design

### Source material

Synthesised from `janskuba/go-to-market-orchestrator` â€” specifically the `/outbound-pipeline` slash command pattern that chains 5 subagents via CSV checkpoint files. We adapted the chaining pattern to our markdown-native architecture (markdown checkpoints in `company/decision-log.md` rather than CSV files; existing skill invocations rather than separate subagent definitions).

---

## [1.2.0] - 2026-05-30

### Added - Cognitive bias system for copywriting
- `wiki/psychological-principles.md` - full rewrite. 55+ foundational cognitive biases (each with cold-outreach examples) + 32 Morgan's Heuristics (practitioner observations) + `Biases by Copy Stage` quick-reference table mapping each part of the email (Subject, Part 1-4, Follow-ups, Objection handling, Re-engagement) to which biases to leverage and which to avoid + Overdone-It bias warning to prevent over-application.
- `wiki/copywriting-101.md` - each Part of the 4-part formula now lists biases to leverage and biases to avoid. Added `Bias Application` section explaining the 3-5 biases per email rule.
- `gtm-skills/cold-email-writer.md` - added **Step 7 - Map biases per part of the formula** in pre-write protocol. Forces explicit bias planning before writing.
- `wiki/objection-library.md` - all 14 objection response templates annotated with the biases each leverages. Pattern: shows WHY each response works, not just the script.
- `gtm-skills/reply-handler.md` - Step 2G (objection routing) now references the bias-annotated objection-library and includes a bias check before sending.

### Added - Scientific method iteration framework
- `wiki/scientific-method.md` - canonical rewrite. Genotype/fitness terminology, Polaris (secondary metric upstream of primary), full 4-step framework (Formulate → Test → Observe → Iterate), explicit modification levels (Slight/Moderate/Complete) tied to KPI distance, 5-question success determination tree, `Managing Future Experiments` regression check, 10 common failure modes documented.
- `company/test-log.md` - full template restructure. Every test entry now forces explicit Step 1 fields: genotype (V-numbered variables), primary + secondary KPIs with target values, sample size, latency window, airtight check (5-item checklist), variant configuration with V-numbers, constants (locked during run), stop conditions, backtrack plan. Completed tests must capture Step 3 (six-rule check + verified data + 5-question tree) and Step 4 (iteration decision). New `Reverted Tests` section.
- `gtm-skills/test-readiness-check.md` (new skill) - pre-test gate mirroring pre-launch-check. Validates a Queued test in test-log against all Step 1 sub-steps + stop conditions + backtrack plan. Returns READY / READY WITH WARNINGS / NOT READY. Blocks test-launcher if NOT READY.
- `gtm-skills/test-launcher.md` - added mandatory **Step 0** invoking test-readiness-check before any test launches. Updated Step 5 to mark campaign as `TEST ACTIVE - T-{{ID}} testing {{variable}}. Constants LOCKED.` in campaign-state.md (the trigger for strict-block guards).
- `gtm-skills/weekly-reviewer.md` - Step 5 expanded with six-rule completion check, 5-question success tree, regression check (`Managing Future Experiments` rule from scientific-method.md), and active-test awareness (skip variant analysis if not at sample / latency yet).
- `gtm-skills/cold-email-writer.md`, `gtm-skills/client-request-handler.md`, `gtm-skills/campaign-optimiser.md` - all three now include the **Active-Test Strict Block** section. Skills refuse to modify constants of a campaign with TEST ACTIVE flag. Operator override available with explicit `Override active test T-{{ID}}` command, which moves test to Reverted, logs to decision-log, and removes the flag.

### Why this matters

The bias system makes copywriting deliberate, not intuitive - every email has 3-5 biases consciously leveraged for the specific signal x persona x offer combination. The scientific method enforcement (test-readiness-check + strict-block guards) makes iteration compound - without Ceteris Paribus enforcement, mid-test changes silently invalidate data and the OS stops learning. With both: copy is psychologically calibrated AND test results are trustworthy.

### Source material

- Cognitive Bias Codex (Wikimedia Commons) + Morgan's Heuristics (Harry's practitioner observations from ~1,000 client signings)
- Scientific method content from Harry's iteration process documentation
- Cross-references added to all related skills

---
## [1.1.0] - 2026-05-29

### Added - Inbound orchestration
- `wiki/inbound-orchestration.md` - framework for detecting and activating inbound signals (website visitors, job changes, funding, hiring, tech changes) before cold outreach. Speed-to-lead SLA matrix, multi-signal stacking, tier-based routing.
- `gtm-skills/inbound-activator.md` - skill to close the loop between detected inbound signal and outbound activation. 8-step flow: capture → enrich → qualify → multi-signal check → activate → generate copy → log → set follow-up.

### Added - Memory pattern
- `company/MEMORY.md` - per-client always-loaded scratchpad. Distinct from decision-log (structured rationale) and comms-log (events). Captures active focus, inbound watch, client preferences, watch-outs, open questions, recent learnings. Auto-pruning rules embedded.
- Updated `CLAUDE.md` Behaviour Rules to mandate reading MEMORY.md first.
- Updated `wiki/_skill-context.md` to include MEMORY.md in standard reads.

### Added - Sub-agent pattern
- `wiki/_subagent-patterns.md` - shared playbook for when and how skills spawn isolated sub-agents using Claude Code's Agent tool. When to spawn, when not to, cost/latency trade-offs, briefing rules.
- `gtm-skills/fresh-eyes-reviewer.md` - explicit manual skill to spawn an Explore sub-agent for independent QA on any artefact (copy, ICP, offer, decision).
- Updated `gtm-skills/cold-email-writer.md` to add Pass 2 (fresh-eyes sub-agent review) for high-stakes copy.
- Updated `gtm-skills/incident-responder.md` to spawn general-purpose sub-agent for blacklist and platform status lookups during Protocols A and D.
- Updated `gtm-skills/weekly-reviewer.md` to optionally spawn general-purpose sub-agent during Step 7 synthesis when pattern is unclear.

### Source material
Synthesised from:
- ivangfalco/gtm-skills (specifically 03-revops/lead-management/inbound-orchestration-framework.md)
- ivangfalco.github.io/claude-code-frameworks/ (architecture, MEMORY pattern, sub-agent pattern)

### Deferred (analysed but not added)
- ABM / paid media coverage (LinkedIn Ads, Google Ads, Meta Ads) - user confirmed clients are email-focused only
- Full RevOps suite (lead routing, lifecycle, SLA management, capacity planning, territory planning) - only inbound orchestration is applicable to current scope
- Python execution layer (kenny589 pattern) - would replace MCP; loses portability
- Governance / proposal system - overkill for solo operator

---
## [1.0.0] - 2026-05-29

### Initial production template

**Knowledge base (wiki/)**
- copywriting-101 - canonical copywriting rules and 4-part formula
- copywriting-frameworks - 13 named frameworks (Do the Math, Pattern Interrupt, HOT, etc.)
- offer-framework - 12-step offer building process
- psychological-principles - cognitive biases for copy
- scientific-method - split test methodology
- subject-lines - 4 subject line formulas
- atl-btl-messaging - VP/C-Level vs Manager/IC messaging
- signal-sourcing - 6 core signals, scoring framework, 11 GTM plays
- buying-triggers - 137-trigger taxonomy
- personalization-at-scale - 6 buckets, hooks, AI prompts
- deliverability - DNS, warmup, infrastructure, recovery
- list-building - ICP scoring (100-pt), ABM tiers, validation
- email-benchmarks - industry benchmarks
- glossary - all acronyms defined
- industry-vernacular - language guides by sector
- objection-library - top 15 objections with responses
- linkedin-channel - (deferred to v2)
- diagrams - visual flowcharts of OS workflows

**Skills (gtm-skills/)**
- client-onboarder - conversational setup for new clients
- weekly-reviewer - Friday compounding loop
- pre-launch-check - placeholder + completeness gate
- cold-email-writer - primary copy production
- campaign-optimiser - diagnose underperformance
- campaign-launcher - pre-flight launch checklist
- signal-sourcer - signal selection and scoring
- personalization-strategist - bucket selection and AI prompts
- list-builder - ICP scoring, ABM tiers, validation
- deliverability-doctor - diagnose and recover deliverability
- reply-handler - route replies by type
- client-request-handler - mid-week client request routing
- test-launcher - fire next split test
- client-health-scorer - per-client risk score
- client-report-writer - weekly client report
- client-offboarder - end-of-engagement flow
- qbr-writer - quarterly business review
- incident-responder - incident protocols
- campaign-analyst - performance analysis
- icp-builder - ICP refinement

**Per-client files (company/)**
- _config.md - central config (referenced by other files)
- overview.md - client identity, SLA, success criteria
- icp.md - target profile, signals, avoid list
- offer.md - what they sell, proof points
- voice.md - tone rules, banned words, spelling default
- campaign-state.md - live campaigns, infrastructure, tools
- decision-log.md - why decisions were made
- competitive-intel.md - competing offers, battle cards
- comms-log.md - client communication record
- copy-library.md - top-performers and graveyard
- test-log.md - split test history

**Infrastructure**
- README.md - human-facing intro
- BOOTSTRAP.md - setup entry point
- OPERATING-RHYTHM.md - daily/weekly/monthly cadences
- MCP-SETUP.md - MCP connection guide
- VERSION - semver
- CHANGELOG.md - this file
- LICENSE - usage rights
- .gitignore - committed file hygiene
- .github/ISSUE_TEMPLATE/ - issue templates for client requests, launches, incidents, tests
- examples/ - completed reference examples
- tests/ - test scenarios for OS regression checks

### Removed
- Refine Flow branding (now brand-agnostic template)

---

## How to update

When you change the template:
1. Update VERSION (semver)
2. Add an entry to this CHANGELOG.md with the version bump
3. The onboarder will write the new version into each new client repo's `company/_config.md`
