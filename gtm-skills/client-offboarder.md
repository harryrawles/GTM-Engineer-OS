---
name: client-offboarder
description: End-of-engagement workflow. Generates final report, promotes abstracted learnings to the shared layer, archives the client folder, closes billing, decommissions assets. Used when a client churns or transitions out of active engagement.
triggers:
  - "Offboard {{client}}"
  - "{{client}} is churning"
  - "End engagement with {{client}}"
  - "Archive {{client}} OS"
reads:
  - "wiki/_skill-context.md"
  - "all clients/{slug}/*.md"
  - "all examples files"
writes:
  - "clients/{slug}/decision-log.md (final entry)"
  - "clients/{slug}/overview.md (engagement closed status)"
  - "FINAL-REPORT.md (generated)"
---

# Skill: Client Offboarder

**Trigger:** "Offboard {{client}}", "{{client}} is churning", "End engagement with {{client}}", "Archive {{client}} OS"

**Context:** When a client engagement ends - churn, expiry, mutual transition - this skill runs the close-out flow. Captures learnings for the portfolio, generates a final report for the client, decommissions assets cleanly. This runs after the decision is final. If a client has just said they want to cancel and a save is still possible, that is `sops/client-communication-principles.md`'s "Client wants to cancel" situation, not this skill.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end - captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt - no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution (e.g. "Drafted Email 1 + 2 follow-ups", "Diagnosed: deliverability issue", "Pattern detected: diagnose-campaign-performance")

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## STEP 1 - Confirm Offboarding Scope

Ask Harry:
1. **Reason for offboarding:**
   - Voluntary churn (client chose to leave)
   - Involuntary churn (Instantly chose to end - this decision is made by the AM/leadership, not Harry;
     this skill executes it once made)
   - Engagement expired (planned)
   - Pause (will resume) - different workflow, escalate to the AM

2. **Effective end date:** when do campaigns actually stop?

3. **Notice given:** when did client communicate? (or vice versa)

4. **Tone:** amicable / neutral / strained / hostile

5. **Open items:** any unbilled work, pending refunds, contractual obligations?

If pause (not churn) → use a separate "Pause" workflow (not this skill).

---

## STEP 2 - Generate Final Report

Create `FINAL-REPORT.md` in the client folder (`clients/{slug}/FINAL-REPORT.md`). Contents:

```
# Final Report - {{CLIENT_NAME}} | {{date_range}}

## Engagement Summary

- Service: {{from overview.md}}
- Duration: {{start}} → {{end}}
- Total months active: {{n}}
- Reason for ending: {{from Step 1}}

## Performance Summary

Pull from the Instantly API (via `.claude/bin/instantly.sh` for this client) for the entire engagement:

- Total sends: {{n}}
- Total replies: {{n}}
- Average PRR: {{X}}%
- Peak PRR: {{X}}% (campaign: {{name}})
- Total meetings booked: {{n}}
- Estimated deals attributable: {{n}}

## Wins

| Date | Winner | What worked |
|------|--------|-------------|
| [Pull from clients/{slug}/copy-library.md top performers] |

## Lessons Learned

| Lesson | Source | Applied where |
|--------|--------|---------------|
| [Pull from clients/{slug}/decision-log.md highlights] |

## Tests Completed

| Test | Result |
|------|--------|
| [Pull from clients/{slug}/test-log.md completed tests] |

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

{{Short closing paragraph - match the tone from Step 1}}
```

Show the draft to Harry. Confirm before sending.

---

## STEP 3 - Promote Abstracted Learnings to the Shared Layer

This repo **is** the multi-client OS. The place for cross-client learning is the shared layer
(`best-practices/`, `frameworks/`), not a separate meta-OS repo.

**Isolation rule (critical):** only promote **abstracted, generalisable patterns** - never a client's raw
private data. Strip the client's specific numbers, named prospects, proof points, and verbatim copy. If a
learning cannot be stated without the client's private data, it stays in `clients/{slug}/` and is not
promoted. See root `CLAUDE.md` → *Golden Rules* (no cross-client sharing of data, ever).

