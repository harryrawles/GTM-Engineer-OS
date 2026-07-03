# Hooks Setup

Three production-ready Claude Code hooks and one slash command ship with this OS. Once installed, they run automatically on every session.

---

## What the hooks do

| Hook | Fires on | What it does |
|------|----------|-------------|
| `safety-guard.sh` | Every tool call (PreToolUse) | Blocks dangerous Instantly mutations, external sends, and destructive bash commands before they execute. Hard block — exit code 2. |
| `session-logger.sh` | Every event | Logs tool calls, prompts, failures, compaction snapshots, and session summaries to `.claude/sessions/<session_id>.jsonl`. Unconditional — cannot be skipped by a skill. |
| `notify.sh` | Stop, PermissionRequest, SessionStart, SessionEnd | Desktop notification when Claude finishes or needs approval. macOS, Linux, and Windows. |

**Distinction from session-log.md:** `clients/{slug}/session-log.md` is the per-client AI-readable skill invocation log (read by pattern-detector). `.claude/sessions/` JSONL files are the raw system audit trail. Both run in parallel. The JSONL files are gitignored — they stay local.

---

## What the slash command does

| Command | Trigger | What it does |
|---------|---------|-------------|
| `/gtm:compound` | "that worked" / "huge win" / manual | Captures a GTM win to `clients/{slug}/copy-library.md` and `clients/{slug}/decision-log.md` immediately using parallel subagents, while the context is fresh. Complements weekly-reviewer (which captures on Fridays). |

---

## Installation

The `.claude/` folder lives once at the repo root and is **shared across every client** — there is one
repo for the whole portfolio, so the hooks and the `/gtm:compound` command apply to whichever client is
active. Nothing to copy per client.

### Step 1 — Make hooks executable
```bash
chmod +x .claude/hooks/safety-guard.sh
chmod +x .claude/hooks/session-logger.sh
chmod +x .claude/hooks/notify.sh
```

### Step 2 — Install jq
The hooks require `jq` for JSON parsing.
```bash
brew install jq          # macOS
choco install jq         # Windows
sudo apt install jq      # Ubuntu/Debian
```

### Step 3 — Verify hooks are firing
Open the repo in Claude Code and run any command. Then:
```bash
ls .claude/sessions/
```
A `.jsonl` file should appear for the current session. If not: check `jq` is installed and scripts are executable.

### Step 4 — Customise the Instantly tool names
The safety guard blocks `mcp__instantly__*` tool names. Confirm exact names match your Instantly MCP:
```
Ask Claude Code: "List all available Instantly MCP tools"
```
Update the `BLOCKED_TOOLS` array in `.claude/hooks/safety-guard.sh` to match.

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Hook not firing | Verify `.claude/settings.json` exists at project root. Verify scripts are executable. |
| "jq: command not found" | Install jq (see Step 2) |
| Notifications not showing on Windows | Requires PowerShell accessible from bash (`powershell.exe`). Fails silently if unavailable — non-fatal. |
| Safety guard blocking something it should not | Remove the tool name from BLOCKED_TOOLS in safety-guard.sh |
| Safety guard NOT blocking something it should | The Instantly MCP tool name differs — ask Claude to list tools and update BLOCKED_TOOLS |