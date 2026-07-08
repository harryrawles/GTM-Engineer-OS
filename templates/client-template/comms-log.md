# Client Communications Log - {{CLIENT_NAME}}

Captures every meaningful interaction with the client. Used by:
- `gtm-skills/client-health-scorer.md` to assess sentiment
- `gtm-skills/qbr-writer.md` to summarise the quarter
- `gtm-skills/reply-handler.md` and `gtm-skills/client-request-handler.md` (write entries automatically)

**Format:** newest entries at the top. Each entry standalone.

---

## How to Read

Each entry:
- **Date** - when it happened
- **Channel** - email / call / Slack / Notion / in-person
- **Direction** - inbound (from client) / outbound (from GTME)
- **Summary** - 1-3 lines, what was said
- **Action needed** - what the GTME has to do next, with deadline
- **Outcome** - filled in once resolved

---

## Recent Communications

<!-- Newest entries first. Append above older ones. -->

### {{YYYY-MM-DD HH:MM}} - {{Channel}} {{Direction}}

**With:** {{Contact name}}
**Topic:** {{1-line topic}}

**Summary:**
{{2-4 sentences of what was discussed or sent. Include any specific commitments made.}}

**Action needed:**
- [ ] {{Specific action}} - by {{date}}
- [ ] {{Specific action}} - by {{date}}

**Outcome:** {{filled in once resolved}}

---

### {{previous entry}}

...

---

## Patterns

When 3+ entries surface the same theme (frustration, recurring question, positive feedback area), log here:

- **{{Pattern}}** - observed across {{n}} interactions. Implication: {{what this tells us}}

## Unresolved Items

Items still requiring action.

| Date raised | Action needed | Owner | Due |
|-------------|---------------|-------|-----|
| {{date}} | {{action}} | GTME | {{date}} |

## SLA Tracking

| Period | Inbound msgs | Avg response time | SLA target | Hit rate |
|--------|-------------|-------------------|-----------|---------|
| {{week}} | {{n}} | {{n hours}} | {{from overview.md}} | {{%}} |