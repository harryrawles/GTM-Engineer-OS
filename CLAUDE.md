# CLAUDE.md — GTM Engineer OS (Multi-Client)

## What This Is

The operating system for running **multiple Instantly GTM clients** (target: up to ~30) from a single
private repo. It combines a shared brain — skills, knowledge, frameworks, SOPs, best practices, templates —
with fully isolated per-client context.

**Managed by:** Harry Rawles — GTM Engineer.
**Design:** one shared layer, many isolated clients, one active client per session.

If this repo was just created from the old single-client OS, run the **One-Time Build-Out** (bottom of this
file) before anything else.

Core principles (carried over, unchanged):
- **PRR is the north star.** Positive reply rate drives every copy decision. Opens are vanity.
- **Compound, don't improvise.** Every winner and every test is logged with the *why*.
- **Signal-based, not spray-and-pray.** Only contact prospects showing intent.
- **Match the register.** ATL (VP/C-level) = short strategic. BTL (managers/ICs) = operational.

---

## Golden Rules (apply every session)

1. **Resolve the ACTIVE CLIENT before any client-specific work.** Never act on a client without one.
2. **Full client isolation.** Never read, reuse, reference, or carry over one client's data, copy, ICP, or
   context into another. There is **no cross-client sharing, ever.**
3. **Never write copy from memory.** Load the active client's `copy-library.md` first, every time.
4. **Never commit secrets.** API keys live only in git-ignored per-client secrets files.
5. **Match the active client's voice** (`clients/{slug}/voice.md`). Default UK English if unspecified.

---

## The Active-Client Model

All client-specific work runs against exactly one active client.

**Set / switch the active client:**
- "switch to acme" / "start working on acme" → set active client to `acme`.
- Claude writes the slug to `_state/active-client` (git-ignored) and confirms: **"Active client: Acme."**
- **Inline override:** "write a cold email for acme [signal]" acts on `acme` for that request only, without
  changing the persisted active client.
- **Portfolio mode:** "for all clients" / "weekly review for all clients" → loop every folder in `clients/`,
  keeping each client's work fully isolated.

**At session start:** state the current active client (read from `_state/active-client`) and confirm before
doing client-specific work. If none is set and the task is client-specific, ask which client.

**Slugs:** lowercase-kebab. "Acme Corp" → `acme-corp`. One folder per client under `clients/`.

**Add a new client:** copy `templates/client-template/` → `clients/{slug}/`, then run `client-onboarder`.

---

## Repo Structure

```
gtm-engineer-os/
├── CLAUDE.md              # This file — the hub for Claude Code
├── README.md             # Human-facing intro
├── OPERATING-RHYTHM.md   # Daily / weekly / monthly / quarterly cadence
├── MCP-SETUP.md          # How to connect the Instantly MCP + per-client workspaces
├── CHANGELOG.md / VERSION / LICENSE / .gitignore
│
├── clients/              # One isolated folder per client (see below). Git-tracked EXCEPT secrets/.
│   └── {slug}/
│
├── _state/               # Local session state (git-ignored contents)
│   └── active-client     # Plain file holding the current client slug
│
│  ── SHARED LAYER (available to every client, like skills) ──
├── gtm-skills/           # Skills, chains, pattern-detector, skill-forge
├── wiki/                 # Knowledge base (copywriting, deliverability, signals, benchmarks…)
├── frameworks/           # Strategic frameworks & mental models
├── sops/                 # Standard operating procedures
├── best-practices/       # Best-practice references
├── templates/            # Reusable output templates + client-template/ skeleton
│
└── examples/ tests/ assets/ raw/ .github/   # Reference, regression, indexes, worksheets, issue templates
```

---

## Per-Client Folder — `clients/{slug}/`

Same context model as the old `company/` folder, now one per client:

```
clients/{slug}/
├── _config.md            # Central config for this client (slug, tier, template_version…)
├── overview.md           # Identity, SLA, success criteria
├── icp.md                # Target profile, signals
├── offer.md              # What they sell
├── voice.md              # Tone, banned words, spelling preference
├── campaign-state.md     # Live campaigns, infrastructure, tools
├── decision-log.md       # Why decisions were made
├── competitive-intel.md
├── comms-log.md          # Client communications
├── copy-library.md       # Top performers + graveyard (check before writing)
├── test-log.md           # Split-test history
├── MEMORY.md             # ALWAYS load first for the active client — focus, watch-outs, prefs
├── session-log.md        # Per-invocation log for THIS client (powers pattern-detector)
└── secrets/              # GIT-IGNORED — never committed
    └── credentials.md    # Instantly API key, workspace_id, workspace_url
```

---

## Shared Layer (universal — never client-specific)

`gtm-skills/`, `wiki/`, `frameworks/`, `sops/`, `best-practices/`, and `templates/` are accessible to every
client on the same footing as skills. Drop new files into any of them and reference by path — Claude
auto-discovers them. Nothing in these folders may contain a specific client's private data.

