# Tool Notes

Claude Code CLI capabilities and the conventions this framework relies on.

> This framework targets **Claude Code CLI** exclusively. Porting to another tool
> (e.g. VS Code Copilot's `.github/` layout) is possible by hand but not supported by
> the installer — see [Porting elsewhere](#porting-elsewhere).

## Deployment Model

| Aspect | Claude Code CLI |
|--------|----------------|
| Config format | `CLAUDE.md` + `.claude/` directory |
| Agent files | `.claude/agents/*.agent.md` |
| Skill files | `.claude/skills/*/SKILL.md` |
| Slash commands | `.claude/commands/*.md` |
| Persistent memory | `.claude/memory/*.md` (imported by `CLAUDE.md`) |
| Project config | `.ai-framework/config/project.md` (+ `.claude/settings.json` for tool permissions/model) |
| Size limit | No hard limit (modular) |

## Capabilities Used

| Capability | Claude Code | Notes |
|------------|:-----------:|-------|
| File read/write | ✅ | — |
| Terminal commands | ✅ | — |
| Multi-file edit | ✅ | — |
| Web search | ✅ | — |
| MCP servers | ✅ | Custom tools via MCP |
| Agent selection | ✅ | `/agent <name>`, or Claude detects from context |
| Modular instructions | ✅ | Separate files under `.claude/` |
| Slash commands | ✅ | `.claude/commands/<name>.md` → `/name` |
| Image understanding | ✅ | — |
| Parallel tool calls | ✅ | — |
| Cross-session memory | ⚠️ | No conversation memory; persist to `.claude/memory/` (see below) |

## How Claude Code Loads the Framework

- **Reads**: `CLAUDE.md` (root instructions) + files in the `.claude/` directory, plus the
  `@.claude/memory/*.md` files that `CLAUDE.md` imports.
- **Agent activation**: user types `/agent <name>`, or Claude detects the right agent from
  context (see Phase 0 in the doctrine).
- **Skill loading**: referenced agents/skills are loaded on demand from `.claude/skills/`.
- **Commands**: each `.claude/commands/<name>.md` becomes a `/name` slash command.
- **Settings**: `.claude/settings.json` for tool permissions and model selection.

## Memory Persistence

Claude Code has no conversation memory across sessions, so the framework persists knowledge
in **project-local files under `.claude/memory/`**, wired into Claude Code's *native* memory
(no bespoke store):

```
.claude/memory/
├── decisions.md      # Architecture decisions + rationale
├── patterns.md       # Discovered codebase patterns & conventions
└── glossary.md       # Domain term → codebase entity mappings
```

The installer seeds these (without overwriting existing content) and `CLAUDE.md` imports them
via `@.claude/memory/*.md`, so they are auto-loaded every session.

Agents recall from memory before working and append durable facts after (see
`phase-memory.md`). Per-task deliverables still go to `_local_specification/`, not memory.
You can add memory yourself with Claude Code's `#` shortcut or `/memory`.

## Porting elsewhere

The source files (`agents/`, `skills/`, `core/`) carry no Claude-specific syntax, so they can
be adapted to another assistant by hand — for example VS Code Copilot's `.github/` layout
(`.github/agents/`, `.github/skills/`, `.github/prompts/`, `.github/copilot-instructions.md`).
There is no installer for this; contributions welcome.
