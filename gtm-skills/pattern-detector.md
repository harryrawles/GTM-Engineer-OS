---
name: pattern-detector
description: Runs FIRST at every Claude Code session. Scans company/session-log.md for repeating prompts/intents. If the current prompt resembles 3+ recent historical prompts, surfaces a one-line note proposing to forge a new skill via skill-forge. Does not block work — surfaces and proceeds.
triggers:
  - "(automatic — runs at every session start per CLAUDE.md Session Start Protocol)"
  - "Detect patterns"
  - "Scan for repeating prompts"
  - "What am I doing repeatedly"
reads:
  - "wiki/_skill-context.md"
  - "company/session-log.md (last 90 days)"
  - "company/MEMORY.md (forged skills + rejected patterns sections)"
writes:
  - "company/session-log.md (pattern detection entries)"
  - "company/MEMORY.md (when proposing a forge)"
---

# Skill: Pattern Detector

**Trigger:** Runs automatically at every Claude Code session per `CLAUDE.md` Session Start Protocol. Can also be invoked explicitly via "Detect patterns" or "Scan for repeating prompts."

**Context:** This is the mechanism that makes the OS exponentially improving. Every time Claude is invoked, this skill runs FIRST. It scans the session log to detect whether the current prompt is a repeat of historical prompts. If a pattern is found (3+ matches in 30 days), it surfaces the option to forge a new skill via `gtm-skills/skill-forge.md`.

**Output rule:** never blocks work. Surfaces a one-line note at the top of the response, then proceeds with the user's actual request.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

---

## STEP 0 — Read State

1. Read `company/session-log.md` Active Log (last 90 days)
2. Read `company/session-log.md` "Rejected pattern suggestions" — skip any pattern signature here
3. Read `company/session-log.md` "Forged skills" — skip patterns already forged
4. Read the current user prompt

If `session-log.md` is empty or only has a few entries (under 10) → skip detection. Not enough data yet. Just write a session-log entry for the current invocation and return control to the actual request.

---

## STEP 1 — Categorise the Current Prompt's Intent

Identify the abstract intent of the user's current prompt. Not the verbatim words — the underlying intent.

Examples of intent categorisation:

| Verbatim prompt | Abstract intent |
|----------------|----------------|
| "Diagnose {{CLIENT_NAME}}'s hiring campaign" | `diagnose-campaign-performance` |
| "Why is Vector Health's funding sequence underperforming?" | `diagnose-campaign-performance` |
| "Show me the metrics on Acme's launch campaign" | `diagnose-campaign-performance` |
| "Build a new campaign for {{CLIENT_NAME}}" | `build-campaign-new` |
| "Handle this reply: [paste]" | `handle-inbound-reply` |

The intent should be **abstract enough** that variations of the same underlying request map to the same intent. Not so abstract that everything maps to one category.

---

## STEP 2 — Match Against Session Log

Scan the Active Log (last 90 days) for entries with the same intent category.

Count matches. Apply these rules:

| Match count | Action |
|------------|--------|
| 0-2 matches | Not a pattern yet. Just log this session and continue. |
| 3-4 matches | **Tentative pattern.** Surface a soft note but do not force a skill forge decision. "FYI, you've made N similar requests this month. Worth tracking." |
| 5-9 matches | **Confirmed pattern.** Surface explicitly: "You've asked variants of this N times in last 30 days. Want me to forge a skill that automates this? Reply 'forge it' to proceed." |
| 10+ matches | **Strong pattern.** Same as 5-9 but with stronger language: "You've made this request N times. There is clear ROI in automating it. Recommend forging a skill." |

**Rejected pattern check:** if the matching pattern's signature is in the "Rejected pattern suggestions" table → SKIP this detection. Harry already said no. Do not re-suggest.

**Already-forged check:** if the pattern matches an already-forged skill → SKIP. The skill exists; Harry just hasn't been invoking it. Surface a different note: "FYI, a skill exists for this: `gtm-skills/forged-{name}.md`. You may want to invoke it directly next time."

---

## STEP 3 — Surface the Detection

Output format (prepended to the response, then proceed with the actual task):

