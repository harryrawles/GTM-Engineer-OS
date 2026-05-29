# CLAUDE.md — {{CLIENT_NAME}} | GTM Client OS

## What This Is

This is the GTM Client OS for **{{CLIENT_NAME}}**. It gives Claude full context to manage this account: who the client is, their ICP, offer, voice, signal strategy, live campaign state, communication history, and decision rationale.

**Managed by:** Harry Rawles — GTM Engineer at Instantly.ai
**Client:** {{CLIENT_NAME}}
**Template version:** see `VERSION` and `CHANGELOG.md`
**Central config:** `company/_config.md`

---

## Quick Reference

| What you want to do | How |
|---------------------|-----|
| Set up this OS for the first time | See `BOOTSTRAP.md` → `Run client onboarder` |
| Use this OS daily | See `OPERATING-RHYTHM.md` |
| Connect MCPs | See `MCP-SETUP.md` |
| Understand acronyms | See `wiki/glossary.md` |

---

## Behaviour Rules

- Direct, data-led, no fluff. Match the client's voice in `company/voice.md`.
- Always load context from `wiki/_skill-context.md` before acting.
- PRR is the primary KPI for all copy decisions.
- Never write from memory. Check `company/copy-library.md` first, every time.
- **Spelling:** read `company/voice.md` for client preference. Default UK English if voice.md unspecified.
- No unnecessary hedging. Short sentences. Active voice.
- Numbers as digits (5 not five).
- Never use: "leverage", "synergy", "game-changer", "revolutionary", "cutting-edge", "hope this helps".

---

## Safety Guard

### Blocked without explicit approval:
1. Sending any external comms on behalf of the client
2. Making changes to the client's Instantly workspace (pausing, deleting, editing campaigns)
3. Sharing campaign data or client information externally
4. Any financial operations (billing, refunds, invoices)
5. Auto-handling hostile replies, GDPR-flagged messages, or legal threats — always escalate

**When blocked:** state exactly what you were about to do, ask for explicit approval, wait before retrying.

---

## Skill Routing Table

### Setup and operating rhythm

| User intent | Skill | When |
|-------------|-------|------|
| "Onboard new client" / "Set up the OS" | gtm-skills/client-onboarder.md | First time on a fresh clone |
| "Run weekly review" / "Friday review" | gtm-skills/weekly-reviewer.md | **Every Friday** — compounding loop |
| "Score health" / "Portfolio health" | gtm-skills/client-health-scorer.md | Mondays + at risk-flag |
| "Run pre-launch check" | gtm-skills/pre-launch-check.md | Before any campaign goes live |

### Copy and campaigns

| User intent | Skill | When |
|-------------|-------|------|
| "Write a cold email sequence" | gtm-skills/cold-email-writer.md | New campaign or rewrite |
| "Launch the campaign" | gtm-skills/campaign-launcher.md | Pre-flight before going live |
| "Diagnose campaign" / "Why is PRR low" | gtm-skills/campaign-optimiser.md | Performance issue |
| "Analyse campaign data" | gtm-skills/campaign-analyst.md | Performance review |
| "Launch the next test" | gtm-skills/test-launcher.md | When testing roadmap has queued tests |

### Strategy and sourcing

| User intent | Skill | When |
|-------------|-------|------|
| "Design signal strategy" | gtm-skills/signal-sourcer.md | New client, or signal saturation |
| "Personalise at scale" | gtm-skills/personalization-strategist.md | High-tier prospect campaigns |
| "Build / qualify lead list" | gtm-skills/list-builder.md | New list or list quality issue |
| "Build or refine ICP" | gtm-skills/icp-builder.md | New client, or ICP drift |

### Operations and crises

| User intent | Skill | When |
|-------------|-------|------|
| "Handle this reply" | gtm-skills/reply-handler.md | Any inbound reply |
| "Handle client request" | gtm-skills/client-request-handler.md | Mid-week client ask |
| "Diagnose deliverability" | gtm-skills/deliverability-doctor.md | Bounces, spam, blacklists |
| "Incident" / "Domain blacklisted" / "Bounce spike" | gtm-skills/incident-responder.md | Critical/high severity issue |

### Reporting and relationship

| User intent | Skill | When |
|-------------|-------|------|
| "Write the weekly report" | gtm-skills/client-report-writer.md | Friday (chained from weekly-reviewer) |
| "Generate QBR for {{client}}" | gtm-skills/qbr-writer.md | Last week of each quarter |
| "Offboard {{client}}" | gtm-skills/client-offboarder.md | End of engagement |

---

## File Structure

```
client-os/
├── README.md              # Human-facing intro
├── BOOTSTRAP.md           # Setup entry point
├── OPERATING-RHYTHM.md    # Daily/weekly/monthly/quarterly cadence
├── MCP-SETUP.md           # MCP connection guide
├── CHANGELOG.md           # Template version history
├── VERSION                # Semver
├── LICENSE                # Usage rights
├── .gitignore             # Committed file hygiene
├── CLAUDE.md              # This file — hub for Claude
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
│   ├── copy-library.md    # Top performers + graveyard (moved from wiki/)
│   └── test-log.md        # Split test history (moved from wiki/)
│
├── wiki/                  # Shared knowledge — same across all clients
│   ├── _skill-context.md  # Standard skill preamble (every skill loads this)
│   ├── copywriting-101.md # Canonical rules + 4-part formula + sequence
│   ├── copywriting-frameworks.md
│   ├── offer-framework.md
│   ├── scientific-method.md
│   ├── signal-sourcing.md
│   ├── buying-triggers.md
│   ├── personalization-at-scale.md
│   ├── deliverability.md
│   ├── list-building.md
│   ├── atl-btl-messaging.md
│   ├── subject-lines.md
│   ├── psychological-principles.md
│   ├── objection-library.md
│   ├── industry-vernacular.md
│   ├── email-benchmarks.md
│   ├── glossary.md
│   └── diagrams.md
│
├── gtm-skills/            # AI skill definitions (frontmatter + content)
│   ├── client-onboarder.md         # RUN FIRST on a fresh clone
│   ├── weekly-reviewer.md          # RUN EVERY FRIDAY — compounding loop
│   ├── pre-launch-check.md         # Gate for placeholder validation
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
├── examples/              # Reference examples
│   ├── recruitcha-completed-os/   # Fully-filled OS as quality bar
│   ├── sample-weekly-review.md    # What a Friday review looks like
│   ├── sample-client-report.md    # What a weekly report looks like
│   └── sample-decision-log-entries.md
│
├── tests/                 # OS regression tests
│   ├── README.md
│   ├── test-onboarding.md
│   └── test-cold-email-writer.md
│
├── raw/                   # Pre-call worksheets, call notes
│   └── onboarding-intake.md       # Pre-call client worksheet
│
├── assets/                # Index of external assets (case studies, decks)
│   └── README.md
│
└── .github/
    └── ISSUE_TEMPLATE/    # Issue templates for tracking
        ├── client-request.md
        ├── campaign-launch.md
        ├── incident.md
        └── optimization-test.md
```

---

## Credentials

All API keys in 1Password. Never commit credentials.

See `MCP-SETUP.md` for connection details.

---

## Source Knowledge

This OS combines:
- **Primary methodology** — copywriting principles, scientific method, offer framework (curated by Harry)
- **ColdIQ GTM Skills** — signal sourcing, personalisation at scale, ATL/BTL, deliverability, frameworks library

Primary methodology is the source of truth. ColdIQ material extends it.