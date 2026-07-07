# CLAUDE.md — GTM Engineer OS (Multi-Client, Self-Improving)

## What This Is

A **living** operating system for running multiple Instantly GTM clients (target: ~30) from one private
repo. A shared brain — skills, knowledge, frameworks, playbooks, best practices, templates — serves every
client, while each client's own context and data stay fully isolated.

**Managed by:** Harry Rawles — GTM Engineer.

This file is both the hub and the spec: it defines exactly how the OS must behave. **If the repo and this
file ever disagree, this file is correct and the repo should be fixed to match it.**

---

## What This OS Must Do (design targets)

1. **Scale effortlessly.** Support ~30 clients with no structural change. Adding a client is a single action:
   copy `templates/client-template/` → `clients/{slug}/` and onboard. Nothing else in the repo changes.
2. **Link everything together.** Any task pulls *all* relevant context — the client's own files plus the
   right skills, playbooks, frameworks, wiki pages, and best practices — before a decision is made.
3. **Compound, never restart.** Every winner, test, and decision is logged with its reasoning and reused.
   New work is built from prior work, never from scratch.
4. **Auto-improve.** The OS detects patterns across its own usage and feeds generalizable learnings back
   into the shared brain, so the whole system gets better for every client over time.
5. **Stay isolated.** No client's data, copy, ICP, or identity ever reaches another client.

---

## Core Principles

- **PRR is the north star.** Positive reply rate drives every copy decision. Opens are vanity.
- **Compound, don't improvise.** Reuse proven winners; log the *why* every time.
- **Signal-based, not spray-and-pray.** Only contact prospects showing intent.
- **Match the register.** ATL (VP/C-level) = short strategic. BTL (managers/ICs) = operational.

---

## Golden Rules (apply every session)

1. **Resolve the ACTIVE CLIENT** before any client-specific work.
2. **Full isolation.** Never cross a client boundary with data, copy, ICP, or identity. No exceptions.
3. **Never produce from memory.** Assemble context first (see "How Claude Assembles Context").
4. **Never commit secrets.** Keys live only in git-ignored per-client secrets files.
5. **Match the active client's voice** (`clients/{slug}/voice.md`). Default UK English if unspecified.
6. **Prefer what already exists.** Check the client's `copy-library.md`, past tests, the wiki, and playbooks
   before creating anything new.

---

## The Active-Client Model

All client-specific work runs against exactly one active client.

- "switch to acme" / "start working on acme" → set active client to `acme`; write the slug to
  `_state/active-client` (git-ignored) and confirm: **"Active client: Acme."**
- **Inline override:** "write a cold email for acme [signal]" acts on `acme` for that request only.
- **Portfolio mode:** "for all clients" loops every folder in `clients/`, keeping each isolated.
- **At session start:** state the current active client and confirm before client-specific work.
- **Slugs:** lowercase-kebab ("Acme Corp" → `acme-corp`). One folder per client under `clients/`.
- **Add a client:** copy `templates/client-template/` → `clients/{slug}/`, then run `client-onboarder`.

---

## How Claude Assembles Context (read before deciding)

For any client task, before producing or deciding, load in this order and **synthesize across all of it**:

1. **Active client** — `MEMORY.md` first, then the files the task needs (`voice`, `icp`, `offer`,
   `campaign-state`, `copy-library`, `test-log`, `decision-log`).
2. **Shared method** — `wiki/_skill-context.md`, plus the relevant `wiki/` pages, the frameworks indexed
   in `frameworks/README.md`, `best-practices/` (including playbooks), and any `sops/` that exist.
3. **The skill or chain** — the matching `gtm-skills/` entry from the routing table.

Never act on a partial read. **Example — "launch a campaign for Acme":** pull Acme's `icp`/`offer`/`voice`/
`copy-library`, the relevant campaign playbook, the applicable frameworks, and the
`cold-email-writer`/`campaign-launcher` skills, then decide. Everything must link — if a needed reference
can't be found, say so rather than guessing.

---

## The Compounding Loop (the OS as a living organism)

The OS must get measurably better every session. Compounding happens on two layers:

- **Per-client (isolated):** every winning email → `copy-library.md` with the *why*; every test →
  `test-log.md` with the conclusion; every material choice → `decision-log.md`. This stays inside the
  client folder and is reused for that client only.
- **System-wide (shared):** `pattern-detector` watches invocations and, on repeated workflows, proposes
  `skill-forge` to mint a new skill. The `weekly-reviewer` promotes **abstracted, anonymised** insights —
  generalizable principles only, never a client's identity or raw copy — up into `wiki/`, `frameworks/`,
  and `best-practices/`. This is how a lesson learned on one client improves the OS for *all* of them.

**Promotion rule:** only de-identified methodology moves up. Raw client data never leaves the client
folder. When in doubt, keep it in the client folder.

---

## Repo Structure

