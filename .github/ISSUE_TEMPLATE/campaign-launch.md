---
name: Campaign launch
about: Pre-flight checklist for launching a new campaign
title: '[LAUNCH] '
labels: campaign-launch
assignees: harryrawles
---

## Campaign details

**Client:** {{CLIENT_NAME}}
**Campaign name:** 
**Signal:** 
**Target ICP slice:** 
**Sequence:** {{n}}-step
**Target launch date:** 

## Pre-flight checklist

Run `gtm-skills/pre-launch-check.md` and `gtm-skills/campaign-launcher.md` to verify each item.

- [ ] All `{{PLACEHOLDER}}` values resolved in `company/*.md`
- [ ] Copy approved by client (link approval below)
- [ ] Sequence loaded into Instantly correctly
- [ ] Send times match client timezone
- [ ] Reply alerts routed correctly
- [ ] Lead list verified within last 30 days
- [ ] Tracking domain working
- [ ] Warmup status green for all mailboxes
- [ ] Bounce rate baseline acceptable
- [ ] Stop conditions defined
- [ ] Logged to `company/decision-log.md`

## Client approval

{{Paste approval email / Slack message / link to Notion}}

## Stop conditions

Pause this campaign if:
- Bounce rate > {{n}}%
- PRR < {{n}}% after {{n}} sends
- {{Other condition}}

## Expected outcome

Target PRR: {{n}}%
Target meetings/week: {{n}}