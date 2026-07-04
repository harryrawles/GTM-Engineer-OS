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
| [investment.md](./investment.md) | Investor raise campaigns — credibility-first (notable backers, scarcity, low-friction ask) |
| [retail.md](./retail.md) | Retail / shelf-expansion for F&B / CPG brands — AI vs brokers, seasonal urgency, soft CTA |
| [marketing.md](./marketing.md) | B2B marketing / demand gen — competitor-insights curiosity hook, single short email |
| [athletic-directors.md](./athletic-directors.md) | Athletic directors / coaches — leadership/culture platform, credibility + scannable features + demo CTA |
| [aviation.md](./aviation.md) | HNWI / private aviation — discreet "pricing overview" hook, opt-out line, multi-channel variants |
| [influencers.md](./influencers.md) | Influencer marketing for SaaS / SI — value-first hand-curated creator list, opt-out, multi-channel |

_Add new playbooks as one file each; append a row above._
