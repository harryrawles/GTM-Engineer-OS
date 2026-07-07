# Hooks Setup

Four Claude Code hooks and one slash command ship with this OS. Once installed, they run automatically on every session.

---

## What the hooks do

| Hook | Fires on | What it does |
|------|----------|-------------|
| `safety-guard.sh` | Every tool call (PreToolUse) | Blocks dangerous operations before they execute. Hard block - exit code 2. Three layers: (1) for the **Instantly API wrapper** (`.claude/bin/instantly.sh`), gates by **HTTP verb** - `GET` and the read-only `POST /leads/list` pass; `POST`/`PATCH`/`PUT`/`DELETE` are blocked; raw `curl` to `api.instantly.ai` and printing a real `credentials.md` are blocked (key-leak protection). (2) For any residual **MCP** tool, matches on the **operation name** (the part after the last `__`) across namespaces. (3) Destructive bash (`rm -rf`, `git push --force`, `curl\|sh`, …). |
| `session-logger.sh` | Every event | (1) Logs events to `.claude/sessions/<session_id>.jsonl` (raw audit trail). (2) On UserPromptSubmit, appends one redacted `via:hook` row to the active client's `clients/{slug}/session-log.md` as a deterministic backstop for pattern-detector. |
| `session-start-context.sh` | SessionStart (`startup`) | Injects a one-line reminder to run the Session Start Protocol - resolve the active client and run `pattern-detector` first - so the auto-improvement loop isn't left to chance. |
| `notify.sh` | Stop, PermissionRequest, SessionStart, SessionEnd, SubagentStop | Desktop notification when Claude finishes or needs approval. macOS, Linux, and Windows. |

**Two logs, on purpose:** `clients/{slug}/session-log.md` is the per-client AI-readable skill-invocation log (read by pattern-detector). The `.claude/sessions/*.jsonl` files are the raw system audit trail (gitignored, stay local). Each skill writes its own rich session-log row at STEP 0; `session-logger.sh` adds a `via:hook` row as a backstop so the log is never empty even if a skill forgets. pattern-detector dedupes the two.

---

## What the slash command does

| Command | Trigger | What it does |
|---------|---------|-------------|
| `/gtm:compound` | "that worked" / "huge win" / manual | Captures a GTM win to `clients/{slug}/copy-library.md` and `clients/{slug}/decision-log.md` immediately using parallel subagents, while the context is fresh. Complements weekly-reviewer (which captures on Fridays). |

---

## Installation

The `.claude/` folder lives once at the repo root and is **shared across every client** - there is one
repo for the whole portfolio, so the hooks and the `/gtm:compound` command apply to whichever client is
active. Nothing to copy per client.

### Step 1 - Make hooks executable
```bash
chmod +x .claude/hooks/safety-guard.sh
chmod +x .claude/hooks/session-logger.sh
chmod +x .claude/hooks/session-start-context.sh
chmod +x .claude/hooks/notify.sh
chmod +x .claude/bin/instantly.sh    # Instantly API v2 wrapper (per-client keys)
```

> **Instantly is called via its API, not MCP.** `.claude/bin/instantly.sh` is the one sanctioned way to
> reach a client's workspace - it loads only the active client's key and keeps it out of logs. See
> `sops/instantly-api.md` and `MCP-SETUP.md` §1.

### Step 2 - Install jq (recommended)
```bash
brew install jq          # macOS
choco install jq         # Windows
sudo apt install jq      # Ubuntu/Debian
```
`jq` is **recommended but not required**. The hooks degrade gracefully without it: `safety-guard.sh` falls
back to a regex extract so it still blocks mutations (it never fails open), and the `via:hook` backstop
still writes. Only the raw `.claude/sessions/*.jsonl` audit trail needs `jq` - it is skipped cleanly when
`jq` is absent, never writing malformed lines.

### Step 3 - Verify hooks are firing
Open the repo in Claude Code and run any command. Then:
```bash
ls .claude/sessions/          # a <session_id>.jsonl should appear (requires jq)
```
If nothing appears: check `jq` is installed and the scripts are executable.

### Step 4 - No tool-name customisation needed
Unlike earlier versions, the safety guard **no longer** hard-codes fully-qualified tool names. It matches
on the operation (everything after the last `__`), so it works across both connected Instantly namespaces
(`mcp__…DPS_Instantly__…`, `mcp__…Verity_Instantly_account__…`) and Slack/Stripe out of the box. To gate a
**new** mutating operation, add its operation name (no namespace) to the `BLOCKED_OPS` array in
`.claude/hooks/safety-guard.sh`. Read-only operations (`list_`/`get_`/`analytics_`/`count_`/`search_`/`*_status`)
are never listed, so reads stay automatic.

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Hook not firing | Verify `.claude/settings.json` exists at project root. Verify scripts are executable. |
| No `.jsonl` audit files | Install jq (see Step 2). The safety guard and the `via:hook` backstop still work without it. |
| Notifications not showing on Windows | Requires PowerShell accessible from bash (`powershell.exe`). Fails silently if unavailable - non-fatal. |
| Safety guard blocking something it should not | Remove that operation name from `BLOCKED_OPS` in `safety-guard.sh` (or confirm it's genuinely a read). |
| Safety guard NOT blocking something it should | Add the operation name (the part after the last `__`, no namespace) to `BLOCKED_OPS` in `safety-guard.sh`. Regression-tested by `tests/ci/test-safety-guard.sh`. |
