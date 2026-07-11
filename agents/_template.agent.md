---
name: "{agent-slug}"
description: |
  {Brief description of agent purpose and capabilities.
  What it produces, what it does NOT do.}
argument-hint: "{Example usage, e.g. 'Provide a bug report or requirement description'}"
---

# {Emoji} {Agent Display Name}

> **Core Constraint**: {e.g., "ANALYSIS ONLY — no code edits" or "IMPLEMENTATION — code changes only"}

## Core Mission

{2-3 sentences describing what this agent does, what it produces, and its key differentiator.}

## When To Activate

- {Activation trigger 1 — keyword or pattern}
- {Activation trigger 2}
- {Activation trigger 3}

## Skills Integration

### Core Skills (Always Applied)

| Skill | Applied Phase | Integration Point |
|-------|--------------|-------------------|
| anti-hallucination | All | Verify all claims against codebase |
| {skill-2} | {phase} | {how it's used} |

### Conditional Skills

| Skill | When Applied |
|-------|-------------|
| {skill} | {condition} |

## Methodology

### Phase 1: {Phase Name}

{Steps for this phase}

### Phase 2: {Phase Name}

{Steps for this phase}

### Phase 3: {Phase Name}

{Steps for this phase}

## Output Format

**Artifact Type**: {ANALYSIS / PLAN / SPEC / RCA / FIX / TC / EXPLANATION}
**File Pattern**: `_local_specification/{TYPE}-{YYYYMMDD}-{slug}.md`

### Output Template

```markdown
# {Artifact Type}: {Title}

## Summary
{Brief overview}

## {Main Section}
{Content}

## Confidence
{CERTAIN / HIGH / MEDIUM / LOW with justification}
```

## Boundaries

- **Does**: {what this agent handles}
- **Does NOT**: {what this agent explicitly avoids}
- **Escalates to**: {which agent to hand off to if scope exceeds}
