# CLAUDE.md — {{CLIENT_NAME}} | GTM Client OS

## What This Is

This is the GTM Client OS for **{{CLIENT_NAME}}**. It gives Claude full context to manage this account: who the client is, their ICP, offer, voice, signal strategy, and live campaign state.

**Managed by:** Harry Rawles — GTM Engineer at Instantly.ai
**Client:** {{CLIENT_NAME}}
**Industry:** {{INDUSTRY}}
**Instantly Workspace:** {{INSTANTLY_WORKSPACE_URL}}

---

## Client Identity

**Company:** {{CLIENT_NAME}}
**What they do:** {{ONE_LINE_DESCRIPTION}}
**Industry:** {{INDUSTRY}}
**Location / Primary markets:** {{GEOGRAPHY}}
**Why they hired Instantly.ai:** {{REASON_FOR_HIRING}}

### Key Contacts

| Name | Title | Email | Notes |
|------|-------|-------|-------|
| {{Name}} | {{Title}} | {{Email}} | Primary contact |

---

## Harry Role

GTM Engineer at Instantly.ai managing this account. Responsibilities:
- Build and manage email sequences in this client's Instantly workspace
- Source and qualify leads matching their ICP
- Write and optimise copy for performance (PRR is the primary KPI)
- Run split tests using the scientific method
- Send a weekly performance report to the client

---

## Behaviour Rules

- Direct, data-led, no fluff. Match the client's voice when writing on their behalf.
- Always load company context before taking any action. Read the relevant files before writing.
- PRR is the primary KPI for all copy decisions.
- Never write from memory. Check company/copy-library.md first, every time.
- **Spelling:** read company/voice.md for client preference. Default UK English if voice.md unspecified.
- No unnecessary hedging. Short sentences. Active voice.
- Numbers as digits (5 not five).
- Never use: "leverage", "synergy", "game-changer", "revolutionary", "cutting-edge", "hope this helps".

---

## Safety Guard

### Blocked without explicit approval:
1. Sending any external comms on behalf of the client
2. Making changes to the client's Instantly workspace (pausing, deleting, or editing campaigns)
3. Sharing campaign data or client information externally
4. Any financial operations

**When blocked:** State exactly what you were about to do, ask for explicit approval, wait before retrying.

---

## MCP Connections

| MCP | Purpose | Notes |
|-----|---------|-------|
| instantly | Campaign data, analytics, leads | Connect to this client's Instantly workspace specifically |
| notion | Client brief, notes, context | Harry Notion workspace |
| clay | Enrichment and signal detection (optional) | If used for this client |

---

## Skill Routing Table

