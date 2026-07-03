# Agentic Framework

A portable, tool-agnostic framework of AI coding assistant instructions — agents, skills, guardrails, and workflows — deployable to Claude Code CLI and Gemini CLI via automated installers.

## Quick Start

```bash
# Clone or copy this framework
cd agentic-framework

# Install for Claude Code CLI
./install.sh --tool claude --target ~/projects/my-app

# Install for Gemini CLI
./install.sh --tool gemini --target ~/projects/my-app

# Install for both
./install.sh --tool all --target ~/projects/my-app
```

## What You Get

### For Claude Code CLI
```
my-app/
├── CLAUDE.md                    # Root instructions
└── .claude/
    ├── agents/                  # 10 specialist agents
    │   ├── analysis-expert.agent.md
    │   ├── plan-expert.agent.md
    │   ├── implement-expert.agent.md
    │   └── ...
    ├── skills/                  # 11 reusable skills
    │   ├── anti-hallucination/SKILL.md
    │   ├── green-coding/SKILL.md
    │   └── ...
    └── commands/                # Slash commands
        ├── review.md
        ├── plan.md
        └── explain.md
```

### For Gemini CLI
```
my-app/
├── GEMINI.md                   # Single compiled file (<800 lines)
└── .ai-framework/
    └── config/project.md       # Project settings
```

## What's Included

### Agents (10 archetypes)
| Agent | Purpose |
|-------|---------|
| `analysis-expert` | Codebase exploration and understanding |
| `plan-expert` | Implementation planning with step-by-step approach |
| `implement-expert` | Code writing following established patterns |
| `debug-expert` | Runtime issue diagnosis and resolution |
| `bug-rca-expert` | Root cause analysis for defects |
| `review-expert` | Code review with structured findings |
| `explain-expert` | Code explanation at calibrated depth |
| `test-design-expert` | Test case design using formal techniques |
| `spec-expert` | Requirements specification and gap analysis |
| `security-expert` | Security assessment and vulnerability analysis |

### Skills (11 modules)
| Skill | Activation |
|-------|-----------|
| `anti-hallucination` | Always active |
| `green-coding` | Always active |
| `transparent-reasoning` | Tier 2+ decisions |
| `exhaustive-analysis` | When completeness required |
| `white-box-tracing` | When tracing control/data flow |
| `test-case-design` | When writing tests |
| `error-handling` | When implementing recovery logic |
| `multi-agent-orchestration` | When designing agent workflows |
| `pr-diff-analyzer` | When reviewing PRs |
| `document-consolidation` | When merging documents |
| `workspace-search` | When searching codebases |

### Core Framework
- **Operational Doctrine** — System 2 thinking, YAGNI, task tiers (0-3)
- **Phase System** — Bootstrap → Checkpoint → Verification
- **Security Guardrails** — OWASP-aware, production-assumed
- **Anti-Hallucination** — Verify before claiming, cite sources

## Customization

### 1. Project Configuration
After installing, edit the project config:
```bash
# Claude
nano .claude/settings.json

# Gemini / Shared
nano .ai-framework/config/project.md
```

Fill in your project's technology stack, conventions, and team preferences.

### 2. Select Specific Agents
Don't need all agents? Install only what you use:
```bash
./install.sh --tool claude --agents analysis-expert,implement-expert,review-expert
```

### 3. Add Custom Agents
Create new agents following the template:
```bash
cp agents/_template.agent.md agents/my-custom-expert.agent.md
# Edit the file, then reinstall
./install.sh --tool claude --update
```

### 4. Add Custom Skills
```bash
mkdir skills/my-skill && cp skills/_template/SKILL.md skills/my-skill/
# Edit, then reinstall
```

## Updating

Refresh framework files without overwriting your project config:
```bash
./install.sh --tool all --target ~/projects/my-app --update
```

## Validation

Check if an installation is healthy:
```bash
./install.sh --tool claude --target ~/projects/my-app --check
```

## Architecture

```
agentic-framework/
├── install.sh              # Main entry point
├── installers/
│   ├── claude-code.sh      # Claude-specific deployment
│   └── gemini-cli.sh       # Gemini-specific compilation
├── core/
│   ├── doctrine.md         # Operational principles
│   ├── phases/             # Workflow phases
│   └── guardrails/         # Security, YAGNI, anti-hallucination
├── agents/                 # Agent definitions (tool-agnostic)
├── skills/                 # Skill definitions (tool-agnostic)
├── prompts/                # Reusable prompt templates
├── config/
│   ├── project.template.md # Blank template
│   └── project.example.md  # Filled example
└── docs/                   # Authoring guides
```

The framework is tool-agnostic at the source level. Installers handle adaptation to each tool's expected format.

## Documentation

- [Authoring Agents](docs/AUTHORING_AGENTS.md) — How to create new agents
- [Authoring Skills](docs/AUTHORING_SKILLS.md) — How to create new skills
- [Tool Differences](docs/TOOL_DIFFERENCES.md) — Capability matrix and workarounds

## Design Principles

1. **Source-once, deploy-many** — Write agents/skills once, install anywhere
2. **Modular by default** — Each agent and skill is independent
3. **YAGNI** — Include only what's needed, nothing speculative
4. **Tool-agnostic authoring** — No tool-specific syntax in source files
5. **Idempotent installs** — Safe to run multiple times
6. **Config never overwritten** — Project settings preserved on update

## License

MIT
