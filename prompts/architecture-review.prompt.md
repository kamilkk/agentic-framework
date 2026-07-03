# Architecture Review

## Prompt

Perform an architecture review of the following system/feature:

**Subject**: {system, feature, or component to review}
**Scope**: {what aspects to focus on}

## Expected Output Format

```markdown
# Architecture Review: {Subject}

## Overview
{Brief description of what's being reviewed}

## Component Diagram
{Mermaid diagram showing components and their relationships}

## Review Dimensions

### 1. Separation of Concerns
- {Assessment: are responsibilities properly distributed?}
- {Issues found}

### 2. Coupling & Cohesion
- {Assessment: are dependencies appropriate?}
- {Circular dependencies or tight coupling?}

### 3. Scalability
- {Assessment: can this scale horizontally/vertically?}
- {Bottlenecks identified}

### 4. Resilience
- {Assessment: what happens when components fail?}
- {Single points of failure}

### 5. Security
- {Assessment: are trust boundaries properly defined?}
- {Attack surface}

### 6. Maintainability
- {Assessment: is the code easy to understand and modify?}
- {Complexity hotspots}

## Findings

### Critical
| # | Finding | Component | Recommendation |
|---|---------|-----------|---------------|

### Improvement Opportunities
| # | Opportunity | Benefit | Effort |
|---|------------|---------|--------|

## Recommendations
{Prioritized list of actions}

## Positive Observations
{What's working well — acknowledge good design}
```

## Instructions

- Focus on structural issues, not code style
- Assess against established patterns in the project
- Consider both current state and future growth
- Be specific: cite files and line numbers for findings
- Balance criticism with positive observations
