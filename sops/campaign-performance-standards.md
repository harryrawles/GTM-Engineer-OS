# SOP: Campaign Performance Standards

When: assessing whether a campaign is performing or needs intervention.

These are internal benchmarks. Do not share the exact figures below with clients, see "The External
Benchmark" for what is safe to communicate.

---

## Performance Benchmarks

Emails sent per positive reply, and what each range means:

| Sends per positive reply | PRR equivalent | Status |
|---|---|---|
| Under 60 | Over 1.67% | Exceptional. The offer and ICP are firing perfectly. |
| 60-200 | 0.5%-1.67% | Great. Strong campaign, keep iterating. |
| 200-500 | 0.2%-0.5% | Good. This is the internal floor we aim to hit for every client. |
| 500-1,000 | 0.1%-0.2% | Below standard. Review copy, ICP targeting, and deliverability now. |
| 1,000+ | Under 0.1% | Poor. Escalate immediately, follow `sops/gtme-unlock-ladder.md`. |

This is the same PRR scale used across the OS, just expressed as raw sends per reply instead of a
percentage (see `wiki/email-benchmarks.md`). Use whichever framing is faster in the moment, they agree.

---

## The External Benchmark

We communicate to clients that 1 positive reply per 1,000 emails is the industry standard. Internally we
should be exceeding this for the majority of clients. If a client is consistently at or below 1,000 sends
per reply, something needs fixing, escalate before the client notices.

---

## Where this fits in the OS

- **This is the authoritative version of the PRR scale.** `wiki/email-benchmarks.md`'s PRR Benchmarks
  table, `templates/client-template/campaign-state.md`'s Benchmarks table, and the Green/Amber/Red
  thresholds in `gtm-skills/weekly-reviewer.md`, `gtm-skills/client-report-writer.md`, and
  `gtm-skills/campaign-optimiser.md` all read off these same five bands.
- **"Not sharing exact numbers with clients"** is the internal-benchmark half of
  `sops/client-communication-principles.md`. What the client sees in their weekly report
  (`gtm-skills/client-report-writer.md`) is their own actual PRR, that stays exactly as reported. What
  stays internal is the floor/tier language above and the fact that our real bar is well ahead of the
  "1 per 1,000" figure we communicate externally.
- **Escalation at 1,000+ sends per reply** routes through `sops/gtme-unlock-ladder.md`. That SOP has not
  been added to the OS yet, this is a forward reference pending it.
