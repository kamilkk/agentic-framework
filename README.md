# Agentic Framework

A framework of AI coding assistant instructions for Claude Code CLI — agents, skills, guardrails, and workflows — deployed via an automated installer.

## Quick Start

```bash
# Clone or copy this framework
cd agentic-framework

# Install for Claude Code CLI
./install.sh --target ~/projects/my-app
```

**Recommended first step:** open Claude Code inside the target project and run `/project-profiler`. It inspects the codebase and asks you a few questions to fill in `.ai-framework/config/project.md` — the project profile every agent reads. The rest of the framework works with an empty profile, but agents are far more accurate once it's populated.

## What You Get

```
my-app/
├── CLAUDE.md                    # Root instructions
└── .claude/
    ├── agents/                  # 11 specialist agents
    │   ├── analysis-expert.agent.md
    │   ├── plan-expert.agent.md
    │   ├── implement-expert.agent.md
    │   └── ...
    ├── skills/                  # 26 reusable skills
    │   ├── anti-hallucination/SKILL.md
    │   ├── code-review/SKILL.md
    │   ├── tdd (merged into test-case-design)
    │   └── ...
    ├── commands/                # Slash commands
    │   ├── review.md
    │   ├── plan.md
    │   └── explain.md
    └── memory/                  # Persistent memory (imported by CLAUDE.md)
        ├── decisions.md         # Architecture decisions + rationale
        ├── patterns.md          # Discovered patterns & conventions
        └── glossary.md          # Domain term → entity mappings
```

## What's Included

### Agents (11 archetypes)
| Agent | Purpose |
|-------|---------|
| `project-profiler-expert` | Inspects the codebase + interviews you to fill `.ai-framework/config/project.md` (`/project-profiler`) |
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

### Core Skills (11 modules)
| Skill | Activation |
|-------|-----------|
| `anti-hallucination` | Always active |
| `green-coding` | Always active |
| `transparent-reasoning` | Tier 2+ decisions |
| `exhaustive-analysis` | When completeness required |
| `white-box-tracing` | When tracing control/data flow |
| `test-case-design` | When writing tests (now includes TDD / red-green) |
| `error-handling` | When implementing recovery logic |
| `multi-agent-orchestration` | When designing agent workflows |
| `pr-diff-analyzer` | When reviewing PRs |
| `document-consolidation` | When merging documents |
| `workspace-search` | When searching codebases |

### Engineering Workflow Skills (15 modules, adapted from [mattpocock/skills](https://github.com/mattpocock/skills), MIT)

Adapted into the framework's hybrid skill format (standard Claude frontmatter + the house `## Metadata`/`## Purpose` markers the installer reads). Companion reference files from the originals are inlined as appendices so each skill remains a single self-contained `SKILL.md`.

| Skill | Activation | Pairs with agent |
|-------|-----------|------------------|
| `codebase-design` | Designing deep modules (module/interface/seam/depth vocabulary) | `plan-expert`, `implement-expert` |
| `domain-modeling` | Building/sharpening the domain model, `CONTEXT.md`, ADRs | `spec-expert`, `analysis-expert` |
| `grilling` | Relentless clarifying interview to stress-test thinking | `spec-expert`, `plan-expert` |
| `grill-with-docs` | Grilling that also produces ADRs + glossary as you go | `spec-expert` |
| `research` | Delegating primary-source research to a background agent | `analysis-expert` |
| `prototype` | Throwaway logic/UI prototypes to answer a design question | `plan-expert` |
| `to-spec` | Synthesizing a conversation into a published spec | `spec-expert` |
| `to-tickets` | Breaking a plan/spec into tracer-bullet tickets w/ blocking edges | `plan-expert` |
| `wayfinder` | Mapping work too large for one session as decision tickets | `plan-expert` |
| `implement` | Implementing a spec/tickets test-first, then reviewing | `implement-expert` |
| `code-review` | Two-axis (Standards + Spec) review since a fixed point | `review-expert` |
| `diagnosing-bugs` | Feedback-loop-first diagnosis of hard bugs / perf regressions | `debug-expert`, `bug-rca-expert` |
| `triage` | Moving issues/PRs through a triage state machine | `review-expert` |
| `improve-codebase-architecture` | Surveying for deepening opportunities (HTML report) | `analysis-expert` |
| `resolving-merge-conflicts` | Resolving in-progress merge/rebase conflicts | `implement-expert` |

> Note: `code-review`, `to-spec`, `to-tickets`, and `triage` originally depended on mattpocock's `/setup-matt-pocock-skills` command to configure an issue tracker and label vocabulary. Those references were softened to point at this project's own config (`.ai-framework/config/project.md`) or to ask the user, so the skills are self-contained here.

