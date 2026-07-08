# .claude/skills/

Vendored, third-party **Claude Skill** packages, kept as-is from their upstream source. This is a
different mechanism to `gtm-skills/`: files here follow Anthropic's official Skill format (`SKILL.md`
with YAML frontmatter, optional `scripts/`, `references/`, `agents/`, `assets/`) and are invocable
directly by the Skill tool. `gtm-skills/` is this OS's own flat-markdown convention for GTM domain
routing, loaded as context rather than executed.

**Current skills:**
- `skill-creator/` - Anthropic's official skill for creating, evaluating, and iterating on new Claude
  Skills. Sourced from [anthropics/skills](https://github.com/anthropics/skills), path
  `skills/skill-creator`, via sparse checkout. Apache 2.0, see `skill-creator/LICENSE.txt`.

**Rules for anything added here:**
- Keep vendored packages verbatim from upstream. Do not rewrite their content to match this repo's own
  house style (no-em-dash, etc.) - that would make future upstream syncs harder to diff. This is why
  `tests/ci/check-em-dash.sh` excludes `.claude/skills/**`.
- If you do modify a vendored file, note the change in the commit message (Apache 2.0 requires marking
  modified files) and consider whether it is better upstreamed instead.
- Record the source repo, path, and license in this file when you add a new one.
- `tests/ci/check-links.sh` does not scan this directory - its cross-reference rules are internal to
  each vendored skill, not this OS's shared-brain structure.
