# BOOTSTRAP - Add a New Client

This is the multi-client GTM Engineer OS. The shared layer (skills, wiki, frameworks, SOPs, templates) is
always in place. To bring on a new client you spin up an isolated `clients/{slug}/` folder from the
template - **do not edit files manually**. Run the onboarder.

## Single Command

Open this repo in Claude Code and say:

```
Onboard new client {{client_name}}
```

The onboarder will:
1. Derive the slug (lowercase-kebab, e.g. "Acme Corp" → `acme-corp`).
2. Copy `templates/client-template/` → `clients/{slug}/` (full file set, including
   `secrets/credentials.template.md`).
3. Create the git-ignored `clients/{slug}/secrets/credentials.md` for the real Instantly key.
4. Set the active client (`_state/active-client`) and confirm "Active client: {Name}."
5. Walk you through 5 phases of questions, writing answers straight into that client's files.

The conversation IS the intake - no form to fill in.

## The 5 Phases

| Phase | Duration | Writes to |
|-------|----------|-----------|
| 1 - Identity | 5 min | `clients/{slug}/overview.md`, `clients/{slug}/_config.md` |
| 2 - Offer | 15 min | `clients/{slug}/offer.md` |
| 3 - ICP | 15 min | `clients/{slug}/icp.md` |
| 4 - Voice | 10 min | `clients/{slug}/voice.md` |
| 5 - Infrastructure | 5 min | `clients/{slug}/campaign-state.md`, `_config.md`, `secrets/credentials.md` |

**Total: ~50 minutes** for a full client setup.

You can pause between phases. The onboarder detects the client's current state on the next session and
resumes from where you left off.

> **Never touch the root `CLAUDE.md` or `INDEX.md` during onboarding** - they are the shared,
> client-agnostic hub and content catalog. All client answers live under `clients/{slug}/`.

## What You Need Before Starting

Have ready (or know who to ask):
- Client website and contact details
- Their offer / pricing / case studies
- Who they target (ICP) and what signals indicate buying intent
- Tone of voice samples (a piece of their content, an email they like)
- This client's own Instantly workspace details (API key, workspace URL/ID, domains, mailboxes, warmup) -
  the AM provisions these on a separate track (`sops/am-gtme-responsibility-split.md`); get the resulting
  details from them rather than setting infrastructure up yourself

If you do not have an answer for something, the onboarder will mark it `{{TO CONFIRM}}` and surface it at
the end. No question stalls the flow.

## After Onboarding

With the client active, you can run:
- `gtm-skills/signal-sourcer.md` - design the signal strategy
- `gtm-skills/list-builder.md` - source and qualify the first lead list
- `gtm-skills/cold-email-writer.md` - write the first sequence

Connect this client's Instantly workspace via [MCP-SETUP.md](./MCP-SETUP.md).

## Re-Onboarding an Existing Client

If a client is already set up but needs an update (ICP shifted, offer changed, new voice guidance), make
them active and say:

```
Re-onboard {{client_name}} - update ICP only
```

The onboarder runs only the relevant phase(s).

## Switching Between Clients

Day to day, you don't re-bootstrap - you switch the active client:

```
switch to {{client_name}}
```

See [CLAUDE.md](./CLAUDE.md) → *The Active-Client Model* and [OPERATING-RHYTHM.md](./OPERATING-RHYTHM.md).

## Archiving / Offboarding a Client

When an engagement ends, run `gtm-skills/client-offboarder.md`. It generates a final report, promotes
abstracted learnings to the shared layer, and moves the folder to `clients/_archived/` (so portfolio
sweeps skip it). The client's `secrets/` was never committed.