What to promote (abstracted only):
- Generalised copy *structures* that won (the pattern, not the client's exact email) → `best-practices/`
- Graveyard *anti-patterns* (the structural mistake to avoid, not the client's copy) → `best-practices/`
- Strategic *insights / mental models* from `clients/{slug}/decision-log.md` → `frameworks/`

Do **not** copy `copy-library.md` / `decision-log.md` entries verbatim into shared files - extract the
transferable lesson and write it in the client-agnostic form.

---

## STEP 4 - Decommission Assets

- [ ] Pause all active campaigns in Instantly (don't delete - preserve for audit)
- [ ] Revoke this client's Instantly API key in their workspace, then clear it from `clients/{slug}/secrets/credentials.md`
- [ ] Remove sending domains from active rotation (keep aged for 30 days then evaluate)
- [ ] Flag any client-specific subscriptions / tools (Clay enrichment, etc.) to the AM for cancellation,
  this is billing-adjacent (`sops/am-gtme-responsibility-split.md`)
- [ ] Suppress all leads in this client's lists across Harry's other client workspaces (to avoid accidental cross-contamination)
- [ ] Remove client from Slack channels / Notion / shared drives
- [ ] Update `clients/{slug}/_config.md`:
  ```
  status: offboarded
  offboarding_date: {{date}}
  offboarding_reason: {{from Step 1}}
  ```

---

## STEP 5 - Close Billing

Billing is AM-owned, not GTME-owned (`sops/am-gtme-responsibility-split.md`). This checklist is what needs
to happen, hand it to the AM to execute rather than processing it yourself.

- [ ] Verify all invoices issued for active period
- [ ] If pro-rated final month - calculate and invoice
- [ ] If refunds due - issue per contract
- [ ] If retainer credit owed back - process
- [ ] Mark contract as terminated in 1Password / contract storage

If complex billing situation - loop in the AM and Harry for manual handling. Never auto-process refunds.

---

## STEP 6 - Final Communication

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

I've paused all sequences. Sending domains will stay live for 30 days in case you want to spin up something new with another partner - happy to make that handoff smooth.

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

## STEP 7 - Archive the Client Folder

A client is a folder under `clients/`, not a separate repo. Archiving keeps the record without leaving the
client in the active portfolio (so portfolio sweeps and `clients/` enumeration skip it).

After all above complete:

1. **Add an archival notice** to the top of `clients/{slug}/overview.md`:
```
> ⚠️ ARCHIVED - engagement ended {{date}}.
> Preserved for reference; not actively maintained. Last template_version: {{template_version}}.
```

2. **Move the folder out of the active set:** `git mv clients/{slug}/ clients/_archived/{slug}-{{YYYY-MM}}/`
   (create `clients/_archived/` if it does not exist). Portfolio mode enumerates only top-level
   `clients/{slug}/` folders, so an archived client is automatically excluded.

3. **Clear the active-client pointer if it points here:** if `_state/active-client` contains this slug,
   blank it so the next session does not resolve to an archived client.

4. **Confirm secrets are gone:** the client's `secrets/` was never committed (git-ignored). Delete the
   local `clients/_archived/{slug}-.../secrets/` folder so no live API key lingers on disk.

5. **Final commit:**
```
chore: archive {{slug}} - engagement ended, final state preserved
```

---

## STEP 8 - Log to Decision Log

Final entry in `clients/{slug}/decision-log.md`:

```
### {{date}} - Engagement Ended

**Context:**
- Duration: {{months}} months
- Reason: {{from Step 1}}
- Tone: {{from Step 1}}

**Final performance:**
- Total meetings: {{n}}
- Average PRR: {{X}}%
- Peak campaign: {{name}} at {{X}}% PRR

**Wins promoted to shared layer (abstracted):**
- {{list - client-agnostic patterns only}}

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

Promoted to shared layer (abstracted, client-agnostic):
- {{n}} winning patterns, {{n}} anti-patterns, {{n}} insights

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
- Ready to archive: clients/{{slug}}/ → clients/_archived/{{slug}}-{{YYYY-MM}}/ (STEP 7)
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
- **Migrate learnings.** This is the most valuable part - what we learned at this client should benefit the next one.
- **Tone matters.** Even strained offboardings should leave a professional impression. Don't burn bridges.
- **Log everything.** The decision-log entry is the last thing future-Harry will see about this client. Make it useful.