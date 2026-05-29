# BOOTSTRAP

This is a fresh clone of the GTM Client OS template. Nothing is filled in yet.

To set up this OS for a new client, **do not edit any files manually**. Instead, run the onboarder:

## Single Command

Open this repo in Claude Code and say:

```
Run client onboarder for {{client_name}}
```

Claude will walk you through 5 phases of questions and write the answers directly into the right files. The conversation IS the intake — no form to fill in.

## The 5 Phases

| Phase | Duration | Writes to |
|-------|----------|-----------|
| 1 — Identity | 5 min | CLAUDE.md, company/overview.md |
| 2 — Offer | 15 min | company/offer.md |
| 3 — ICP | 15 min | company/icp.md |
| 4 — Voice | 10 min | company/voice.md |
| 5 — Infrastructure | 5 min | company/campaign-state.md |

**Total: ~50 minutes** for a full OS setup.

You can pause between phases. The onboarder detects current state on next session and resumes from where you left off.

## What You Need Before Starting

Have ready (or know who to ask):
- Client website and contact details
- Their offer / pricing / case studies
- Who they target (ICP) and what signals indicate buying intent
- Tone of voice samples (a piece of their content, an email they like)
- Instantly workspace details (domains, mailboxes, warmup status)

If you do not have an answer for something, the onboarder will mark it `{{TO CONFIRM}}` and surface it at the end. No question stalls the flow.

## After Onboarding

Once complete, you can run:
- `gtm-skills/signal-sourcer.md` — design the signal strategy
- `gtm-skills/list-builder.md` — source and qualify the first lead list
- `gtm-skills/cold-email-writer.md` — write the first sequence

## Re-Onboarding (Existing Repos)

If a client OS is already filled but needs an update (ICP shifted, offer changed, new voice guidance), say:

```
Re-onboard {{client_name}} — update ICP only
```

The onboarder will run only the relevant phase(s).

## Delete This File After Setup

Once `CLAUDE.md` has no `{{PLACEHOLDER}}` values remaining and the company files are filled, delete `BOOTSTRAP.md` from the repo. It is only needed for setup.