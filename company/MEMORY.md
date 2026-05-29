# MEMORY — {{CLIENT_NAME}}

**Always-loaded scratchpad.** This file is read at the start of every Claude session for this client. It is the "what is currently top of mind" working memory — distinct from the structured logs.

**This file is intentionally lightweight.** It is NOT a permanent archive. Old entries get pruned or moved to `company/decision-log.md` if they become permanent learnings.

---

## Distinction from other files

| File | Purpose | Cadence |
|------|---------|---------|
| `MEMORY.md` (this file) | Active context, transient notes, current focus | Updated mid-session by any skill |
| `company/decision-log.md` | Permanent decision rationale with structure | Updated on decisions |
| `company/comms-log.md` | Communication events with the client | Updated on every interaction |
| `company/copy-library.md` | Winning copy artefacts | Updated weekly |
| `company/test-log.md` | Test history | Updated when tests start / complete |

If something belongs in one of the other files, write it there. Only use MEMORY for transient or evolving context.

---

## Active Focus

What is currently top of mind for this account. Update when priorities shift.

- {{e.g. "Funding v2 PRR declining — running T-006 reframe test this week"}}
- {{e.g. "Renewal in 47 days — need a strong week to set up Drew's confidence"}}
- {{e.g. "Client just hired a new VP Marketing — may want to brief them on outbound approach"}}

---

## Active Inbound Watch

Accounts where inbound signals fired recently and we are tracking conversion. Items here should be re-checked within 48h-7d.

| Account | Signal | Tier | Activated | Re-check |
|---------|--------|------|-----------|---------|
| {{Account}} | {{signal type}} | {{A/B/C}} | {{date}} | {{date}} |

Cleared from this section when:
- Converted to meeting → move to comms-log
- Replied negatively → suppressed
- Re-check date passed with no engagement → drop

---

## Client Preferences (captured ad-hoc)

Things the client mentioned that should shape how we operate but are not formal SLAs. Lighter than overview.md SLA section.

- {{e.g. "Drew prefers async Slack updates over scheduled calls"}}
- {{e.g. "Drew dislikes when reports lead with bad news — frame issues with the fix attached"}}
- {{e.g. "Harrison is the data person — copy him on any number-heavy update"}}

---

## Watch-outs

Things to remember when working on this account. Patterns that surprised us, edge cases, sensitivities.

- {{e.g. "Drew is sensitive about 'agency churn' framing — many of his prospects have been burned by recruiters before"}}
- {{e.g. "Avoid 'cold' language — Drew wants outbound positioned as warm and signal-driven"}}
- {{e.g. "Crypto industries are off limits — they had two payment disputes in 2025"}}

---

## Open Questions / Pending Items

Things waiting on the client, on Harry, or on a future event.

- [ ] {{e.g. "Waiting on Drew to approve T-006 variant copy by Monday"}}
- [ ] {{e.g. "Renewal discussion scheduled for 2026-07-01"}}
- [ ] {{e.g. "Reviewing new champion job change source — Champify vs LoneScale, decision by Friday"}}

---

## Recent Learnings (not yet codified)

Insights that have emerged but are not yet promoted to permanent files. Promote to decision-log or copy-library when confidence increases.

- {{e.g. "The 'sample shortlist' CTA pattern may work across multiple clients — observed lifting reply rate on Recruitcha. Try on Client B's next campaign."}}
- {{e.g. "Negative replies cluster around 'we use Greenhouse' objection — may need to refine ICP to exclude companies with active Greenhouse subscriptions"}}

---

## Archive

Older entries moved here when no longer top of mind but worth keeping searchable. Prune entries older than 90 days unless they capture something not already in permanent files.

- {{date}} — {{archived note}}

---

## How Skills Update This File

- **`weekly-reviewer.md`** — at end of review, prompts Harry to update Active Focus and Recent Learnings
- **`reply-handler.md`** — when a reply contains a client preference signal, captures to Client Preferences
- **`client-request-handler.md`** — adds to Open Questions when a request needs client response
- **`inbound-activator.md`** — adds to Active Inbound Watch
- **`incident-responder.md`** — adds to Active Focus if incident is unresolved

## Auto-Pruning Rules

Skills should:
- Remove Active Inbound Watch entries past their re-check date with no conversion
- Move Active Focus items older than 30 days to Archive if no longer relevant
- Move Recent Learnings older than 90 days to Archive or promote to decision-log
- Never delete Watch-outs (these compound permanently)
- Never delete Client Preferences (these compound permanently)