| User Intent | Skill | Description |
|-------------|-------|-------------|
| "Onboard a new client" / "Set up the OS" | gtm-skills/client-onboarder.md | Conversational flow that fills all company/*.md files |
| "Run weekly review" / "Friday review" | gtm-skills/weekly-reviewer.md | Logs winners + losers, captures decision rationale, chains into report. **Run every Friday.** |
| "Write a cold email sequence" | gtm-skills/cold-email-writer.md | Emails using client offer, ICP, and voice |
| "Diagnose / optimise a campaign" | gtm-skills/campaign-optimiser.md | Diagnose underperformance, recommend fixes |
| "Design a signal-based campaign" | gtm-skills/signal-sourcer.md | Pick and score signals, design plays |
| "Personalise at scale" | gtm-skills/personalization-strategist.md | Buckets, hooks, AI prompts for Clay/Instantly |
| "Build / qualify a lead list" | gtm-skills/list-builder.md | ICP scoring, ABM tiers, contact mapping, validation |
| "Diagnose deliverability issue" | gtm-skills/deliverability-doctor.md | DNS, warmup, bounces, blacklist recovery |
| "Write the weekly report" | gtm-skills/client-report-writer.md | Client-facing performance update |
| "Build or refine the ICP" | gtm-skills/icp-builder.md | ICP filters and lead criteria |
| "Analyse campaign data" | gtm-skills/campaign-analyst.md | Performance analysis and strategic recommendations |
| "Update campaign state" | company/campaign-state.md | Edit directly — update what is live |
| "Log winning copy" | company/copy-library.md | Add top performer to archive |
| "Log a test result" | company/test-log.md | Record a completed split test |

---

## File Structure

```
client-os/
├── CLAUDE.md              # This file (the hub)
├── INDEX.md               # Content catalog
├── company/               # Client-specific context
│   ├── overview.md        # Who the client is and why they are here
│   ├── icp.md             # Who to target, signals, avoid list
│   ├── offer.md           # What they sell, proof points, differentiators
│   ├── voice.md           # How to write for this client
│   ├── campaign-state.md  # Live campaign status and infrastructure
│   └── decision-log.md    # WHY decisions were made (updated by weekly-reviewer)
├── wiki/                  # Knowledge base
│   ├── copywriting-101.md            # Canonical copywriting rules and 4-part formula
│   ├── copywriting-frameworks.md     # 13 named frameworks + ColdIQ playbook
│   ├── offer-framework.md            # 12-step offer building
│   ├── psychological-principles.md   # Cognitive biases for copy
│   ├── scientific-method.md          # Split test methodology
│   ├── signal-sourcing.md            # Signal strategy, scoring, plays
│   ├── buying-triggers.md            # 137-trigger taxonomy
│   ├── personalization-at-scale.md   # 6 buckets, hooks, AI prompts
│   ├── atl-btl-messaging.md          # Executive vs IC messaging
│   ├── deliverability.md             # Infrastructure, DNS, warmup
│   ├── subject-lines.md              # Subject line formulas + A/B testing
│   ├── list-building.md              # ICP scoring, ABM tiers, validation
│   ├── email-benchmarks.md           # Industry benchmarks
│   ├── copy-library.md               # This client winning copy + graveyard
│   └── test-log.md                   # Test history and roadmap
├── BOOTSTRAP.md           # Setup instructions (delete after onboarding)
├── gtm-skills/            # AI skill definitions
│   ├── client-onboarder.md     # RUN THIS FIRST on a fresh clone
│   ├── weekly-reviewer.md      # RUN EVERY FRIDAY — the compounding loop
│   ├── cold-email-writer.md
│   ├── campaign-optimiser.md
│   ├── signal-sourcer.md
│   ├── personalization-strategist.md
│   ├── list-builder.md
│   ├── deliverability-doctor.md
│   ├── client-report-writer.md
│   ├── icp-builder.md
│   └── campaign-analyst.md
└── raw/                   # Onboarding intake, call notes, briefs
    └── onboarding-intake.md
```

---

## Credentials

All API keys stored in 1Password. Never commit credentials to this repo.

| Service | Where | Notes |
|---------|-------|-------|
| Instantly (client workspace) | 1Password | Client-specific API key |
| Notion | 1Password | Harry personal token |

---

## Setup Checklist (complete on clone)

**Do not fill in files manually.** Run the onboarder:

```
Run client onboarder for {{CLIENT_NAME}}
```

Claude will ask questions in 5 phases (~50 minutes total) and write directly to:
- CLAUDE.md (placeholder replacement)
- company/overview.md
- company/offer.md
- company/icp.md
- company/voice.md
- company/campaign-state.md

See BOOTSTRAP.md for detail. The onboarder is resumable — pause and continue across sessions.

After onboarding:
- [ ] Connect Instantly MCP to this client's workspace
- [ ] Update INDEX.md with client name (the onboarder does this automatically)
- [ ] Delete BOOTSTRAP.md from the repo once setup is complete

---

## Source Knowledge

This OS combines two source libraries:
- **Primary methodology** — copywriting principles, scientific method, offer framework (curated by Harry)
- **ColdIQ GTM Skills** — signal sourcing, personalisation at scale, ATL/BTL, deliverability, frameworks library

Primary methodology is the source of truth. ColdIQ material extends it with deeper frameworks, signal taxonomy, and AI prompt libraries.