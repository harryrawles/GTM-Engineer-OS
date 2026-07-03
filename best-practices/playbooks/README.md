# Playbooks

Reusable, **client-agnostic** campaign playbooks — part of the shared layer, available to every client.
Each playbook is a proven campaign structure (goal, ICP, messaging strategy, sequence, when to use / avoid)
written with `{{PLACEHOLDER}}` values so it can be adapted to any client.

**Golden rule still applies:** playbooks hold *patterns*, never a specific client's private data. When you
run a playbook for a client, fill the placeholders from that client's `clients/{slug}/` files and only use
claims from their `voice.md` → *Approved Claims*. Never copy one client's real terms into another's campaign.

## When to consult

Any time you build or write a campaign for the active client (`cold-email-writer`, `signal-sourcer`,
`chain-build-campaign`), check here first for a matching playbook to start from — then adapt, don't drop in
verbatim.

## Index

| Playbook | Use for |
|----------|---------|
| [funding.md](./funding.md) | Fast-capital / funding offers to SMB owners — speed + low-friction approvals |

_Add new playbooks as one file each; append a row above._
