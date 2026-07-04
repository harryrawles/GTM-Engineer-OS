# Standard Skill Context

Every skill in `gtm-skills/` should load this context block before acting. Defines the minimum context required to operate on behalf of the **active client**.

**How to use:** skills reference this file in their READS section instead of restating the same 4-5 files every time.

---

## Resolve the Active Client (STEP 0, before any read below)

`{slug}` in every path below means the **active client's** folder under `clients/`.

1. Read `_state/active-client` (git-ignored). Its contents are the active `{slug}`.
2. If it names a slug → that is the active client. State it: "Active client: {Name}."
3. **Inline override:** if the user's request names a client ("… for acme"), use that slug for this request only — do not change `_state/active-client`.
4. **Portfolio mode:** if the request says "for all clients", loop every **active** client folder in `clients/` — that is, every direct subfolder whose name does **not** start with `_` or `.` (so `clients/_archived/` and `clients/.gitkeep` are skipped). Run the skill once per client with full isolation (never mix one client's context into another).
5. If no active client is set and none is named, and the task is client-specific → **stop and ask which client.** Never guess.

**Isolation rule:** only ever read/write files under the resolved `clients/{slug}/`. Never read another client's folder in the same run.

---

## Standard Reads (every skill, every time)

| File | Why |
|------|-----|
| `clients/{slug}/_config.md` | Client name, industry, Instantly workspace |
| `clients/{slug}/MEMORY.md` | **Always-loaded scratchpad — current focus, watch-outs, client preferences, recent learnings** |
| `clients/{slug}/overview.md` | What the client does, SLA, success criteria |
| `clients/{slug}/voice.md` | Tone, spelling default, banned words, approved claims |
| `clients/{slug}/icp.md` | Who we target |
| `clients/{slug}/offer.md` | What we sell on their behalf |

## Conditional Reads (when applicable)

| File | When to read |
|------|-------------|
| `clients/{slug}/decision-log.md` | Any time prior decision context matters |
| `clients/{slug}/campaign-state.md` | When current campaign state affects the task |
| `clients/{slug}/comms-log.md` | When prior client communication matters |
| `clients/{slug}/copy-library.md` | Any time you are writing or evaluating copy |
| `clients/{slug}/test-log.md` | Any time you are running or evaluating a test |
| `wiki/glossary.md` | When acronyms need defining |

## Standard Writes (when generating outputs)

| File | When to write |
|------|-------------|
| `clients/{slug}/decision-log.md` | When a non-obvious choice is made |
| `clients/{slug}/comms-log.md` | When client comms are sent |
| `clients/{slug}/campaign-state.md` | When campaign state changes |
| `clients/{slug}/copy-library.md` | When a winner emerges (PRR >= 1.5%) |

---

## Standard Behaviour

- **Direct, no fluff.** Match the voice in `clients/{slug}/voice.md`.
- **Push back on vague inputs.** Specifics beat clichés.
- **Never invent data.** If a number or claim is uncertain, ask or flag.
- **Always show writes before confirming.** Diff or preview before overwriting.
- **PRR is the primary KPI.** Not reply rate, not open rate, unless explicitly noted otherwise.
- **British spelling default; override via `clients/{slug}/voice.md` if client is US-based.**
---

## Session-Log Write (mandatory for every skill)

Every skill MUST append a row to `clients/{slug}/session-log.md` Active Log at the START of its execution. This is what powers `gtm-skills/pattern-detector.md`. Without consistent log writes, pattern detection breaks.

### Format

| YYYY-MM-DD HH:MM | Prompt summary (~60 chars) | This skill name | Output / outcome (1 line) |

### Rules
- **Write at the START, not the end.** If a skill fails mid-execution, the log still captures that it was attempted.
- **Paraphrase the prompt.** Do not include verbatim sensitive data (prospect names, emails). Summarise the intent.
- **One row per skill invocation.** If a chain invokes 5 sub-skills, each sub-skill writes its own row.
- **The pattern-detector is NOT exempt** — it writes its own row too. Recursion is fine; the detector knows to recognise its own entries and not re-detect on itself.

### Deterministic backstop (`via:hook`)
The `.claude/hooks/session-logger.sh` hook independently appends **one row per user prompt** to the active client's `session-log.md` (skill column = `via:hook`, prompt redacted: emails stripped, truncated to 60 chars). This guarantees the compounding loop keeps a signal even if a skill forgets its STEP-0 row. Skill rows are still mandatory and are the richer record; `pattern-detector` dedupes skill rows against `via:hook` rows so nothing is double-counted.

**Known limitation:** the hook keys off `_state/active-client`, so it correctly attributes rows after a "switch to {client}" but **cannot** attribute an *inline override* ("… for acme" without switching) — those still rely on the skill's STEP-0 row for correct client attribution.

---