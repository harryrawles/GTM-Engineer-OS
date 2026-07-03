---
name: Client request
about: A request from {{CLIENT_NAME}} — change ICP, test new angle, custom ask
title: '[CLIENT REQUEST] '
labels: client-request
assignees: harryrawles
---

## Request from client

**Received:** {{date}}
**Channel:** {{email / call / Slack}}
**Sender:** {{name}}

## What they asked for

{{Paste or summarise the request}}

## Type

- [ ] Change to ICP
- [ ] Change to offer
- [ ] Change to copy / sequence
- [ ] New test request
- [ ] Pause / stop a campaign
- [ ] Reporting question
- [ ] Strategic / other

## My initial response

{{What I said back / planning to say}}

## Implementation plan

- [ ] Update `clients/{slug}/[file].md`
- [ ] Log to `clients/{slug}/decision-log.md` with reasoning
- [ ] Log to `clients/{slug}/comms-log.md`
- [ ] Run skill: {{skill name}}
- [ ] Notify client of completion

## SLA

Target response: within 24 hours
Target completion: {{date}}