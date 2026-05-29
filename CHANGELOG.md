# Changelog

All notable changes to the GTM Client OS template.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and uses semantic versioning.

---

## [1.1.0] — 2026-05-29

### Added — Inbound orchestration
- `wiki/inbound-orchestration.md` — framework for detecting and activating inbound signals (website visitors, job changes, funding, hiring, tech changes) before cold outreach. Speed-to-lead SLA matrix, multi-signal stacking, tier-based routing.
- `gtm-skills/inbound-activator.md` — skill to close the loop between detected inbound signal and outbound activation. 8-step flow: capture → enrich → qualify → multi-signal check → activate → generate copy → log → set follow-up.

### Added — Memory pattern
- `company/MEMORY.md` — per-client always-loaded scratchpad. Distinct from decision-log (structured rationale) and comms-log (events). Captures active focus, inbound watch, client preferences, watch-outs, open questions, recent learnings. Auto-pruning rules embedded.
- Updated `CLAUDE.md` Behaviour Rules to mandate reading MEMORY.md first.
- Updated `wiki/_skill-context.md` to include MEMORY.md in standard reads.

### Added — Sub-agent pattern
- `wiki/_subagent-patterns.md` — shared playbook for when and how skills spawn isolated sub-agents using Claude Code's Agent tool. When to spawn, when not to, cost/latency trade-offs, briefing rules.
- `gtm-skills/fresh-eyes-reviewer.md` — explicit manual skill to spawn an Explore sub-agent for independent QA on any artefact (copy, ICP, offer, decision).
- Updated `gtm-skills/cold-email-writer.md` to add Pass 2 (fresh-eyes sub-agent review) for high-stakes copy.
- Updated `gtm-skills/incident-responder.md` to spawn general-purpose sub-agent for blacklist and platform status lookups during Protocols A and D.
- Updated `gtm-skills/weekly-reviewer.md` to optionally spawn general-purpose sub-agent during Step 7 synthesis when pattern is unclear.

### Source material
Synthesised from:
- ivangfalco/gtm-skills (specifically 03-revops/lead-management/inbound-orchestration-framework.md)
- ivangfalco.github.io/claude-code-frameworks/ (architecture, MEMORY pattern, sub-agent pattern)

### Deferred (analysed but not added)
- ABM / paid media coverage (LinkedIn Ads, Google Ads, Meta Ads) — user confirmed clients are email-focused only
- Full RevOps suite (lead routing, lifecycle, SLA management, capacity planning, territory planning) — only inbound orchestration is applicable to current scope
- Python execution layer (kenny589 pattern) — would replace MCP; loses portability
- Governance / proposal system — overkill for solo operator

---
## [1.0.0] — 2026-05-29

### Initial production template

**Knowledge base (wiki/)**
- copywriting-101 — canonical copywriting rules and 4-part formula
- copywriting-frameworks — 13 named frameworks (Do the Math, Pattern Interrupt, HOT, etc.)
- offer-framework — 12-step offer building process
- psychological-principles — cognitive biases for copy
- scientific-method — split test methodology
- subject-lines — 4 subject line formulas
- atl-btl-messaging — VP/C-Level vs Manager/IC messaging
- signal-sourcing — 6 core signals, scoring framework, 11 GTM plays
- buying-triggers — 137-trigger taxonomy
- personalization-at-scale — 6 buckets, hooks, AI prompts
- deliverability — DNS, warmup, infrastructure, recovery
- list-building — ICP scoring (100-pt), ABM tiers, validation
- email-benchmarks — industry benchmarks
- glossary — all acronyms defined
- industry-vernacular — language guides by sector
- objection-library — top 15 objections with responses
- linkedin-channel — (deferred to v2)
- diagrams — visual flowcharts of OS workflows

**Skills (gtm-skills/)**
- client-onboarder — conversational setup for new clients
- weekly-reviewer — Friday compounding loop
- pre-launch-check — placeholder + completeness gate
- cold-email-writer — primary copy production
- campaign-optimiser — diagnose underperformance
- campaign-launcher — pre-flight launch checklist
- signal-sourcer — signal selection and scoring
- personalization-strategist — bucket selection and AI prompts
- list-builder — ICP scoring, ABM tiers, validation
- deliverability-doctor — diagnose and recover deliverability
- reply-handler — route replies by type
- client-request-handler — mid-week client request routing
- test-launcher — fire next split test
- client-health-scorer — per-client risk score
- client-report-writer — weekly client report
- client-offboarder — end-of-engagement flow
- qbr-writer — quarterly business review
- incident-responder — incident protocols
- campaign-analyst — performance analysis
- icp-builder — ICP refinement

**Per-client files (company/)**
- _config.md — central config (referenced by other files)
- overview.md — client identity, SLA, success criteria
- icp.md — target profile, signals, avoid list
- offer.md — what they sell, proof points
- voice.md — tone rules, banned words, spelling default
- campaign-state.md — live campaigns, infrastructure, tools
- decision-log.md — why decisions were made
- competitive-intel.md — competing offers, battle cards
- comms-log.md — client communication record
- copy-library.md — top-performers and graveyard
- test-log.md — split test history

**Infrastructure**
- README.md — human-facing intro
- BOOTSTRAP.md — setup entry point
- OPERATING-RHYTHM.md — daily/weekly/monthly cadences
- MCP-SETUP.md — MCP connection guide
- VERSION — semver
- CHANGELOG.md — this file
- LICENSE — usage rights
- .gitignore — committed file hygiene
- .github/ISSUE_TEMPLATE/ — issue templates for client requests, launches, incidents, tests
- examples/ — completed reference examples
- tests/ — test scenarios for OS regression checks

### Removed
- Refine Flow branding (now brand-agnostic template)

---

## How to update

When you change the template:
1. Update VERSION (semver)
2. Add an entry to this CHANGELOG.md with the version bump
3. The onboarder will write the new version into each new client repo's `company/_config.md`