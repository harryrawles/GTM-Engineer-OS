# MCP Setup

Step-by-step guide for connecting the MCPs required to operate the OS. This is a **multi-client** OS: each
client has its **own** Instantly workspace + API key. When a client is active, always target **that
client's** workspace (from `clients/{slug}/secrets/credentials.md`). Never share one API key across clients.

**Required MCPs:**
- Instantly (the active client's workspace — one connection per client)
- Notion (Harry's personal workspace)

**Optional MCPs:**
- Clay (for enrichment, if used for this client)
- Slack (for alerts, if integrated)

---

## 1. Instantly MCP

The most important connection. Without it, the weekly-reviewer and report-writer cannot pull live metrics.

### Setup steps

1. **Get this client's Instantly API key:**
   - Log in to the client's Instantly workspace
   - Settings → API Keys
   - Generate a new key labelled "Claude Code MCP — {{CLIENT_NAME}}"
   - Store it in **`clients/{slug}/secrets/credentials.md`** (git-ignored — see `.gitignore` →
     `clients/*/secrets/`). Optionally mirror to 1Password under "Instantly — {{CLIENT_NAME}}".
   - **Never commit the key.** Never paste it into `_config.md` or any tracked file. Never print the full
     key in chat.

2. **Add the MCP to Claude Code:**
   - Open Claude Code settings
   - Add the MCP server with a **client-distinct name** (e.g. `instantly-{slug}`), NOT a generic `instantly`. When more than one client's Instantly workspace is connected, the tool names differ only by this server prefix (`mcp__<server>__…`), and that prefix is how a skill targets the right workspace.
   - Type: HTTP
   - Workspace URL: see `clients/{slug}/_config.md → instantly_workspace_url`
   - API key: paste from `clients/{slug}/secrets/credentials.md`
   - Record the server name in `clients/{slug}/_config.md → instantly_mcp_server` so skills know which server maps to this client.

3. **Verify the connection:**
   ```
   List all campaigns in Instantly for {{CLIENT_NAME}}
   ```
   Expected: a list of campaigns with names, sends, reply rates. If error → check API key and workspace URL.

4. **Update `clients/{slug}/_config.md`:**
   - Set `mcp_connected: true`
   - Set `instantly_workspace_id: [paste from URL]`
   - Set `instantly_mcp_server: [the client-distinct server name you chose above]`

### What this MCP enables

- weekly-reviewer pulls last 7 days of data per campaign
- campaign-optimiser pulls metrics for diagnosis
- client-report-writer populates the weekly report
- campaign-analyst surfaces performance trends

---

## 2. Notion MCP

For client briefs, call notes, and context.

### Setup steps

1. **Authorise Notion:**
   - In Claude Code MCP settings, add `notion`
   - Type: HTTP / OAuth
   - Follow OAuth flow to authorise Harry's Notion workspace

2. **Verify:**
   ```
   Search Notion for {{CLIENT_NAME}} page
   ```
   Expected: returns Harry's client page in Notion.

3. **Optional — pin the client's Notion page URL** in `clients/{slug}/overview.md` under "External resources."

---

## 3. Clay MCP (optional)

Only if Clay is used for enrichment on this client.

### Setup steps

1. Get Clay API key from Clay settings
2. Store in 1Password under "Clay — {{CLIENT_NAME}}"
3. Add `clay` MCP in Claude Code settings
4. Update `clients/{slug}/campaign-state.md` "Tools & Tech Stack" section to mark Clay as connected

### What this enables

- personalization-strategist can generate Clay prompts directly
- signal-sourcer can recommend Clay-based detection workflows

---

## 4. Slack MCP (optional)

Only if Harry uses Slack for client comms or alerts.

### Setup steps

1. Add Slack app to Harry's workspace (or the client's, if shared)
2. Authorise via OAuth in Claude Code
3. Configure alert channels in `clients/{slug}/overview.md`

---

## Troubleshooting

### Instantly MCP returns 401 / unauthorised
- API key expired or revoked. Regenerate.
- Wrong workspace. Verify `instantly_workspace_id` in config.

### Instantly returns empty campaign list
- API key may not have campaign read permission. Check API key scope in Instantly settings.

### MCP server not appearing in Claude Code
- Restart Claude Code after adding.
- Check MCP server logs in Claude Code settings.

### Multiple clients confused (data crossover)
- Each client should have its own Instantly MCP connection. Do NOT share a single API key across clients.
- Use the workspace URL in `clients/{slug}/_config.md` to verify which client Claude is working on.
- With multiple Instantly workspaces connected, always call the server named in `clients/{slug}/_config.md → instantly_mcp_server`. A generic "the Instantly MCP" is ambiguous when several are mounted (e.g. two servers with `mcp__…Instantly…__` prefixes) and can hit the wrong workspace.

---

## Security

- **API keys live only in `clients/{slug}/secrets/credentials.md`** (git-ignored) — never in any tracked
  file or comment. Mirror to 1Password if you like. The only tracked secrets file is the shape-only
  `templates/client-template/secrets/credentials.template.md`.
- **One Instantly MCP connection per client.** No shared credentials, ever.
- **Rotate API keys quarterly** or after any team change.
- **Review MCP access list monthly** — remove any no-longer-needed connections.

---

## What happens if MCP is not connected

The OS still works in degraded mode:
- weekly-reviewer will ask Harry to paste metrics
- campaign-optimiser will request data manually
- client-report-writer will need a Postman / spreadsheet export

But the friction is high. Connecting Instantly MCP is the single biggest time saver after onboarding.