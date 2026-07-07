# sops/

Standard operating procedures - step-by-step, repeatable runbooks. Part of the **shared layer**, available
to every client.

**Current SOPs:**
- `instantly-api.md` - how the OS calls each client's Instantly workspace directly via the v2 API: the
  `.claude/bin/instantly.sh` wrapper, per-client keys, and the read/write gating map. **Every skill that
  pulls Instantly data depends on this.**

A growing staging area. When you write another runbook (e.g. a domain-warmup procedure or a
deliverability-recovery checklist), drop it here and reference it by path; Claude auto-discovers it. List
new SOPs in `INDEX.md` when you add them.

Other operational method lives in the relevant `wiki/` pages (e.g. `wiki/deliverability.md`) and the
skills themselves. Context assembly treats `sops/` as "load whichever SOPs exist."

**Rule:** nothing in this folder may contain a specific client's private data. SOPs are universal.

See root `CLAUDE.md` → *Shared Brain* for how this fits the OS.
