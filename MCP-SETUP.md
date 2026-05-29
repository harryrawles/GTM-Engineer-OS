# MCP Setup

Step-by-step guide for connecting the MCPs required to operate this client OS.

**Required MCPs:**
- Instantly (this client's workspace)
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
   - **Copy to 1Password** under "Instantly — {{CLIENT_NAME}}"
   - **Never commit to the repo**

2. **Add the MCP to Claude Code:**
   - Open Claude Code settings
   - Add MCP server: `instantly`
   - Type: HTTP
   - Workspace URL: see `company/_config.md → instantly_workspace_url`
   - API key: paste from 1Password

3. **Verify the connection:**
   ```
   List all campaigns in Instantly for {{CLIENT_NAME}}
   ```
   Expected: a list of campaigns with names, sends, reply rates. If error → check API key and workspace URL.

4. **Update `company/_config.md`:**
   - Set `mcp_connected: true`
   - Set `instantly_workspace_id: [paste from URL]`

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

3. **Optional — pin the client's Notion page URL** in `company/overview.md` under "External resources."

---

## 3. Clay MCP (optional)

Only if Clay is used for enrichment on this client.

### Setup steps

1. Get Clay API key from Clay settings
2. Store in 1Password under "Clay — {{CLIENT_NAME}}"
3. Add `clay` MCP in Claude Code settings
4. Update `company/campaign-state.md` "Tools & Tech Stack" section to mark Clay as connected

### What this enables

- personalization-strategist can generate Clay prompts directly
- signal-sourcer can recommend Clay-based detection workflows

---

## 4. Slack MCP (optional)

Only if Harry uses Slack for client comms or alerts.

### Setup steps

1. Add Slack app to Harry's workspace (or the client's, if shared)
2. Authorise via OAuth in Claude Code
3. Configure alert channels in `company/overview.md`

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
- Use the workspace URL in `company/_config.md` to verify which client Claude is working on.

---

## Security

- **All API keys in 1Password.** Never paste into the repo, not even in comments.
- **One Instantly MCP connection per client.** No shared credentials.
- **Rotate API keys quarterly** or after any team change.
- **Review MCP access list monthly** — remove any no-longer-needed connections.

---

## What happens if MCP is not connected

The OS still works in degraded mode:
- weekly-reviewer will ask Harry to paste metrics
- campaign-optimiser will request data manually
- client-report-writer will need a Postman / spreadsheet export

But the friction is high. Connecting Instantly MCP is the single biggest time saver after onboarding.