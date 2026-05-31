# Skill: Client Report Writer

**Trigger:** "Write the weekly report", "write the client update", "prepare this week report"

**Context:** Harry sends a weekly performance update to the client. The report should be concise, data-led, and make the client feel informed and confident. No padding. No corporate filler.

**Read before writing:**
- `company/overview.md` — client name and reporting day
- `company/campaign-state.md` — active campaigns and benchmarks
- `company/test-log.md` — what is currently being tested (to include in "what is next")

---

## STEP 0 — Log Invocation (mandatory)

Before any other step, append one row to `company/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end — captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt — no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## BEFORE YOU WRITE

Pull from Instantly MCP for the past 7 days:
- Sends per campaign
- Reply rate per campaign
- PRR per campaign
- Meetings booked
- Bounce rate

Ask Harry to paste the data if Instantly MCP is unavailable.

Also confirm from Harry:
- Any meetings booked from replies this week
- Any notable positive or negative replies worth mentioning
- Any changes made to campaigns this week

---

## REPORT FORMAT

Output the report exactly in this format. Do not add sections. Do not add padding.

---

**Week ending:** {{DATE}}
**Client:** {{CLIENT_NAME}}

---

**This week**

| Metric | This week | Last week | Change |
|--------|-----------|-----------|--------|
| Emails sent | {{n}} | {{n}} | {{+/-n}} |
| Reply rate | {{%}} | {{%}} | {{+/-%}} |
| Positive reply rate | {{%}} | {{%}} | {{+/-%}} |
| Meetings booked | {{n}} | {{n}} | {{+/-n}} |
| Bounce rate | {{%}} | {{%}} | {{+/-%}} |

---

**Campaign breakdown**

| Campaign | Signal | Sends | PRR | Meetings | Status |
|----------|--------|-------|-----|----------|--------|
| {{Name}} | {{Signal}} | {{n}} | {{%}} | {{n}} | Green / Amber / Red |

---

**What is working**

{{1-3 bullets. Specific observations — not vague positives. e.g. "Email 1 on the hiring signal is at 2.1% PRR — above benchmark. The offer framing around time-to-hire is resonating."}}

---

**What we are watching / testing**

{{1-2 bullets. What is underperforming and what is being done about it. e.g. "Email 2 reply rate is low. Testing a shorter CTA this week — will have data by [date]."}}

---

**Next week**

{{2-3 bullets. What is happening next week — new campaigns, test launches, volume changes, etc.}}

---

**Anything you need from me**

{{If Harry needs something from the client — approval, assets, contacts. Leave blank if nothing needed.}}

---

## REPORT RULES

- Under 300 words total.
- No corporate filler. No "hope you are well". No "please do not hesitate to contact me".
- Data from Instantly is the source of truth. Do not round numbers.
- If a campaign is Red (PRR under 0.5%), name the root cause and the fix — do not hide it.
- If something worked, say specifically why (not just "good results this week").
- The "What is next" section should make the client feel like there is always a plan.
- Sign off as Harry, not as the company.