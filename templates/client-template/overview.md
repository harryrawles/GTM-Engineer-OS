# Client Overview - {{CLIENT_NAME}}

## Identity

**Company name:** {{CLIENT_NAME}}
**Website:** {{WEBSITE}}
**Industry:** {{INDUSTRY}}
**Founded:** {{YEAR}}
**Size:** {{EMPLOYEE_COUNT}} employees
**Location / HQ:** {{LOCATION}}

## What They Do

{{2-3 sentence description of what the client does, who they serve, and how they are different from competitors}}

## Why They Hired Instantly.ai

{{What problem brought them here. What they were doing before. What they want to achieve from outbound.}}

## Key Contacts

| Name | Title | Email | Phone | Notes |
|------|-------|-------|-------|-------|
| {{Name}} | {{Title}} | {{Email}} | {{Phone}} | Main point of contact |

## Contract

| Detail | Value |
|--------|-------|
| Service | {{Service type}} |
| Start date | {{Start date}} |
| Monthly sends | {{Sends per month}} |
| Reporting day | {{Day of week report is due}} |
| Renewal date | {{Renewal date}} |

## SLA & Commitments (O1)

What we have explicitly committed to this client. Use as the bar for response times, reporting cadence, and escalation paths. Default to the OS-wide figures in `sops/daily-structure.md` (24-hour acknowledgement, 3-day campaign update) unless this client's contract specifies otherwise.

- **Response time to client messages:** {{e.g. Within 24 hours weekdays}}
- **Reporting cadence:** {{Weekly Friday EOD / Bi-weekly / etc.}}
- **Optimisation cadence:** {{Every 2 weeks / Monthly / As performance dictates}}
- **Escalation path:** {{Slack DM to {{Name}} for urgent, email otherwise}}
- **Pause triggers communicated:** {{e.g. bounce >5% pauses immediately}}
- **Approval required for:** {{e.g. new campaign launches, ICP changes, sending volume increases beyond {{X}}/day}}

## Success Criteria (O2)

Defined targets. Used by `gtm-skills/client-health-scorer.md` to score performance.

### 30-day targets
- PRR ≥ {{X}}%
- {{n}}+ qualified meetings booked
- Bounce rate < {{X}}%

### 60-day targets
- PRR ≥ {{X}}%
- {{n}}+ qualified meetings booked
- {{n}}+ winners logged to copy-library

### 90-day targets
- PRR ≥ {{X}}%
- {{n}}+ qualified meetings/month sustained
- {{n}}+ deal(s) closed attributable to outbound

### Quarterly target
- {{$X}}+ in revenue attributable to outbound

Renewal is an AM-owned commercial outcome (`sops/am-gtme-responsibility-split.md`), not a GTME success
criterion, it isn't listed as a target here. `gtm-skills/qbr-writer.md` still builds the performance case
that supports it.

## Context Notes

{{Any additional context the GTME needs to manage this account well. Quirks, sensitivities, preferences, things they care about beyond metrics. Examples:
- Primary contact is data-driven - always cite specific numbers
- They are sensitive about [X] because of past experience
- They prefer async Slack over calls
- They have a strong opinion on [topic]
}}

## External Resources

- Client Notion workspace: {{URL}}
- Client Slack channel: {{channel name}}
- Shared Drive / assets: {{URL}}
- Contract / SoW: {{1Password link or shared drive}}