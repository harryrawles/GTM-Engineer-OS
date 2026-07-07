---
name: Incident
about: Deliverability incident, blacklist, bounce spike, outage
title: '[INCIDENT] '
labels: incident, urgent
assignees: harryrawles
---

## Incident type

- [ ] Domain blacklisted
- [ ] Bounce rate spike
- [ ] Bad reply going public / brand risk
- [ ] Instantly outage
- [ ] Client data exposure / breach
- [ ] Other: {{describe}}

## Severity

- [ ] Critical - campaigns paused, immediate action
- [ ] High - investigating, contained
- [ ] Medium - monitoring

## Affected

**Clients:** {{list}}
**Campaigns:** {{list}}
**Domains:** {{list}}
**Mailboxes:** {{list}}

## What happened

{{Timeline of events. When detected. How detected. What was the trigger.}}

## Immediate actions taken

- [ ] Campaigns paused
- [ ] Domain checked against blacklists
- [ ] Warmup increased
- [ ] Client notified (if appropriate)

## Root cause

{{To fill in post-investigation}}

## Recovery plan

Run `gtm-skills/incident-responder.md`. Steps:
1. 
2. 
3. 

## Post-mortem

{{To fill in after resolution. Lessons learned. Logged to decision-log.md.}}