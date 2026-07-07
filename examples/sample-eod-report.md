# Sample EOD Report

Example of what `gtm-skills/eod-report-writer.md` produces. Posted to the team Slack at end of day (draft only — the Safety Guard blocks auto-sends). Reconstructed from `.claude/sessions/*.jsonl` + each client's `session-log.md`, cross-referenced with `comms-log.md`, `decision-log.md`, `campaign-state.md`, and `test-log.md`.

Client names are shown as `{{CLIENT_A}}`…`{{CLIENT_H}}` to keep the template brand-agnostic — real reports use real client names.

---

```
EOD Report — Harry — Wednesday, July 2, 2026

MOVED

{{CLIENT_A}}

* 0 opps on 31k sends, offer's unclear not targeting, rewrote the hook and cut the offer to one claim, live Thurs.
* Extended revision cycle before this. If Thurs variant doesn't move PRR, looping the CSM in on the relationship.

{{CLIENT_B}}

* Flat at 0.6% PRR after 14 days, ruled out deliverability (bounce 1.1%, clean), targeting is the actual gap — 1-25 headcount TAM too thin. Rebuilding with a wider band, new list by Friday.

{{CLIENT_C}}

* Built two campaigns, one for non-profits and one for universities — new accounts, no prior data to diagnose against yet.

{{CLIENT_D}}

* Added a funding signal on top of hiring — roughly doubles addressable volume off a Green account. 2 opps already in today off the expanded list.

{{CLIENT_E}}

* Client approved the campaign. Shipped it and went live today.

{{CLIENT_F}}

* Enriched 400k companies (200k at 1-10 headcount, 200k at 11-25) to clear the TAM ceiling flagged last week.

All Clients

* Reached out to all clients about campaign pauses over Friday and Monday. Pauses handled accordingly.

BLOCKED

* N/A

NEXT

{{CLIENT_B}}

* New wider-band list lands Friday — relaunch Monday with the same copy, since targeting was the diagnosed cause, not the message.

{{CLIENT_A}}

* Set up all four campaigns with the updated hook.
* Fulfil leads into each, split evenly across sequences.
* Target Tuesday launch.

{{CLIENT_G}}

* Client pushed back on the Testimonial playbook again. Churn risk.
* Open to other playbook proposals as a basis for testing.
* Come back with a fresh angle that works within their constraints.
```

---

## Why this is the quality bar

- **Stagnant accounts get diagnosed, not just touched.** `{{CLIENT_A}}` and `{{CLIENT_B}}` had both crossed the stagnant trigger (heavy sends or 14+ days live, weak PRR) — each bullet names the symptom, the cause, the cause *ruled out*, and what happens next. "Reworked copy for {{CLIENT_A}}" would have taken the same two seconds to write and proven nothing.
- **Good accounts get a named lever, not a pat on the back.** `{{CLIENT_D}}` was already Green — the bullet states exactly what was scaled (a second signal) and the observed impact, not just "account is doing well."
- **Diagnostic order shows in the writing.** `{{CLIENT_B}}`'s bullet rules out deliverability before landing on targeting — copy wasn't touched, because copy wasn't the cause. That ordering is what proves the diagnosis happened rather than being assumed.
- **Routine work still states a reason, never a bare activity.** `{{CLIENT_F}}`'s enrichment bullet ties the number to why it mattered (clearing a previously flagged TAM ceiling), not just "enriched 400k companies."
- **New accounts don't get forced into a diagnosis they can't have yet.** `{{CLIENT_C}}` has no prior data — Template C, plainly stated, is correct; inventing a cause would be worse than not having one.
- **Consolidated.** A whole revision cycle collapses into two bullets, not a play-by-play.
- **BLOCKED is usually N/A.** Real blockers are rare; potential ones get flagged inside a MOVED bullet. A stagnant account being worked is a MOVED bullet, not a BLOCKED one.
- **Plain text.** No markdown headings, bold, or tables — it pastes clean into Slack.
- **Not every client in every section.** `{{CLIENT_C}}` through `{{CLIENT_F}}` moved today with nothing queued; `{{CLIENT_G}}` only has next steps.
