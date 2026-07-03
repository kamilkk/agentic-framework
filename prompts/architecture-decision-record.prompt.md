# Architecture Decision Record

## Prompt

Generate an Architecture Decision Record (ADR) for the following decision:

**Decision**: {describe the architectural decision}
**Context**: {describe the situation and constraints}

## Expected Output Format

```markdown
# ADR-{NNN}: {Decision Title}

## Status
{Proposed | Accepted | Deprecated | Superseded by ADR-XXX}

## Date
{YYYY-MM-DD}

## Context
{Describe the situation, technical constraints, business requirements, and forces at play.}

## Options Considered

### Option 1: {Name}
- **Description**: {how it works}
- **Pros**: {advantages}
- **Cons**: {disadvantages}
- **Cost**: {effort/complexity}

### Option 2: {Name}
...

### Option 3: {Name}
...

## Decision
We chose **Option {N}: {Name}** because {rationale linking back to context and criteria}.

## Consequences

### Positive
- {benefit 1}
- {benefit 2}

### Negative
- {trade-off 1}
- {trade-off 2}

### Risks
- {risk 1} — mitigated by {mitigation}

## Implementation Notes
{Key implementation details, affected components, migration steps if applicable}

## References
- {related ADRs, documentation, or external resources}
```

## Instructions

- Evaluate minimum 3 options (more for complex decisions)
- Include at least one "do nothing" or "simplest possible" option
- Weight criteria: Correctness 40%, Simplicity 25%, Consistency 20%, Robustness 15%
- Be honest about trade-offs — no option is perfect
- Link to specific code/files when referencing existing implementations
