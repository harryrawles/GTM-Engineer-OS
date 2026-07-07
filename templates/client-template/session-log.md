# Session Log - {{CLIENT_NAME}}

Per-client log of every Claude Code invocation for this client OS. Used by `gtm-skills/pattern-detector.md` to detect repeating prompts and propose new skills via `gtm-skills/skill-forge.md`.

**Auto-pruning:** entries older than 90 days are moved to `Archive` section below.
**Auto-written by:** every skill, at invocation time (mandated by `wiki/_skill-context.md`).

---

## How Entries Get Written

Every skill, at the START of its execution, appends one line to the table below:

| YYYY-MM-DD HH:MM | Prompt summary (~60 chars) | Skill invoked | Output / outcome (1 line) |

Format rules:
- Prompt summary: paraphrase the user's intent, not verbatim quote. Strip pleasantries.
- Skill invoked: the single skill name (no path). If multiple skills run (chain), log each as a separate entry.
- Output: one-line description of what was produced or decided. Not the full content.

---

## Active Log (last 90 days)

| Timestamp | Prompt summary | Skill invoked | Output / outcome |
|-----------|---------------|---------------|------------------|
| | | | |

---

## Pattern Detection State

Populated by `gtm-skills/pattern-detector.md`. Helps the detector avoid re-suggesting patterns Harry already rejected.

### Rejected pattern suggestions

Patterns the detector previously surfaced that Harry chose NOT to forge into skills. Detector skips these in future runs.

| Pattern signature | First detected | Rejected on | Reason (optional) |
|-------------------|----------------|-------------|-------------------|
| | | | |

### Forged skills (created by pattern-detector → skill-forge flow)

Skills that were auto-forged from detected patterns. Lives here for traceability - the skill itself lives at `gtm-skills/forged-{name}.md` until Harry promotes it (renames to drop the `forged-` prefix).

| Skill name | Forged from pattern | Date forged | Status | Promoted on |
|-----------|---------------------|-------------|--------|-------------|
| | | | (Pending review / Promoted / Deleted) | |

---

## Archive (older than 90 days)

Append-only archive of session-log entries past the 90-day window. Kept for long-arc analysis but not scanned by pattern-detector by default.

| Timestamp | Prompt summary | Skill invoked | Output / outcome |
|-----------|---------------|---------------|------------------|
| | | | |

---

## Hygiene Rules

- **Auto-prune monthly:** entries older than 90 days move to Archive. Done during weekly-reviewer (OS Hygiene section) or chain-weekly-review-full (STEP 5 - Update OS Hygiene).
- **Never delete entries.** The log is the substrate that makes the OS exponentially improving.
- **Rejected patterns are sticky.** Once Harry rejects a pattern suggestion, the detector never re-suggests the SAME pattern signature. If Harry wants to reverse a rejection, delete that row.
- **Privacy:** prompt summaries should not contain raw client data (specific prospect names, emails, sensitive details). Paraphrase to the abstract intent.
