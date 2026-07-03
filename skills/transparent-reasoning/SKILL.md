# Transparent Reasoning Skill

## Metadata

- **Name**: transparent-reasoning
- **Always Active**: No
- **Trigger**: Complex decisions, trade-off evaluations, architectural choices, or when decision rationale needs documentation.

## Purpose

Provides structured decision-making with clear reasoning, alternative exploration, and documented thought processes. Ensures decisions are traceable and reviewable.

## Rules

### Rule 1: Decision Framework

For every non-trivial decision, document:
1. **Context** — What situation requires a decision?
2. **Options** — What are the alternatives? (minimum 3 for Tier 2+)
3. **Criteria** — What matters? (with weights)
4. **Evaluation** — How does each option score?
5. **Decision** — What was chosen and why?

### Rule 2: Criteria Weights (Default)

| Criterion | Weight | Description |
|-----------|--------|-------------|
| Correctness | 40% | Does it solve the actual problem? |
| Simplicity | 25% | Is it the simplest viable solution? |
| Consistency | 20% | Does it follow existing patterns? |
| Robustness | 15% | Does it handle edge cases? |

Adjust weights based on context (e.g., security-critical → correctness 50%, robustness 30%).

### Rule 3: Alternative Exploration

| Tier | Minimum Alternatives |
|------|---------------------|
| 1 | 1-2 (mental, not documented) |
| 2 | 3+ (documented in Design Considerations) |
| 3 | 5+ (documented in ADR format) |

### Rule 4: Adversarial Self-Check (Tier 2+)

Before finalizing a decision:
1. Argue AGAINST your chosen option (devil's advocate)
2. Identify the strongest counter-argument
3. Explain why you still choose this option despite the counter-argument
4. If you can't counter the argument → reconsider the decision

### Rule 5: Assumption Registry

Track all assumptions explicitly:

| Assumption | Status | Risk if Wrong |
|-----------|--------|---------------|
| {assumption} | ✅ Verified / ❓ Unverified | {impact} |

## Output Format

### Design Considerations (Tier 2)

```markdown
## Design Considerations

### Options Evaluated
1. **{Option A}**: {brief description}
2. **{Option B}**: {brief description}
3. **{Option C}**: {brief description}

### Decision: {Option chosen}
**Rationale**: {why this option wins on weighted criteria}
**Trade-off accepted**: {what we give up}
```

### ADR Format (Tier 3)

```markdown
## ADR: {Decision Title}

**Status**: Proposed / Accepted / Superseded
**Context**: {situation requiring decision}
**Options**: {numbered list}
**Decision**: {chosen option}
**Consequences**: {positive and negative}
```
