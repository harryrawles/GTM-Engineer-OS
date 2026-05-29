---
name: client-offboarder
description: End-of-engagement workflow. Generates final report, migrates learnings to meta-OS, archives client repo, closes billing, decommissions assets. Used when a client churns or transitions out of active engagement.
triggers:
  - "Offboard {{client}}"
  - "{{client}} is churning"
  - "End engagement with {{client}}"
  - "Archive {{client}} OS"
reads:
  - "wiki/_skill-context.md"
  - "all company/*.md"
  - "all examples files"
writes:
  - "company/decision-log.md (final entry)"
  - "company/overview.md (engagement closed status)"
  - "FINAL-REPORT.md (generated)"
---

# Skill: Client Offboarder

**Trigger:** "Offboard {{client}}", "{{client}} is churning", "End engagement with {{client}}", "Archive {{client}} OS"

**Context:** When a client engagement ends — churn, expiry, mutual transition — this skill runs the close-out flow. Captures learnings for the portfolio, generates a final report for the client, decommissions assets cleanly.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## STEP 1 — Confirm Offboarding Scope

Ask Harry:
1. **Reason for offboarding:**
   - Voluntary churn (client chose to leave)
   - Involuntary churn (we chose to end)
   - Engagement expired (planned)
   - Pause (will resume) — different workflow, escalate

2. **Effective end date:** when do campaigns actually stop?

3. **Notice given:** when did client communicate? (or vice versa)

4. **Tone:** amicable / neutral / strained / hostile

5. **Open items:** any unbilled work, pending refunds, contractual obligations?

If pause (not churn) → use a separate "Pause" workflow (not this skill).

---

## STEP 2 — Generate Final Report

Create `FINAL-REPORT.md` in the client repo root. Contents:

```
# Final Report — {{CLIENT_NAME}} | {{date_range}}

## Engagement Summary

- Service: {{from overview.md}}
- Duration: {{start}} → {{end}}
- Total months active: {{n}}
- Reason for ending: {{from Step 1}}

## Performance Summary

Pull from Instantly MCP for entire engagement:

- Total sends: {{n}}
- Total replies: {{n}}
- Average PRR: {{X}}%
- Peak PRR: {{X}}% (campaign: {{name}})
- Total meetings booked: {{n}}
- Estimated deals attributable: {{n}}

## Wins

| Date | Winner | What worked |
|------|--------|-------------|
| [Pull from company/copy-library.md top performers] |

## Lessons Learned

| Lesson | Source | Applied where |
|--------|--------|---------------|
| [Pull from company/decision-log.md highlights] |

## Tests Completed

| Test | Result |
|------|--------|
| [Pull from company/test-log.md completed tests] |

## Infrastructure Status at End

- Sending domains: {{list}}
- Mailboxes: {{n}}
- Final bounce rate: {{X}}%
- Blacklist status: {{clean / listings}}

## Open Items

- [Any unresolved items from comms-log.md]
- [Any contractual obligations not yet completed]

## Recommendations for Client (Going Forward)

If amicable churn, include 2-3 specific recommendations for the client to continue independently:
- {{specific recommendation 1}}
- {{specific recommendation 2}}

## Closing

{{Short closing paragraph — match the tone from Step 1}}
```

Show the draft to Harry. Confirm before sending.

---

## STEP 3 — Migrate Learnings to Meta-OS

**Note:** meta-OS exists once Harry hits 3-5 active clients. If not yet built, skip this step but flag the learnings for manual migration later.

If meta-OS exists:
- Copy top 3-5 winning variants from `company/copy-library.md` → meta-OS `cross-client-winners.md`
- Copy top 3-5 graveyard entries → meta-OS `cross-client-graveyard.md`
- Copy 1-2 strategic insights from `company/decision-log.md` → meta-OS `cross-client-insights.md`
- Tag each migration with `{{CLIENT_NAME}}` as the source for attribution

---

## STEP 4 — Decommission Assets

