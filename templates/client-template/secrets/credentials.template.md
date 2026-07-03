# Credentials — {{CLIENT_NAME}}

**SHAPE ONLY — do NOT put real keys in this template file.**

When a client is created (`templates/client-template/` → `clients/{slug}/`), this file becomes
`clients/{slug}/secrets/credentials.md`, which is **git-ignored** (`.gitignore` → `clients/*/secrets/`).
Fill the real values there, never here.

> ⚠️ Never commit real credentials. Never print a full API key in chat. If any action would commit a
> secret, stop and warn immediately (see root `CLAUDE.md` → Safety Guard).

---

## Instantly

| Key | Value |
|-----|-------|
| `instantly_api_key` | {{INSTANTLY_API_KEY}} |
| `workspace_id` | {{INSTANTLY_WORKSPACE_ID}} |
| `workspace_url` | {{INSTANTLY_WORKSPACE_URL}} |

---

## Notes

- Each client has its **own** Instantly workspace + API key. Never reuse one client's key for another.
- The non-secret shape of these values is mirrored in `clients/{slug}/_config.md` (workspace URL/ID,
  `mcp_connected`) — but the API key lives **only** here, in the git-ignored `secrets/` folder.
- To rotate: replace the value in `clients/{slug}/secrets/credentials.md`; no repo history is affected
  because the file is never tracked.
