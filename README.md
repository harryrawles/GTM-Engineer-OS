# GTM Client OS — {{CLIENT_NAME}}

This repository is the operating system for managing {{CLIENT_NAME}} as an Instantly.ai GTM Engineering account.

It contains everything needed for an AI assistant (Claude Code) to write copy, run campaigns, diagnose performance, and report to the client — using a consistent methodology grounded in proven cold email principles.

---

## What this is

A markdown-native OS combining:
- **Per-client context** — who they are, what they sell, who they target, how they talk (`company/`)
- **Knowledge base** — copywriting, signals, deliverability, frameworks (`wiki/`)
- **AI skills** — orchestrated workflows for repeatable tasks (`gtm-skills/`)
- **Examples and tests** — what good looks like (`examples/`, `tests/`)

Designed for one human (Harry) + Claude Code to run a client end-to-end.

---

## Quick start

**For a fresh client OS (first time):**
1. See [BOOTSTRAP.md](./BOOTSTRAP.md)
2. Run: `Run client onboarder for [client name]`
3. ~50 minutes of conversational setup
4. Ready to write copy

**For day-to-day operations:**
1. See [OPERATING-RHYTHM.md](./OPERATING-RHYTHM.md)
2. Daily: morning routine (10 min)
3. Friday: `Run weekly review for all clients`
4. Quarterly: `Generate QBR for [client]`

---

## File layout

```
├── README.md              # This file
├── BOOTSTRAP.md           # Setup entry point (delete after onboarding)
├── OPERATING-RHYTHM.md    # Daily/weekly/monthly cadence
├── MCP-SETUP.md           # How to connect MCPs
├── CHANGELOG.md           # Template version history
├── VERSION                # Semver
├── CLAUDE.md              # Hub for Claude — skill routing, rules
├── INDEX.md               # Content catalog
│
├── company/               # Per-client context (this client only)
│   ├── _config.md         # Central config — referenced by other files
│   ├── overview.md        # Identity, SLA, success criteria
│   ├── icp.md             # Target profile, signals
│   ├── offer.md           # What they sell
│   ├── voice.md           # Tone, banned words, spelling
│   ├── campaign-state.md  # Live campaigns, infrastructure, tools
│   ├── decision-log.md    # Why decisions were made
│   ├── competitive-intel.md
│   ├── comms-log.md       # Client communications
│   ├── copy-library.md    # Top performers + graveyard
│   └── test-log.md        # Split test history
│
├── wiki/                  # Shared knowledge — same across all clients
│   ├── _skill-context.md  # Standard skill preamble
│   ├── copywriting-101.md # Canonical rules + 4-part formula
│   ├── copywriting-frameworks.md
│   ├── offer-framework.md
│   ├── scientific-method.md
│   ├── signal-sourcing.md
│   ├── personalization-at-scale.md
│   ├── deliverability.md
│   ├── list-building.md
│   ├── atl-btl-messaging.md
│   ├── subject-lines.md
│   ├── psychological-principles.md
│   ├── buying-triggers.md
│   ├── email-benchmarks.md
│   ├── objection-library.md
│   ├── industry-vernacular.md
│   ├── glossary.md
│   └── diagrams.md
│
├── gtm-skills/            # AI skill definitions
│   ├── client-onboarder.md
│   ├── weekly-reviewer.md
│   ├── pre-launch-check.md
│   ├── cold-email-writer.md
│   ├── campaign-launcher.md
│   ├── campaign-optimiser.md
│   ├── reply-handler.md
│   ├── client-request-handler.md
│   ├── test-launcher.md
│   ├── client-health-scorer.md
│   ├── client-report-writer.md
│   ├── client-offboarder.md
│   ├── qbr-writer.md
│   ├── incident-responder.md
│   ├── signal-sourcer.md
│   ├── personalization-strategist.md
│   ├── list-builder.md
│   ├── deliverability-doctor.md
│   ├── campaign-analyst.md
│   └── icp-builder.md
│
├── examples/              # Reference examples (filled OS, sample reports)
├── tests/                 # Test scenarios for OS regression
├── raw/                   # Pre-call worksheets, call notes
├── assets/                # Index of external assets (case studies, decks)
└── .github/               # Issue templates
```

---

## Core concepts

### PRR is the north star
Positive reply rate (replies expressing interest, excluding negatives and OOOs). All copy decisions optimise for PRR. Open rate is vanity. Reply rate is noisy. PRR is signal.

### Compound, do not improvise
Every winning email gets logged with the why. Every test gets logged with the conclusion. The next email is built from prior winners, not from scratch. The OS compounds when [weekly-reviewer](gtm-skills/weekly-reviewer.md) runs every Friday.

### Signal-based, not spray-and-pray
Cold lists: 6-8% reply. Single-signal: 18-22%. Multi-signal: 35-40%. We only contact prospects showing buying intent. See `wiki/signal-sourcing.md`.

### Match the register
VPs and C-Level (ATL) get 2-3 sentence strategic emails. Managers and ICs (BTL) get 3-4 sentence operational emails. Wrong register = ignored. See `wiki/atl-btl-messaging.md`.

---

## Daily workflow

See [OPERATING-RHYTHM.md](./OPERATING-RHYTHM.md) for the full cadence.

**Most common commands:**

```
Run client onboarder for [new client]
Run weekly review for [client]
Run weekly review for all clients
Write a cold email for [client] [signal]
Diagnose [client] [campaign]
Handle this reply: [paste reply]
Run pre-launch check
```

---

## When something breaks

- **Deliverability issue (spam, bounces):** `Run deliverability doctor`
- **Campaign performance dropping:** `Run campaign optimiser`
- **Incident (blacklist, outage):** `Run incident responder`
- **Client asks for something mid-week:** `Handle client request: [paste]`

---

## OS version

See [VERSION](./VERSION) and [CHANGELOG.md](./CHANGELOG.md). This client repo was bootstrapped from template version [see company/_config.md → template_version].

---

## Maintenance

- **Per-client logs** (company/copy-library.md, test-log.md, decision-log.md) — updated automatically by weekly-reviewer
- **Shared wiki** (wiki/*.md) — updated when the template version is bumped
- **Template upgrades** — see CHANGELOG.md for migration notes

---

Built for Harry Rawles — GTM Engineer at Instantly.ai.