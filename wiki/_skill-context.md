# Standard Skill Context

Every skill in `gtm-skills/` should load this context block before acting. Defines the minimum context required to operate on behalf of this client.

**How to use:** skills reference this file in their READS section instead of restating the same 4-5 files every time.

---

## Standard Reads (every skill, every time)

| File | Why |
|------|-----|
| `company/_config.md` | Client name, industry, Instantly workspace |
| `company/MEMORY.md` | **Always-loaded scratchpad — current focus, watch-outs, client preferences, recent learnings** |
| `company/overview.md` | What the client does, SLA, success criteria |
| `company/voice.md` | Tone, spelling default, banned words, approved claims |
| `company/icp.md` | Who we target |
| `company/offer.md` | What we sell on their behalf |

## Conditional Reads (when applicable)

| File | When to read |
|------|-------------|
| `company/decision-log.md` | Any time prior decision context matters |
| `company/campaign-state.md` | When current campaign state affects the task |
| `company/comms-log.md` | When prior client communication matters |
| `company/copy-library.md` | Any time you are writing or evaluating copy |
| `company/test-log.md` | Any time you are running or evaluating a test |
| `wiki/glossary.md` | When acronyms need defining |

## Standard Writes (when generating outputs)

| File | When to write |
|------|-------------|
| `company/decision-log.md` | When a non-obvious choice is made |
| `company/comms-log.md` | When client comms are sent |
| `company/campaign-state.md` | When campaign state changes |
| `company/copy-library.md` | When a winner emerges (PRR >= 1.5%) |

---

## Standard Behaviour

- **Direct, no fluff.** Match the voice in `company/voice.md`.
- **Push back on vague inputs.** Specifics beat clichés.
- **Never invent data.** If a number or claim is uncertain, ask or flag.
- **Always show writes before confirming.** Diff or preview before overwriting.
- **PRR is the primary KPI.** Not reply rate, not open rate, unless explicitly noted otherwise.
- **British spelling default; override via `company/voice.md` if client is US-based.**
---

## Session-Log Write (mandatory for every skill)

Every skill MUST append a row to `company/session-log.md` Active Log at the START of its execution. This is what powers `gtm-skills/pattern-detector.md`. Without consistent log writes, pattern detection breaks.

### Format

| YYYY-MM-DD HH:MM | Prompt summary (~60 chars) | This skill name | Output / outcome (1 line) |

### Rules
- **Write at the START, not the end.** If a skill fails mid-execution, the log still captures that it was attempted.
- **Paraphrase the prompt.** Do not include verbatim sensitive data (prospect names, emails). Summarise the intent.
- **One row per skill invocation.** If a chain invokes 5 sub-skills, each sub-skill writes its own row.
- **The pattern-detector is NOT exempt** — it writes its own row too. Recursion is fine; the detector knows to recognise its own entries and not re-detect on itself.

---