- **frameworks/** — strategic frameworks and mental models.
- **sops/** — step-by-step standard operating procedures.
- **best-practices/** — best-practice references and checklists.
- **templates/** — reusable output templates (emails, reports, QBRs) + the `client-template/` skeleton used
  to spin up new clients.

---

## Credentials & Instantly Access

- Each client has its **own Instantly workspace + API key**.
- Store per client in `clients/{slug}/secrets/credentials.md` (**git-ignored**):
  `instantly_api_key`, `workspace_id`, `workspace_url`.
- Only the shape is committed: `templates/client-template/secrets/credentials.template.md`.
- `.gitignore` MUST include: `clients/*/secrets/`, `**/.env`, `_state/active-client`.
- The **Instantly MCP** is connected in Claude Code. When a client is active, target **that client's**
  workspace (from its `secrets/`). State the workspace name and confirm before any Instantly action.
- **Never** print a full API key in chat. **Never** commit secrets. If any action would commit a secret,
  stop and warn immediately.

---

## Session Start Protocol

1. Read `_state/active-client`; state it. If none is set and the task is client-specific, ask which client.
2. Load `clients/{slug}/MEMORY.md` (active client) and `wiki/_skill-context.md`.
3. Invoke `gtm-skills/pattern-detector.md`: it reads the **active client's** `session-log.md`, proposes
   `skill-forge` on 3+ repeated intents, writes a session-log row, then hands off.
4. Route the request via the table below.

**Every skill writes its own session-log row at STEP 0**, into the **active client's** `session-log.md`.

---

## Behaviour Rules

- Direct, data-led, no fluff. Match the active client's `voice.md`.
- PRR is the primary KPI for all copy decisions.
- Never write from memory — check the active client's `copy-library.md` first.
- Short sentences, active voice, no unnecessary hedging. Numbers as digits (5, not five).
- Spelling per the client's `voice.md`; default UK English if unspecified.
- Never use: "leverage", "synergy", "game-changer", "revolutionary", "cutting-edge", "hope this helps".

---

## Safety Guard — blocked without explicit approval

1. Sending any external comms on behalf of a client.
2. Any change to a client's Instantly workspace (pausing, deleting, editing campaigns).
3. Sharing one client's data externally — or exposing one client's context to another.
4. Any financial operation (billing, refunds, invoices).
5. Auto-handling hostile replies, GDPR-flagged messages, or legal threats — always escalate.
6. Acting when the active client is ambiguous or unconfirmed.

**When blocked:** state exactly what you were about to do, name the client, ask for approval, wait.

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
| "forge it" / "create a skill that automates X" | `gtm-skills/skill-forge.md` |
| "Onboard new client" / "Set up client" | `gtm-skills/client-onboarder.md` |
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
| "Generate QBR for [client]" | `gtm-skills/qbr-writer.md` |
| "Offboard [client]" | `gtm-skills/client-offboarder.md` |
| (helper, invoked by other skills) | `gtm-skills/fresh-eyes-reviewer.md` |

---

## One-Time Build-Out (old single-client repo → this multi-client design)

Run this once when transitioning. Preserve all GTM skills and valuable content.

1. **Copy the shared layer unchanged** from the old repo: `gtm-skills/`, `wiki/`, `examples/`, `tests/`,
   `assets/`, `raw/`, `.github/`.
2. **Convert the old `company/` folder into `templates/client-template/`** — replace all real values with
   placeholders, keep the full file set, and add `secrets/credentials.template.md` (shape only).
3. **Create an empty `clients/`** (add `.gitkeep`). Real clients get created by copying the template.
4. **Create the new shared folders** `frameworks/`, `sops/`, `best-practices/`, `templates/` (add `.gitkeep`
   each; content is uploaded later).
5. **Create `_state/`** (add `.gitkeep`) and git-ignore `_state/active-client`.
6. **Update `.gitignore`** to include `clients/*/secrets/`, `**/.env`, `_state/active-client`.
7. **Remove single-client assumptions.** Anywhere the old OS hardcoded `{{CLIENT_NAME}}` or "this client
   only", switch to the active-client model. Make `session-log.md` and `pattern-detector` operate on
   `clients/{slug}/` rather than a single `company/`.
8. **Update the guides** (`README.md`, `OPERATING-RHYTHM.md`, `MCP-SETUP.md`, `BOOTSTRAP.md`) for multi-client
   flow: switching clients, adding a client, per-client Instantly workspaces.
9. **Verify:** no secrets are tracked by git; all shared folders exist; the routing table resolves; the
   `client-template/` produces a working client when copied.

---

## Source Knowledge

Primary methodology (copywriting principles, scientific method, offer framework) is the **source of truth**.
ColdIQ GTM material and any uploaded frameworks/SOPs/best-practices **extend** it — they never override it.
