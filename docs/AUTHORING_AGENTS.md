# Authoring Agents

This guide covers creating custom agents for the agentic framework.

## File Location

- Source: `agents/<name>.agent.md`
- Claude deployment: `.claude/agents/<name>.agent.md`
- Gemini deployment: Compiled into GEMINI.md agents section

## Structure

Use `agents/_template.agent.md` as your starting point. Every agent file follows this structure:

```markdown
# Agent Name

## Core Mission
One paragraph describing what this agent does and when it activates.

## Core Constraint
⛔ The one thing this agent must NEVER do.

## Methodology
### Phase 1: [First Phase]
Steps...

### Phase 2: [Second Phase]
Steps...

## Output Contract
What the agent produces — format, file naming, structure.

## Quality Gate
Checklist the agent applies before delivering output.
```

## Design Principles

### 1. Single Responsibility
Each agent handles ONE type of task. If you find yourself writing "and also..." you need two agents.

### 2. Clear Activation Trigger
The Core Mission must make it obvious WHEN this agent should activate. Think: "If the user says X, this agent handles it."

### 3. Constraint-First
The Core Constraint prevents scope creep. Examples:
- Analysis agent: "Never suggest fixes"
- Plan agent: "Never write implementation code"
- Debug agent: "Never refactor unrelated code"

### 4. Phase Gates
Each methodology phase should produce a verifiable artifact before proceeding to the next phase.

### 5. Tool-Agnostic
Write agents without referencing specific tool capabilities. The installer handles adaptation:
- Claude: Each agent becomes a separate file in `.claude/agents/`
- Gemini: Agents are compiled into sections of GEMINI.md

## Example: Creating a Migration Agent

```markdown
# Database Migration Expert

## Core Mission
Analyze database schema changes, generate migration scripts, and verify data integrity for schema evolution tasks.

## Core Constraint
⛔ Never execute migrations directly. Only generate scripts for human review.

## Methodology
### Phase 1: Schema Diff
- Read current schema from migration history
- Compare with target state from requirements
- Identify: additions, removals, renames, type changes

### Phase 2: Migration Script
- Generate forward migration (UP)
- Generate rollback migration (DOWN)
- Include data transformation for non-trivial changes

### Phase 3: Impact Analysis
- Identify affected queries, indexes, and constraints
- Flag potential data loss scenarios
- Estimate migration duration for large tables

## Output Contract
File: `_local_specification/MIGRATION-[YYYYMMDD]-[slug].md`
Contains: Schema diff, UP script, DOWN script, impact notes.

## Quality Gate
- [ ] Rollback script reverses all changes
- [ ] No data loss without explicit user confirmation
- [ ] Foreign keys and indexes maintained
- [ ] Idempotent (safe to run multiple times)
```

## Naming Conventions

| Pattern | Example | Purpose |
|---------|---------|---------|
| `<domain>-expert` | `security-expert` | Domain specialist |
| `<action>-expert` | `review-expert` | Task specialist |
| `<domain>-<action>-expert` | `bug-rca-expert` | Narrow specialist |

## Testing Your Agent

1. Install to a test project: `./install.sh --tool claude --target /tmp/test --agents your-agent`
2. Open the project with Claude Code
3. Ask a question that should trigger your agent
4. Verify: Does it follow the methodology? Does it respect the constraint?

## Integration with Skills

Agents can reference skills in their methodology:

```markdown
### Phase 2: Verification
Apply the **anti-hallucination** skill: verify all referenced APIs exist before documenting them.
```

Skills provide reusable techniques; agents provide structured workflows that orchestrate those techniques.