- [ ] Pause all active campaigns in Instantly (don't delete — preserve for audit)
- [ ] Revoke Instantly MCP API key from this workspace
- [ ] Remove sending domains from active rotation (keep aged for 30 days then evaluate)
- [ ] Cancel any client-specific subscriptions / tools (Clay enrichment, etc.)
- [ ] Suppress all leads in this client's lists across Harry's other client workspaces (to avoid accidental cross-contamination)
- [ ] Remove client from Slack channels / Notion / shared drives
- [ ] Update `company/_config.md`:
  ```
  status: offboarded
  offboarding_date: {{date}}
  offboarding_reason: {{from Step 1}}
  ```

---

## STEP 5 — Close Billing

- [ ] Verify all invoices issued for active period
- [ ] If pro-rated final month — calculate and invoice
- [ ] If refunds due — issue per contract
- [ ] If retainer credit owed back — process
- [ ] Mark contract as terminated in 1Password / contract storage

If complex billing situation → escalate to Harry for manual handling. Do not auto-process refunds.

---

## STEP 6 — Final Communication

Draft a closing email to client. Match the tone from Step 1.

**Amicable churn template:**
```
{{firstName}},

Final wrap from my end.

Attached: the full {{n}}-month performance summary including all wins, learnings, and recommendations for going forward.

Numbers at a glance:
- {{X}} meetings booked across {{n}} campaigns
- Peak PRR: {{X}}%
- {{n}} reusable winning copy variants captured

I've paused all sequences. Sending domains will stay live for 30 days in case you want to spin up something new with another partner — happy to make that handoff smooth.

Thanks for the run.

Harry
```

**Neutral / planned end template:**
```
{{firstName}},

End of engagement wrapping today.

Final report attached.

All campaigns paused. MCP access revoked. Reach out anytime.

Harry
```

**Strained / involuntary churn template:**
```
{{firstName}},

Confirming end of engagement effective {{date}}.

Final report attached covering performance and all open items.

All campaigns paused. Sending domains will be decommissioned within 30 days per contract.

Any final questions, please reply by {{date + 14 days}}.

Harry
```

Show draft to Harry. Do not auto-send.

---

## STEP 7 — Archive the Repo

After all above complete:

1. **Add archival notice to README.md** at top:
```
> ⚠️ ARCHIVED — engagement ended {{date}}.
> This repo is preserved for reference but not actively maintained.
> Last active version: {{template_version}}.
```

2. **Rename the repo** in GitHub: `client-os-{{client_name}}` → `archive-client-os-{{client_name}}-{{YYYY-MM}}`

3. **Set repo description** to indicate archival.

4. **Move to "Archived" folder/topic** in GitHub UI.

5. **Final commit:**
```
chore: archive engagement — final state preserved
```

---

## STEP 8 — Log to Decision Log

Final entry in `company/decision-log.md`:

```
### {{date}} — Engagement Ended

**Context:**
- Duration: {{months}} months
- Reason: {{from Step 1}}
- Tone: {{from Step 1}}

**Final performance:**
- Total meetings: {{n}}
- Average PRR: {{X}}%
- Peak campaign: {{name}} at {{X}}% PRR

**Wins preserved to meta-OS:**
- {{list}}

**Open lessons:**
- {{anything we still don't understand about why this ended}}

**Decision (for future):**
{{Would we take this kind of client again? What would we do differently?}}
```

---

## OUTPUT FORMAT

```
=== Offboarding Complete: {{CLIENT_NAME}} ===

Reason: {{type}}
Effective: {{date}}

Generated:
- FINAL-REPORT.md (draft ready for review)

Migrated to meta-OS:
- {{n}} winners, {{n}} graveyard entries, {{n}} insights

Decommissioned:
- {{n}} campaigns paused
- {{n}} domains marked for 30-day decommission
- {{n}} MCP connections revoked
- {{n}} third-party subscriptions cancelled

Billing:
- {{summary}}

Communication:
- Draft email ready for Harry's review
- Send when ready: {{command}}

Repo status:
- Ready for archival rename: client-os-{{client_name}} → archive-client-os-{{client_name}}-{{YYYY-MM}}
- Final commit pending

Total Engagement Outcome:
- {{lifetime meetings}} meetings booked
- {{lifetime PRR average}} average PRR
- {{lifetime sends}} sends
- {{months}} months of partnership
```

---

## RULES

- **Never auto-send the closing email.** Always Harry's review.
- **Never auto-process refunds.** Escalate.
- **Preserve all data.** Pause campaigns, don't delete them. Audit trail matters if a dispute arises later.
- **Migrate learnings.** This is the most valuable part — what we learned at this client should benefit the next one.
- **Tone matters.** Even strained offboardings should leave a professional impression. Don't burn bridges.
- **Log everything.** The decision-log entry is the last thing future-Harry will see about this client. Make it useful.