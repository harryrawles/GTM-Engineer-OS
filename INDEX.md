# Index — {{CLIENT_NAME}} | GTM Client OS

## Multi-Skill Chains (start here for common workflows)

| File | When to use |
|------|------------|
| gtm-skills/chain-build-campaign.md | "Build a campaign" — smart-routes through 4-7 skills with conditional skipping |
| gtm-skills/chain-diagnose-campaign.md | "Diagnose [campaign]" — primary diagnostic + routes to right specialist |
| gtm-skills/chain-weekly-review-full.md | "Friday review for [client]" — end-to-end weekly compounding loop |

## Quick Links

- **Setting up:** [BOOTSTRAP.md](./BOOTSTRAP.md)
- **Daily operations:** [OPERATING-RHYTHM.md](./OPERATING-RHYTHM.md)
- **MCP connections:** [MCP-SETUP.md](./MCP-SETUP.md)
- **Acronyms:** [wiki/glossary.md](./wiki/glossary.md)
- **Diagrams:** [wiki/diagrams.md](./wiki/diagrams.md)

## Per-Client Context

| File | What it contains |
|------|----------------|
| company/_config.md | Central config — referenced by other files |
| company/MEMORY.md | Always-loaded scratchpad — current focus, watch-outs, client preferences |
| company/session-log.md | Per-client invocation log. Powers pattern-detector. Auto-written by every skill. |
| company/overview.md | Identity, contract, SLA, success criteria |
| company/icp.md | Target ICP, signal priority, lead filters, avoid list, DM mapping |
| company/offer.md | What they sell, proof points, differentiators, approved claims |
| company/voice.md | Brand voice, tone rules, banned words, spelling default |
| company/campaign-state.md | Live campaigns, infrastructure, tools/tech stack |
| company/decision-log.md | Why decisions were made (updated by weekly-reviewer) |
| company/comms-log.md | Client communications log |
| company/competitive-intel.md | Competing offers, battle cards |
| company/copy-library.md | Top performers + graveyard for this client |
| company/test-log.md | Split test history |

## Shared Knowledge — Copywriting

| File | What it contains |
|------|----------------|
| wiki/_skill-context.md | Standard skill preamble (every skill loads this) |
| wiki/copywriting-101.md | Canonical rules + 4-part formula + sequence structure |
| wiki/copywriting-frameworks.md | 13 alternative named frameworks + ColdIQ playbook |
| wiki/offer-framework.md | 12-step offer building |
| wiki/psychological-principles.md | Cognitive biases for copy |
| wiki/scientific-method.md | Split test methodology |
| wiki/subject-lines.md | 4 subject line formulas + A/B testing |
| wiki/atl-btl-messaging.md | VP/C-Level vs Manager/IC messaging |
| wiki/objection-library.md | Top 15 objections with response templates |

## Shared Knowledge — Strategy and Sourcing

| File | What it contains |
|------|----------------|
| wiki/signal-sourcing.md | 6 core signals, scoring framework, 11 GTM plays |
| wiki/buying-triggers.md | 137-trigger taxonomy |
| wiki/list-building.md | ICP scoring (100-pt), ABM tiers, validation |
| wiki/personalization-at-scale.md | 6 buckets, hooks, AI prompts |
| wiki/industry-vernacular.md | Language guides per industry |
| wiki/inbound-orchestration.md | Detecting and activating inbound signals before cold outreach |

## Shared Knowledge — Operations and Reference

| File | What it contains |
|------|----------------|
| wiki/deliverability.md | DNS, warmup, infrastructure, recovery |
| wiki/email-benchmarks.md | Industry benchmarks |
| wiki/glossary.md | All acronyms defined |
| wiki/diagrams.md | Mermaid flowcharts of OS workflows |
| wiki/_subagent-patterns.md | When and how skills spawn isolated sub-agents |

## Skills — Setup and Cadence

| File | When to use |
|------|------------|
| gtm-skills/pattern-detector.md | **Runs FIRST every session.** Detects repeating prompts, proposes skill-forge. The auto-improvement loop. |
| gtm-skills/skill-forge.md | Triggered by "forge it" reply or direct call. Drafts new skills from detected patterns. |
| gtm-skills/client-onboarder.md | **Run first on a fresh clone.** Conversational OS setup. |
| gtm-skills/weekly-reviewer.md | **Run every Friday.** Compounding loop. |
| gtm-skills/client-health-scorer.md | Monday portfolio health check + at-risk flagging |
| gtm-skills/pre-launch-check.md | Gate against unresolved placeholders |
| gtm-skills/test-readiness-check.md | Pre-test gate — validates a Queued test against Step 1 of the scientific method before launching |

## Skills — Copy and Campaigns

| File | When to use |
|------|------------|
| gtm-skills/chain-build-campaign.md | **Use this for full-cycle campaign builds** — smart-routes through up to 7 skills |
| gtm-skills/chain-diagnose-campaign.md | **Use this for performance diagnostics** — routes to right specialist |
| gtm-skills/cold-email-writer.md | Writing new email sequences (invoked inside chain-build-campaign) |
| gtm-skills/campaign-launcher.md | Pre-flight checklist before launch (invoked inside chain-build-campaign) |
| gtm-skills/campaign-optimiser.md | Diagnose underperforming campaigns (invoked inside chain-diagnose-campaign) |
| gtm-skills/campaign-analyst.md | Performance analysis |
| gtm-skills/test-launcher.md | Fire the next queued split test (invoked inside chains) |

## Skills — Strategy and Sourcing

| File | When to use |
|------|------------|
| gtm-skills/signal-sourcer.md | Designing signal-based campaigns |
| gtm-skills/personalization-strategist.md | Personalisation at scale |
| gtm-skills/list-builder.md | ICP scoring, ABM tiers, list hygiene |
| gtm-skills/icp-builder.md | Building or refining ICP |

## Skills — Operations and Crises

| File | When to use |
|------|------------|
| gtm-skills/reply-handler.md | Routing inbound replies |
| gtm-skills/client-request-handler.md | Mid-week client requests |
| gtm-skills/deliverability-doctor.md | Diagnosing and recovering deliverability |
| gtm-skills/incident-responder.md | Critical incidents (blacklist, outage, breach) |
| gtm-skills/inbound-activator.md | Detect inbound signal → enrich → qualify → activate outbound |
| gtm-skills/fresh-eyes-reviewer.md | Spawn independent sub-agent for unbiased QA on any artefact |

## Skills — Reporting and Relationship

| File | When to use |
|------|------------|
| gtm-skills/client-report-writer.md | Weekly client performance reports |
| gtm-skills/qbr-writer.md | Quarterly Business Reviews |
| gtm-skills/client-offboarder.md | End-of-engagement workflow |

## Examples

| File | What it shows |
|------|--------------|
| examples/recruitcha-completed-os/ | Fully-filled OS as quality bar reference |
| examples/sample-weekly-review.md | What a Friday review session produces |
| examples/sample-client-report.md | What a sent weekly report looks like |
| examples/sample-decision-log-entries.md | What good decision log entries look like |

## Tests

| File | What it tests |
|------|--------------|
| tests/test-onboarding.md | Client onboarder flow |
| tests/test-cold-email-writer.md | Copy quality |

## Raw Inputs

| File | What it contains |
|------|----------------|
| raw/onboarding-intake.md | Pre-call client worksheet (sent before kickoff) |

## Assets

| File | What it contains |
|------|----------------|
| assets/README.md | Index of external assets (case studies, decks, etc.) |