```
gtm-engineer-os/
├── CLAUDE.md              # This file — hub + spec (source of truth)
├── README.md             # Human-facing intro
├── OPERATING-RHYTHM.md   # Full daily / weekly / quarterly cadence
├── MCP-SETUP.md          # Instantly API (per-client key) + optional MCPs
├── BOOTSTRAP.md          # How to add a new client
├── HOOKS-SETUP.md        # Claude Code hooks + /gtm:compound setup
├── INDEX.md              # Map of the entire OS — must stay current
├── CHANGELOG.md / VERSION / LICENSE / .gitignore
│
├── clients/              # One isolated folder per client. Tracked EXCEPT secrets/.
│   └── {slug}/
│
├── _state/               # Local session state (contents git-ignored)
│   └── active-client     # Plain file holding the current client slug
│
│  ── SHARED BRAIN (serves every client, like skills) ──
├── gtm-skills/           # Skills, chains, pattern-detector, skill-forge
├── wiki/                 # Knowledge base + destination for promoted learnings
├── frameworks/           # Strategic frameworks & mental models
├── best-practices/       # Best-practice references
│   └── playbooks/        # Operating playbooks (uploaded)
├── sops/                 # Standard operating procedures (filled over time)
├── templates/            # Reusable outputs + client-template/ skeleton
│
├── .claude/              # Claude Code config — hooks (safety-guard, session-logger,
│                         #   notify, session-start-context), bin/instantly.sh (Instantly
│                         #   API wrapper), settings.json, commands/
└── examples/ tests/ assets/ raw/ .github/
```

---

## Per-Client Folder — `clients/{slug}/`

```
clients/{slug}/
├── _config.md            # Client config (slug, template_version, etc.)
├── overview.md           # Identity, SLA, success criteria
├── icp.md                # Target profile, signals
├── offer.md              # What they sell
├── voice.md              # Tone, banned words, spelling
├── campaign-state.md     # Live campaigns, infrastructure, tools
├── decision-log.md       # Why decisions were made
├── competitive-intel.md
├── comms-log.md          # Client communications
├── copy-library.md       # Top performers + graveyard (check before writing)
├── test-log.md           # Split-test history
├── MEMORY.md             # ALWAYS load first — focus, watch-outs, prefs
├── session-log.md        # Per-invocation log (powers pattern-detector)
└── secrets/              # GIT-IGNORED — Instantly API key, workspace_id, workspace_url
    └── credentials.md
```

---

## Shared Brain (universal — never client-specific)

- **gtm-skills/** — skills, chains, `pattern-detector`, `skill-forge`.
- **wiki/** — knowledge base and the destination for promoted, anonymised learnings.
- **frameworks/** — strategic frameworks and mental models.
- **best-practices/** — best-practice references, including **best-practices/playbooks/**.
- **sops/** — standard operating procedures (filled over time).
- **templates/** — reusable outputs plus the `client-template/` skeleton for new clients.

Drop files into any of these and Claude auto-discovers them — reference by path. Nothing here may contain a
specific client's private data. `INDEX.md` maps the whole OS and must be kept current.

---

## Credentials & Instantly Access

- Each client has its own Instantly workspace + API key, stored in
  `clients/{slug}/secrets/credentials.md` (**git-ignored**).
- Only the shape is committed: `templates/client-template/secrets/credentials.template.md`.
- `.gitignore` MUST include: `clients/*/secrets/`, `**/.env`, `_state/active-client`.
- **The OS calls the Instantly API v2 directly, per client — no MCP server.** All access goes through
  `.claude/bin/instantly.sh [--client SLUG] METHOD PATH [BODY]`, which loads **only the active client's**
  key (or the inline `--client` override) and calls `https://api.instantly.ai/api/v2`. The key is read
  inside the wrapper and never appears in argv, the process list, chat, or the session logs. `switch to
  {client}` switches which key is used. Full reference: `sops/instantly-api.md`.
- **Reads are automatic.** `GET` calls (analytics, campaign status, reply data) — and the read-only
  `POST /leads/list` — run without asking, for the active client's workspace only.
- **Writes are gated.** Any `POST`/`PATCH`/`PUT`/`DELETE` (pausing, editing, deleting, launching,
  sending) requires explicit approval first — state the action and the workspace, then wait. (Enforced
  defensively by `.claude/hooks/safety-guard.sh`, which gates the wrapper by HTTP verb and blocks raw
  `curl` to the API; the model must still gate writes regardless.)
- Never print a full API key in chat. Never commit secrets. If any action would commit or display one,
  stop and warn.

---

## Session Start Protocol

1. Read `_state/active-client`; state it. If none is set and the task is client-specific, ask which client.
2. Load the active client's `MEMORY.md` and `wiki/_skill-context.md`.
3. Invoke `gtm-skills/pattern-detector.md`: reads the active client's `session-log.md`, surfaces a soft
   note at 3+ repeated intents and proposes `skill-forge` at 5+, writes a session-log row, then hands off.
