# Integrations Setup (Instantly API + optional MCPs)

How to connect the integrations the OS uses. **Instantly is now called directly via its v2 API, per
client - not via MCP.** Each client has its own Instantly workspace + API key; when a client is active,
the OS uses **that client's** key (from `clients/{slug}/secrets/credentials.md`). Never share one key
across clients.

**Connections:**
- **Instantly API v2** - required. Per-client API key. See §1 and `sops/instantly-api.md`.
- **Notion MCP** - optional (client briefs / call notes).
- **Clay MCP** - optional (enrichment).
- **Slack MCP** - optional (alerts / comms). Sends are gated by `safety-guard.sh`.

---

## 1. Instantly API v2 (per client - the important one)

Without this, `weekly-reviewer`, `campaign-optimiser`, and `client-report-writer` can't pull live metrics.

There is **no MCP server to add**. The OS calls `https://api.instantly.ai/api/v2` through one wrapper,
`.claude/bin/instantly.sh`, which loads the active client's key and keeps it out of logs. Setup is just:
store the key.

### Setup steps (once per client)

1. **Generate this client's Instantly API key:**
   - Log in to the **client's** Instantly workspace → Settings → API Keys
   - Generate a new key labelled `Claude Code - {{CLIENT_NAME}}`
   - Scope it: campaign + analytics **read** at minimum; add lead/campaign **write** only if you want the
     OS to action changes directly (writes are still gated by the safety guard).

2. **Store it (git-ignored):**
   - Paste it into `clients/{slug}/secrets/credentials.md → instantly_api_key`
     (git-ignored via `.gitignore → clients/*/secrets/`). Optionally mirror to 1Password.
   - **Never** paste it into `_config.md` or any tracked file. **Never** print the full key in chat.

3. **Record the non-secret shape** in `clients/{slug}/_config.md`:
   - `instantly_workspace_url`, `instantly_workspace_id`
   - `instantly_api_configured: true`

4. **Verify:**
   ```
   switch to {{CLIENT_NAME}}
   .claude/bin/instantly.sh GET /campaigns
   ```
   Expected: a campaign list and a trailing `[HTTP 200]`. `401` → key wrong/revoked/insufficient scope.

### What this enables

- `weekly-reviewer` pulls last 7 days per campaign · `campaign-optimiser` pulls metrics for diagnosis ·
  `client-report-writer` populates the weekly report · `campaign-analyst` surfaces trends.

### How isolation is guaranteed

- The wrapper uses **only the active client's** key (or an explicit `--client SLUG`). One key per call.
- Switching clients (`switch to {client}`) switches the key automatically - there is no shared connection
  and no "wrong workspace" ambiguity, because the key *is* the workspace selector.
- Raw `curl` to `api.instantly.ai` is blocked by `safety-guard.sh` (it would leak the key); everything
  goes through the wrapper.

Full endpoint list + read/write map: **`sops/instantly-api.md`**.

---

## 2. Notion MCP (optional)

For client briefs, call notes, and context.

1. In Claude Code MCP settings, add `notion` (Type: HTTP / OAuth) and complete the OAuth flow for Harry's
   Notion workspace.
2. Verify: `Search Notion for {{CLIENT_NAME}} page` → returns the client page.
3. Optional - pin the client's Notion page URL in `clients/{slug}/overview.md` under "External resources."

---

## 3. Clay MCP (optional)

Only if Clay is used for enrichment on this client.

1. Get the Clay API key from Clay settings; store in 1Password under "Clay - {{CLIENT_NAME}}".
2. Add the `clay` MCP in Claude Code settings.
3. Mark Clay connected in `clients/{slug}/campaign-state.md` "Tools & Tech Stack".

Enables: `personalization-strategist` Clay prompts, `signal-sourcer` Clay detection workflows.

---

## 4. Slack MCP (optional)

Only if Harry uses Slack for client comms or alerts.

1. Add the Slack app to the workspace; authorise via OAuth in Claude Code.
2. Configure alert channels in `clients/{slug}/overview.md`.

Note: Slack **sends** (`slack_send_message`, `slack_schedule_message`, …) are blocked by
`safety-guard.sh` until Harry approves - reads are automatic.

---

## Troubleshooting

### Instantly returns `[HTTP 401]` / unauthorised
- Key expired, revoked, or wrong. Regenerate and update `clients/{slug}/secrets/credentials.md`.

### Instantly returns an empty campaign list
- Key may lack campaign-read scope. Check the key's scopes in Instantly settings.

### `instantly.sh` says "no active client" or "no credentials file"
- Run `switch to {client}` first, and confirm the client was onboarded (its `secrets/credentials.md` exists
  with a real `instantly_api_key`, not a `{{placeholder}}`).

### Worried about hitting the wrong client's workspace
- You can't share a key here - the wrapper only ever loads the active client's (or `--client`) key. Confirm
  the active client (`_state/active-client`) and, if in doubt, pass `--client SLUG` explicitly.

---

## Security

- **API keys live only in `clients/{slug}/secrets/credentials.md`** (git-ignored) - never in any tracked
  file. The only tracked secrets file is the shape-only `templates/client-template/secrets/credentials.template.md`.
- **One key per client.** No shared credentials, ever. The wrapper enforces this by construction.
- **The key never appears in logs.** The wrapper passes it to curl via stdin config; raw curl to the API
  is blocked; printing a real `credentials.md` via bash is blocked.
- **Rotate API keys quarterly** or after any team change - just replace the value in the secrets file.
- **Review API-key scopes** periodically; revoke keys for offboarded clients (see `client-offboarder`).

---

## What happens if the key is not set

The OS still works in degraded mode:
- `weekly-reviewer` / `campaign-optimiser` / `client-report-writer` will ask Harry to paste metrics.

But friction is high. Setting the per-client Instantly key is the single biggest time-saver after onboarding.
