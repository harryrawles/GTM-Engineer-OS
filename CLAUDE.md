# CLAUDE.md — {{CLIENT_NAME}} | GTM Client OS

## What This Is

This is the GTM Client OS for **{{CLIENT_NAME}}**. It gives Claude full context to manage this account: who the client is, their ICP, offer, voice, and live campaign state.

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
- Never write from memory. Check wiki/copy-library.md first, every time.
- British spelling throughout.
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

---

## Skill Routing Table

| User Intent | Skill | Description |
|-------------|-------|-------------|
| "Write a cold email sequence" | gtm-skills/cold-email-writer.md | Emails using client offer, ICP, and voice |
| "Diagnose / optimise a campaign" | gtm-skills/campaign-optimiser.md | Diagnose underperformance, recommend fixes |
| "Write the weekly report" | gtm-skills/client-report-writer.md | Client-facing performance update |
| "Build or refine the ICP" | gtm-skills/icp-builder.md | ICP filters and lead criteria |
| "Analyse campaign data" | gtm-skills/campaign-analyst.md | Performance analysis and strategic recommendations |
| "Update campaign state" | company/campaign-state.md | Edit directly — update what is live |
| "Log winning copy" | wiki/copy-library.md | Add top performer to archive |
| "Log a test result" | wiki/test-log.md | Record a completed split test |

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
│   └── campaign-state.md  # Live campaign status and infrastructure
├── wiki/                  # Copywriting knowledge base
│   ├── copywriting-101.md
│   ├── offer-framework.md
│   ├── psychological-principles.md
│   ├── scientific-method.md
│   ├── copy-library.md    # This client winning copy and graveyard
│   └── test-log.md        # Test history and testing roadmap
├── gtm-skills/            # AI skill definitions
│   ├── cold-email-writer.md
│   ├── campaign-optimiser.md
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

- [ ] Replace all {{PLACEHOLDER}} values in CLAUDE.md
- [ ] Fill in company/overview.md from onboarding intake
- [ ] Fill in company/icp.md from onboarding intake
- [ ] Fill in company/offer.md from onboarding intake or offer-framework session
- [ ] Fill in company/voice.md from client brand guidelines or call notes
- [ ] Set up company/campaign-state.md once first campaigns are live
- [ ] Connect Instantly MCP to this client's workspace
- [ ] Update INDEX.md with client name