4. Assemble context (see above), then route the request via the table.

**Every skill writes its own session-log row at STEP 0**, into the active client's `session-log.md`. A
deterministic hook (`.claude/hooks/session-logger.sh`) also appends a `via:hook` backstop row per prompt so
the loop keeps a signal even if a skill forgets; `pattern-detector` dedupes the two.

---

## Behaviour Rules

- Direct, data-led, no fluff. Match the active client's `voice.md`.
- PRR is the primary KPI for all copy decisions.
- Never write from memory — check the active client's `copy-library.md` first.
- Short sentences, active voice, no unnecessary hedging. Numbers as digits (5, not five).
- Never use: "leverage", "synergy", "game-changer", "revolutionary", "cutting-edge", "hope this helps".

---

## Safety Guard — blocked without explicit approval

1. Sending any external comms on behalf of a client.
2. Any change to a client's Instantly workspace (pausing, deleting, editing, launching, sending).
3. Sharing one client's data externally — or exposing one client's context to another.
4. Any financial operation (billing, refunds, invoices).
5. Auto-handling hostile replies, GDPR-flagged messages, or legal threats — always escalate.
6. Acting when the active client is ambiguous or unconfirmed.

**When blocked:** state exactly what you were about to do, name the client/workspace, ask, wait.

---

## Skill Routing Table

**Chains (preferred entry points):**

| User intent | Chain |
| --- | --- |
| "Build a campaign" / "Build [client] [signal] campaign" | `gtm-skills/chain-build-campaign.md` |
| "Diagnose [campaign]" / "Why is [campaign] underperforming" | `gtm-skills/chain-diagnose-campaign.md` |
| "Friday review" / "Weekly review for [client\|all clients]" | `gtm-skills/chain-weekly-review-full.md` |

**Individual skills:**

| User intent | Skill |
| --- | --- |
| (automatic, every session) | `gtm-skills/pattern-detector.md` |
| "forge it" / "automate this workflow" | `gtm-skills/skill-forge.md` |
| "Onboard new client" | `gtm-skills/client-onboarder.md` |
| "Run weekly review" (deep skill) | `gtm-skills/weekly-reviewer.md` |
| "Score health" / "Portfolio health" | `gtm-skills/client-health-scorer.md` |
| "Run pre-launch check" | `gtm-skills/pre-launch-check.md` |
| "Test-readiness check on T-XXX" | `gtm-skills/test-readiness-check.md` |
| "Write a cold email sequence" | `gtm-skills/cold-email-writer.md` |
| "Launch the campaign" | `gtm-skills/campaign-launcher.md` |
| "Diagnose campaign" / "Why is PRR low" | `gtm-skills/campaign-optimiser.md` |
| "Analyse campaign data" | `gtm-skills/campaign-analyst.md` |
| "Launch the next test" | `gtm-skills/test-launcher.md` |
| "Design signal strategy" | `gtm-skills/signal-sourcer.md` |
| "Personalise at scale" | `gtm-skills/personalization-strategist.md` |
| "Build / qualify lead list" | `gtm-skills/list-builder.md` |
| "Build or refine ICP" | `gtm-skills/icp-builder.md` |
| "Handle this reply" | `gtm-skills/reply-handler.md` |
| "Inbound signal: [X]" | `gtm-skills/inbound-activator.md` |
| "Handle client request" | `gtm-skills/client-request-handler.md` |
| "Diagnose deliverability" | `gtm-skills/deliverability-doctor.md` |
| "Incident" / "Blacklisted" / "Bounce spike" | `gtm-skills/incident-responder.md` |
| "Write the weekly report" | `gtm-skills/client-report-writer.md` |
| "EOD report" / "Wrap up my day" / "Close out the day" | `gtm-skills/eod-report-writer.md` |
| "Generate QBR for [client]" | `gtm-skills/qbr-writer.md` |
| "Offboard [client]" | `gtm-skills/client-offboarder.md` |
| (helper, invoked by other skills) | `gtm-skills/fresh-eyes-reviewer.md` |

---

## Operating Rhythm

Full cadence lives in `OPERATING-RHYTHM.md`. The compounding loop depends on the recurring beats: a daily
quick review, the **Friday `weekly-reviewer`** (the main compounding event, where learnings get promoted),
and quarterly QBRs. Most common commands:

```
switch to [client]              add new client [name]
write a cold email for [client] [signal]     diagnose [client] [campaign]
weekly review for [client | all clients]     handle this reply: [paste]
generate QBR for [client]
```

---

## Source Knowledge

Primary methodology (copywriting principles, scientific method, offer framework) is the **source of truth**.
ColdIQ material and any uploaded playbooks, frameworks, and SOPs **extend** it — they never override it.
