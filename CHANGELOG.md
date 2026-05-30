# Changelog

All notable changes to the GTM Client OS template.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and uses semantic versioning.

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

## [1.2.0] — 2026-05-30

### Added — Cognitive bias system for copywriting
- `wiki/psychological-principles.md` — full rewrite. 55+ foundational cognitive biases (each with cold-outreach examples) + 32 Morgan's Heuristics (practitioner observations) + `Biases by Copy Stage` quick-reference table mapping each part of the email (Subject, Part 1-4, Follow-ups, Objection handling, Re-engagement) to which biases to leverage and which to avoid + Overdone-It bias warning to prevent over-application.
- `wiki/copywriting-101.md` — each Part of the 4-part formula now lists biases to leverage and biases to avoid. Added `Bias Application` section explaining the 3-5 biases per email rule.
- `gtm-skills/cold-email-writer.md` — added **Step 7 — Map biases per part of the formula** in pre-write protocol. Forces explicit bias planning before writing.
- `wiki/objection-library.md` — all 14 objection response templates annotated with the biases each leverages. Pattern: shows WHY each response works, not just the script.
- `gtm-skills/reply-handler.md` — Step 2G (objection routing) now references the bias-annotated objection-library and includes a bias check before sending.

### Added — Scientific method iteration framework
- `wiki/scientific-method.md` — canonical rewrite. Genotype/fitness terminology, Polaris (secondary metric upstream of primary), full 4-step framework (Formulate → Test → Observe → Iterate), explicit modification levels (Slight/Moderate/Complete) tied to KPI distance, 5-question success determination tree, `Managing Future Experiments` regression check, 10 common failure modes documented.
- `company/test-log.md` — full template restructure. Every test entry now forces explicit Step 1 fields: genotype (V-numbered variables), primary + secondary KPIs with target values, sample size, latency window, airtight check (5-item checklist), variant configuration with V-numbers, constants (locked during run), stop conditions, backtrack plan. Completed tests must capture Step 3 (six-rule check + verified data + 5-question tree) and Step 4 (iteration decision). New `Reverted Tests` section.
- `gtm-skills/test-readiness-check.md` (new skill) — pre-test gate mirroring pre-launch-check. Validates a Queued test in test-log against all Step 1 sub-steps + stop conditions + backtrack plan. Returns READY / READY WITH WARNINGS / NOT READY. Blocks test-launcher if NOT READY.
- `gtm-skills/test-launcher.md` — added mandatory **Step 0** invoking test-readiness-check before any test launches. Updated Step 5 to mark campaign as `TEST ACTIVE — T-{{ID}} testing {{variable}}. Constants LOCKED.` in campaign-state.md (the trigger for strict-block guards).
- `gtm-skills/weekly-reviewer.md` — Step 5 expanded with six-rule completion check, 5-question success tree, regression check (`Managing Future Experiments` rule from scientific-method.md), and active-test awareness (skip variant analysis if not at sample / latency yet).
- `gtm-skills/cold-email-writer.md`, `gtm-skills/client-request-handler.md`, `gtm-skills/campaign-optimiser.md` — all three now include the **Active-Test Strict Block** section. Skills refuse to modify constants of a campaign with TEST ACTIVE flag. Operator override available with explicit `Override active test T-{{ID}}` command, which moves test to Reverted, logs to decision-log, and removes the flag.

### Why this matters

The bias system makes copywriting deliberate, not intuitive — every email has 3-5 biases consciously leveraged for the specific signal x persona x offer combination. The scientific method enforcement (test-readiness-check + strict-block guards) makes iteration compound — without Ceteris Paribus enforcement, mid-test changes silently invalidate data and the OS stops learning. With both: copy is psychologically calibrated AND test results are trustworthy.

### Source material

- Cognitive Bias Codex (Wikimedia Commons) + Morgan's Heuristics (Harry's practitioner observations from ~1,000 client signings)
- Scientific method content from Harry's iteration process documentation
- Cross-references added to all related skills

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
