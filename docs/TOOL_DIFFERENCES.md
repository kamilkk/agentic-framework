# Tool Differences

Capability matrix and workarounds across Claude Code CLI, Gemini CLI, and VS Code Copilot.

## Deployment Model

| Aspect | Claude Code CLI | Gemini CLI | VS Code Copilot |
|--------|----------------|------------|-----------------|
| Config format | CLAUDE.md + .claude/ directory | Single GEMINI.md | .github/ directory |
| Agent files | `.claude/agents/*.agent.md` | Compiled into GEMINI.md | `.github/agents/*.agent.md` |
| Skill files | `.claude/skills/*/SKILL.md` | Compiled into GEMINI.md | `.github/skills/*/SKILL.md` |
| Slash commands | `.claude/commands/*.md` | Not supported | `.github/prompts/*.prompt.md` |
| Project config | `.claude/settings.json` | GEMINI.md inline | `.github/copilot-instructions.md` |
| Size limit | No hard limit (modular) | ~800 lines recommended | No hard limit (modular) |

## Capability Matrix

| Capability | Claude Code | Gemini CLI | Workaround for gaps |
|------------|:-----------:|:----------:|---------------------|
| File read/write | ✅ | ✅ | — |
| Terminal commands | ✅ | ✅ | — |
| Multi-file edit | ✅ | ✅ | — |
| Web search | ✅ | ✅ | — |
| MCP servers | ✅ | ✅ | — |
| Agent selection (UI) | ✅ via /agent | ❌ | Describe agent role in prompt |
| Modular instructions | ✅ separate files | ❌ single file | Compile to flat file |
| Slash commands | ✅ | ❌ | Paste prompt manually |
| Image understanding | ✅ | ✅ | — |
| Conversation memory | Session only | Session only | Use memory files |
| Custom tools | Via MCP | Via MCP | — |
| Parallel tool calls | ✅ | ✅ | — |

## Architecture Differences

### Claude Code CLI
- **Reads**: `CLAUDE.md` (root instructions) + all files in `.claude/` directory
- **Agent activation**: User types `/agent <name>` or Claude detects from context
- **Skill loading**: Referenced agents/skills are loaded on demand from `.claude/skills/`
- **Commands**: `.claude/commands/<name>.md` files become `/name` slash commands
- **Settings**: `.claude/settings.json` for tool permissions, model selection

### Gemini CLI
- **Reads**: `GEMINI.md` from project root (single file, fully self-contained)
- **Agent activation**: Must match from prompt context (no explicit agent switching)
- **Skill loading**: All skills baked into the single file (always available)
- **Commands**: Not supported — use prompt templates pasted manually
- **Settings**: `.gemini/settings.json` for API key and model

## Adaptation Strategies

### Agent Activation Without UI Selection (Gemini)
Since Gemini has no `/agent` command, agents activate via pattern matching in the prompt:

```
Claude: /agent review-expert "Review this PR"
Gemini: "Acting as the code review expert, review this PR"
```

The compiled GEMINI.md includes activation hints like:
> "When asked to review code, adopt the Review Expert methodology..."

### Slash Commands Without Support (Gemini)
For Gemini, keep a `prompts/` directory in your project with `.md` templates you can paste:

```bash
# Quick usage
cat prompts/architecture-review.md | pbcopy
# Then paste into Gemini prompt
```

### Modular Skills in Flat File (Gemini)
The Gemini installer compiles skills into compact bullet points. If you need the full skill detail for a specific task, tell Gemini:

> "Apply the exhaustive-analysis approach: batch process all items, track progress, verify 100% coverage."

### Memory Persistence (Both)
Neither tool has cross-session memory. Use project-local files:

```
.ai-memory/
├── decisions.md      # Architecture decisions made
├── patterns.md       # Discovered codebase patterns
└── session-notes.md  # Current task context
```

Reference in your instructions: "Check .ai-memory/ for prior decisions before suggesting changes."

## Migration Between Tools

### Claude → Gemini
Run the Gemini installer on the same project. It reads from the same source framework and generates GEMINI.md. Both can coexist:

```bash
./install.sh --tool all --target ~/my-project
```

### Gemini → Claude
Run the Claude installer. It creates the `.claude/` directory structure alongside your existing GEMINI.md.

### Either → VS Code Copilot
Manually copy to `.github/` structure or create a Copilot installer (contribution welcome).

## Known Limitations

| Tool | Limitation | Impact | Mitigation |
|------|-----------|--------|------------|
| Gemini | No agent switching | Can't isolate agent context | Use clear role descriptions in prompt |
| Gemini | Single file limit | Large frameworks get truncated | Keep under 800 lines, prioritize agents |
| Claude | No cross-session memory | Loses context between sessions | Use .ai-memory/ files |
| Both | No IDE integration | Can't see diagnostics/errors directly | Use terminal commands for error output |
