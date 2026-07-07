# sops/

Standard operating procedures - step-by-step, repeatable runbooks. Part of the **shared layer**, available
to every client.

**Current SOPs:**
- `instantly-api.md` - how the OS calls each client's Instantly workspace directly via the v2 API: the
  `.claude/bin/instantly.sh` wrapper, per-client keys, and the read/write gating map. **Every skill that
  pulls Instantly data depends on this.**
- `daily-structure.md` - the default daily block structure (onboarding, client management, meetings) and
  the response-time defaults (24-hour acknowledgement, 3-day campaign update, Friday batching rule) that
  `OPERATING-RHYTHM.md` and `gtm-skills/client-request-handler.md` build on.
- `client-communication-principles.md` - the baseline standard for every client interaction (document work,
  be proactive, professional language, MRR-weighted prioritisation) plus situational guidance for
  cancellations, refunds, rush demands, and clients wanting to write their own copy.
- `am-gtme-responsibility-split.md` - who owns what between the GTME (Harry) and the AM: campaigns, lead
  lists, and client comms are GTME's; technical setup, domain issues, and billing are the AM's.

A growing staging area. When you write another runbook (e.g. a domain-warmup procedure or a
deliverability-recovery checklist), drop it here and reference it by path; Claude auto-discovers it. List
new SOPs in `INDEX.md` when you add them.

Other operational method lives in the relevant `wiki/` pages (e.g. `wiki/deliverability.md`) and the
skills themselves. Context assembly treats `sops/` as "load whichever SOPs exist."

**Rule:** nothing in this folder may contain a specific client's private data. SOPs are universal.

See root `CLAUDE.md` → *Shared Brain* for how this fits the OS.