### Core Framework
- **Operational Doctrine** — System 2 thinking, YAGNI, task tiers (0-3)
- **Phase System** — Bootstrap → Checkpoint → Verification
- **Security Guardrails** — OWASP-aware, production-assumed
- **Anti-Hallucination** — Verify before claiming, cite sources
- **Concise Output by Default** — user-facing chat is compressed ("caveman") style; deliverables stay full-fidelity (see below)

### Output Style — Concise by Default ("Caveman")

An always-active doctrine rule (`core/doctrine.md`) makes agents write **user-facing chat output** in a compressed, low-token style: no filler, hedging, pleasantries, or tool-call narration, while all technical substance — code, numbers, units, API names, exact error strings, negations — is kept verbatim. Required scaffolding (checkpoints, ADRs, confidence levels, security/irreversible-action warnings) stays intact; only its prose is tightened.

**Scope — chat only.** The rule never touches files written to disk. Deliverables in `_local_specification/` (SPEC/ANALYSIS/PLAN/RCA/FIX/TC/EXPLANATION), memory (`.claude/memory/`), the project config, source code, comments, and commit messages are generated at full fidelity, exactly as before. Compression is off whenever output goes to a file or to another agent.

**Verbose override.** For that turn's chat prose, agents return to normal complete-sentence style when your message matches any of:
- `explain [something]`
- `describe [something] in detail(s)`
- `[something] is unclear` (also `clarify`, "I don't understand")

The override affects only how the agent talks to you; the next turn returns to concise unless you keep triggering it or ask to stay verbose. Because deliverables are always full-fidelity, this override changes nothing about generated documents.

## Customization

### 1. Project Configuration
After installing, edit the project config:
```bash
nano .ai-framework/config/project.md
```

Fill in your project's technology stack, conventions, and team preferences.

### 2. Select Specific Agents
Don't need all agents? Install only what you use:
```bash
./install.sh --agents analysis-expert,implement-expert,review-expert
```

### 3. Add Custom Agents
Create new agents following the template:
```bash
cp agents/_template.agent.md agents/my-custom-expert.agent.md
# Edit the file, then reinstall
./install.sh --update
```

### 4. Add Custom Skills
```bash
mkdir skills/my-skill && cp skills/_template/SKILL.md skills/my-skill/
# Edit, then reinstall
```

## Updating

Refresh framework files without overwriting your project config:
```bash
./install.sh --target ~/projects/my-app --update
```

## Validation

Check if an installation is healthy:
```bash
./install.sh --target ~/projects/my-app --check
```

## Architecture

```
agentic-framework/
├── install.sh              # Main entry point
├── installers/
│   └── claude-code.sh      # Claude Code deployment
├── core/
│   ├── doctrine.md         # Operational principles
│   ├── phases/             # Workflow phases
│   └── guardrails/         # Security, YAGNI, anti-hallucination
├── agents/                 # Agent definitions
├── skills/                 # Skill definitions
├── prompts/                # Reusable prompt templates
├── config/
│   └── project.template.md # Blank project profile (deployed, then filled by /project-profiler)
└── docs/                   # Authoring guides
```

Source files live in this repo; the installer deploys them into a project's `.claude/` directory and generates `CLAUDE.md`.

## Documentation

- [Authoring Agents](docs/AUTHORING_AGENTS.md) — How to create new agents
- [Authoring Skills](docs/AUTHORING_SKILLS.md) — How to create new skills
- [Tool Notes](docs/TOOL_DIFFERENCES.md) — Claude Code capabilities and conventions

## Design Principles

1. **Source-once, deploy-many** — Write agents/skills once, install into any project
2. **Modular by default** — Each agent and skill is independent
3. **YAGNI** — Include only what's needed, nothing speculative
4. **Source/deploy separation** — Author in the repo; the installer produces the `.claude/` layout
5. **Idempotent installs** — Safe to run multiple times
6. **Config never overwritten** — Project settings preserved on update

## Attribution

The 15 engineering-workflow skills listed above are adapted from
[mattpocock/skills](https://github.com/mattpocock/skills) by Matt Pocock, used under the
MIT License. Each adapted `SKILL.md` carries a `Source` line in its `## Metadata` block
pointing back to the original. The TDD content merged into `test-case-design` comes from the
same source. Content was reformatted to the framework's hybrid skill format and cross-references
were rewired to framework conventions; the substance is Matt Pocock's.

## License

MIT
