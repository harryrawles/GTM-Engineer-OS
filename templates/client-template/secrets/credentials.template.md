# Credentials - {{CLIENT_NAME}}

**SHAPE ONLY - do NOT put real keys in this template file.**

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
- **This key is consumed by `.claude/bin/instantly.sh`**, which reads `instantly_api_key` from this file
  for the active client (or an inline `--client` override) and calls the Instantly API v2 directly. The
  wrapper never prints the key, and raw `curl` to the API is blocked by `safety-guard.sh`. Keep the field
  name `instantly_api_key` exactly - the wrapper matches on it. See `sops/instantly-api.md`.
- The non-secret shape of these values is mirrored in `clients/{slug}/_config.md` (workspace URL/ID) - but
  the API key lives **only** here, in the git-ignored `secrets/` folder.
- To rotate: replace the value in `clients/{slug}/secrets/credentials.md`; no repo history is affected
  because the file is never tracked.
