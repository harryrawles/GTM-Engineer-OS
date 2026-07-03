# Sample EOD Report

Example of what `gtm-skills/eod-report-writer.md` produces. Posted to the team Slack at end of day (draft only — the Safety Guard blocks auto-sends). Reconstructed from `.claude/sessions/*.jsonl` + each client's `session-log.md`, cross-referenced with `comms-log.md`, `decision-log.md`, `campaign-state.md`, and `test-log.md`.

Client names are shown as `{{CLIENT_A}}`…`{{CLIENT_H}}` to keep the template brand-agnostic — real reports use real client names.

---

```
EOD Report — Harry — Wednesday, July 2, 2026

MOVED

{{CLIENT_A}}

* Went through another full round of revisions, ultimately rewriting all copy again.
* Settled on an A/B test across two sequences for two different ICPs, four campaigns total.
* Extended revision cycle. If feedback continues at this pace, may need to loop the CSM in to help manage the relationship.

{{CLIENT_B}}

* Created multiple lists and segmented store leads across categories.
* TAM is likely limited but the data is still actionable.
* Main constraint: client wants stores with 1-25 headcount and is expecting 20 bookings per month, not just positive replies.

{{CLIENT_C}}

* Built two campaigns, one for non-profits and one for universities.
* Created SuperSearch filters for both ICPs and sent to the client.

{{CLIENT_D}}

* Squeezed significantly more leads into the developers campaign, expanding the TAM.
* 2 new opportunities came in today off the back of it.

{{CLIENT_E}}

* Client approved the campaign. Shipped it and went live today.

{{CLIENT_F}}

* Enriched 200k companies in the 1-10 headcount range and another 200k in the 11-25 range. 400k total enriched today.

All Clients

* Reached out to all clients about campaign pauses over Friday and Monday. Pauses handled accordingly.

BLOCKED

* N/A

NEXT

{{CLIENT_B}}

* Write a brand new campaign with broader, more agnostic copy.
* The parcel ICP angle proved too narrow and needed too much manual sorting.
* Goal is something wide in reach that still feels personalised.

{{CLIENT_A}}

* Set up all four campaigns with the updated copy.
* Fulfil leads into each, split evenly across sequences.
* Target Tuesday launch.

{{CLIENT_G}}

* Client pushed back on the Testimonial playbook again. Churn risk.
* Open to other playbook proposals as a basis for testing.
* Come back with a fresh angle that works within their constraints.
```

---

## Why this is the quality bar

- **Outcome-first.** "2 new opportunities came in today off the back of it" beats "spent time adding leads."
- **Consolidated.** A whole revision cycle collapses into two or three bullets, not a play-by-play.
- **Quantified.** 400k enriched, four campaigns, 20 bookings — numbers as digits, pulled from the trail.
- **BLOCKED is usually N/A.** Real blockers are rare; potential ones get flagged inside a MOVED bullet.
- **Plain text.** No markdown headings, bold, or tables — it pastes clean into Slack.
- **Not every client in every section.** {{CLIENT_C}} through {{CLIENT_F}} moved today with nothing queued; {{CLIENT_G}} only has next steps.
