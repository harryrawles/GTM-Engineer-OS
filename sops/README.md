# sops/

Standard operating procedures — step-by-step, repeatable runbooks. Part of the **shared layer**, available
to every client.

**Status: intentionally empty for now.** No SOP files ship yet — this is a staging area, not a broken
reference. No skill points at a specific `sops/<file>.md`, so nothing depends on content being here. When
you write a runbook (e.g. a domain-warmup procedure or a deliverability-recovery checklist), drop it here
and reference it by path; Claude auto-discovers it. List new SOPs in `INDEX.md` when you add them.

Until then, operational method lives in the relevant `wiki/` pages (e.g. `wiki/deliverability.md`) and the
skills themselves. Context assembly treats `sops/` as "load whichever SOPs exist."

**Rule:** nothing in this folder may contain a specific client's private data. SOPs are universal.

See root `CLAUDE.md` → *Shared Brain* for how this fits the OS.
