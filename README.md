# GTM Engineer OS - Multi-Client

The operating system for running **multiple Instantly.ai GTM clients** (target: up to ~30) from a single
private repo. One shared brain - skills, knowledge, frameworks, SOPs, templates - plus a fully isolated
context folder per client. One active client per session.

It gives Claude Code everything it needs to write copy, run campaigns, diagnose performance, and report -
per client - using a consistent methodology grounded in proven cold email principles.

> **The hub is [CLAUDE.md](./CLAUDE.md).** It holds the golden rules, the active-client model, the safety
> guard, and the skill routing table. Read it first.

---

## What this is

A markdown-native OS combining:
- **Isolated per-client context** - who they are, what they sell, who they target, how they talk
  (`clients/{slug}/`)
- **Shared knowledge base** - copywriting, signals, deliverability, frameworks (`wiki/`)
- **Shared frameworks / SOPs / best-practices** - strategy and runbooks (`frameworks/`, `sops/`,
  `best-practices/`)
- **AI skills** - orchestrated workflows for repeatable tasks (`gtm-skills/`)
- **Client template** - the skeleton every new client is spun up from (`templates/client-template/`)

Designed for one human (Harry) + Claude Code to run a whole portfolio, with **no cross-client data
sharing, ever.**

---

## The active-client model (the one thing to understand)

All client-specific work runs against exactly **one active client**.

- **Switch client:** "switch to acme" → writes the slug to `_state/active-client` (git-ignored). Claude
  confirms "Active client: Acme."
- **Inline override:** "write a cold email for acme [signal]" acts on `acme` for that one request without
  changing the persisted active client.
- **Portfolio mode:** "for all clients" loops every folder in `clients/`, fully isolated.

At session start Claude states the current active client. If none is set and the task is client-specific,
it asks. See [CLAUDE.md](./CLAUDE.md) → *The Active-Client Model*.

---

## Quick start

**Add a new client:**
1. See [BOOTSTRAP.md](./BOOTSTRAP.md)
2. Run: `Onboard new client [client name]` - the onboarder copies `templates/client-template/` →
   `clients/{slug}/`, sets it active, and walks you through ~50 min of conversational setup.

**Day-to-day operations:**
1. See [OPERATING-RHYTHM.md](./OPERATING-RHYTHM.md)
2. Set the active client: `switch to [client]`
3. Daily: morning routine (10 min) · Friday: `Run weekly review for all clients` · Quarterly:
   `Generate QBR for [client]`

**Connect Instantly (per client):** see [MCP-SETUP.md](./MCP-SETUP.md).

---

## File layout

```
├── CLAUDE.md              # Hub for Claude - active-client model, rules, skill routing
├── README.md              # This file
├── BOOTSTRAP.md           # How to add and set up a new client
├── OPERATING-RHYTHM.md    # Daily/weekly/monthly/quarterly cadence
├── MCP-SETUP.md           # Instantly API (per-client key) + optional MCPs
├── HOOKS-SETUP.md         # Lifecycle hooks + /gtm:compound command
├── INDEX.md               # Content catalog
├── CHANGELOG.md / VERSION # Template version history
│
├── clients/               # One ISOLATED folder per client (git-tracked EXCEPT secrets/)
│   └── {slug}/            # Created by copying templates/client-template/
│       ├── _config.md         # Central config (slug, tier, industry, Instantly workspace…)
│       ├── MEMORY.md          # Always-loaded scratchpad - current focus, watch-outs
│       ├── overview.md        # Identity, SLA, success criteria
│       ├── icp.md · offer.md · voice.md
│       ├── campaign-state.md · decision-log.md · competitive-intel.md
│       ├── comms-log.md · copy-library.md · test-log.md · session-log.md
│       └── secrets/           # GIT-IGNORED - instantly_api_key, workspace_id/url
│
├── _state/                # Local session state (git-ignored)
│   └── active-client      # Plain file holding the current client slug
│
│  ── SHARED LAYER (available to every client) ──
├── gtm-skills/            # Skill + chain definitions, pattern-detector, skill-forge
├── wiki/                  # Shared knowledge base (copywriting, deliverability, signals…)
├── frameworks/            # Strategic frameworks & mental models (uploaded later)
├── sops/                  # Standard operating procedures (uploaded later)
├── best-practices/        # Best-practice references & checklists (uploaded later)
├── templates/             # Reusable output templates + client-template/ skeleton
│
└── examples/ · tests/ · raw/ · assets/ · .github/   # Reference, regression, worksheets, indexes
```

---

## Core concepts

### PRR is the north star
Positive reply rate (replies expressing interest, excluding negatives and OOOs). All copy decisions
optimise for PRR. Open rate is vanity. Reply rate is noisy. PRR is signal.

### Compound, do not improvise
Every winning email gets logged with the why. Every test gets logged with the conclusion. The next email
is built from prior winners, not from scratch. The OS compounds when
[weekly-reviewer](gtm-skills/weekly-reviewer.md) runs every Friday - per client.

### Signal-based, not spray-and-pray
Cold lists: 6-8% reply. Single-signal: 18-22%. Multi-signal: 35-40%. We only contact prospects showing
buying intent. See `wiki/signal-sourcing.md`.

### Match the register
VPs and C-Level (ATL) get 2-3 sentence strategic emails. Managers and ICs (BTL) get 3-4 sentence
operational emails. Wrong register = ignored. See `wiki/atl-btl-messaging.md`.

### Full client isolation
Never read, reuse, or carry over one client's data, copy, ICP, or context into another. Each client has
its own Instantly workspace + API key. See [CLAUDE.md](./CLAUDE.md) → *Golden Rules*.

---

## Most common commands

```
Onboard new client [name]
switch to [client]
Run weekly review for all clients
Run weekly review for [client]
Write a cold email for [client] [signal]
Diagnose [client] [campaign]
Handle this reply: [paste reply]
Run pre-launch check
Generate QBR for [client]
```

---

## When something breaks

- **Deliverability issue (spam, bounces):** `Run deliverability doctor`
- **Campaign performance dropping:** `Run campaign optimiser`
- **Incident (blacklist, outage):** `Run incident responder`
- **Client asks for something mid-week:** `Handle client request: [paste]`

(All act on the active client - confirm it first.)

---

## Maintenance

- **Per-client logs** (`clients/{slug}/copy-library.md`, `test-log.md`, `decision-log.md`) - updated
  automatically by weekly-reviewer, per client.
- **Shared layer** (`wiki/`, `frameworks/`, `sops/`, `best-practices/`, `gtm-skills/`) - universal; updated
  when the template version is bumped or new shared content is uploaded.
- **Template upgrades** - see [CHANGELOG.md](./CHANGELOG.md) for migration notes.

## OS version

See [VERSION](./VERSION) and [CHANGELOG.md](./CHANGELOG.md). Each client records the template version it was
spun up from in `clients/{slug}/_config.md → template_version`.

---

Built for Harry Rawles - GTM Engineer.