```
🔍 PATTERN DETECTED — {{pattern intent name}}

You've asked variants of this {{N}} times in the last {{period}}.
Recent examples:
- [date] "{{prompt summary}}"
- [date] "{{prompt summary}}"
- [date] "{{prompt summary}}"

Want me to forge a skill that automates this? Reply "forge it" and I'll invoke skill-forge.
(Or "skip this" to dismiss permanently — added to rejected patterns.)

---

[continue with the user's actual request]
```

If user replies "forge it" in this or a subsequent session → invoke `gtm-skills/skill-forge.md` with the pattern context.

If user replies "skip this" → add to `company/session-log.md` Rejected pattern suggestions with today's date and reason "user dismissed".

---

## STEP 4 — Log This Session

Append a new row to `company/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{prompt summary 60 chars}} | pattern-detector + {{actual skill being invoked}} | {{detection result: pattern detected / no pattern}} |
```

If pattern-detector found a pattern AND surfaced it, also write to `company/MEMORY.md` Active Focus section:
```
- Pattern detection {{date}}: surfaced "{{intent name}}" ({{N}} occurrences). Awaiting Harry's response on forging.
```

---

## STEP 5 — Hand Off to the Actual Skill

Pattern-detector NEVER takes over the user's actual request. After surfacing detection (if any), it cedes control to whatever skill should handle the original prompt.

Example flow:
```
User: "Diagnose {{CLIENT_NAME}}'s hiring campaign"

Pattern-detector runs first:
  → Detects 5 similar prompts in 30 days
  → Surfaces the detection
  → Writes session-log entry
  → Hands off to chain-diagnose-campaign.md

User then sees:
  1. The pattern detection note
  2. The actual diagnostic output
```

---

## RULES

- **Run FIRST every session.** No exceptions. CLAUDE.md mandates this.
- **Never block work.** Surface and proceed. Harry's response to the pattern is asynchronous — can come this session or later.
- **Be specific, not vague.** "You've asked similar things" is useless. "You've asked to diagnose campaign performance 7 times in 30 days" is actionable.
- **Respect rejections.** Once Harry rejects a pattern, the signature lives in rejected patterns forever. Do not re-suggest.
- **Skip detection for under-10-entry session logs.** Not enough data to be useful.
- **Cost-conscious.** Pattern matching should be fast. Do not invoke sub-agents for this — pattern-detector itself runs in main thread, every session.
- **Do not auto-forge.** Never invoke skill-forge without Harry's explicit "forge it" response. This is a safety rail — forged skills land in the OS as files; Harry needs to opt in.

---

## EXAMPLES

### Example — Pattern detected, surfaced, Harry forges

```
Harry: Diagnose {{CLIENT_NAME}}'s hiring campaign

[pattern-detector runs first]

🔍 PATTERN DETECTED — diagnose-campaign-performance

You've asked variants of this 7 times in the last 30 days.
Recent examples:
- 2026-05-25 "diagnose hiring campaign performance"
- 2026-05-22 "why is funding campaign underperforming"
- 2026-05-18 "show me Acme's campaign metrics"

Want me to forge a skill that automates this? Reply "forge it" and I'll invoke skill-forge.

---

[chain-diagnose-campaign output follows here]

Harry: forge it

[pattern-detector invokes skill-forge with the detected pattern]
[skill-forge drafts gtm-skills/forged-quick-diagnose.md, surfaces for review]
```

### Example — No pattern, just logs

```
Harry: Run pre-launch check for {{CLIENT_NAME}} hiring v5

[pattern-detector runs first]
[scans session-log: 0 matches for "pre-launch-check" intent in 30 days]
[no detection surfaced — proceeds silently to actual skill]

[pre-launch-check output]
[session-log row added with no detection]
```

### Example — Pattern rejected previously

```
Harry: Show me Vector Health's pipeline

[pattern-detector runs first]
[scans: 5 matches for "show-pipeline" intent, but signature is in Rejected patterns from 2026-04-10]
[skips detection — Harry already said no]
[proceeds to actual skill]
[session-log row added with note "pattern matched but rejected previously — skipped"]
```
