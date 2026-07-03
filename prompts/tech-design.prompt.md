# Tech Design

## Prompt

Create a technical design document for:

**Feature**: {feature or change description}
**Scope**: {affected services/components}
**Constraints**: {any known limitations}

## Expected Output Format

```markdown
# Tech Design: {Feature Title}

## Overview
{1-2 paragraph summary of what's being built and why}

## Requirements Summary
| # | Requirement | Priority |
|---|------------|----------|

## Architecture

### Component Diagram
{Mermaid diagram showing affected components}

### Sequence Diagram
{Mermaid sequence diagram showing key flow}

## Data Model Changes
{New entities, modified schemas, migrations needed}

## API Changes
| Method | Endpoint | Request | Response | Notes |
|--------|----------|---------|----------|-------|

## Implementation Approach

### Phase 1: {Name}
{Description and key decisions}

### Phase 2: {Name}
{Description and key decisions}

## Security Considerations
- {Authentication/authorization changes}
- {Data protection requirements}
- {Input validation needs}

## Performance Considerations
- {Expected load}
- {Caching strategy}
- {Query optimization needs}

## Testing Strategy
- Unit tests: {scope}
- Integration tests: {scope}
- E2E tests: {scope}

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|

## Dependencies
- {External services}
- {Other teams/components}
- {Timeline dependencies}

## Open Questions
- {Questions needing answers before implementation}
```

## Instructions

- Start with the simplest design that meets requirements
- Include diagrams (Mermaid format)
- Address security and performance proactively
- Identify risks and open questions honestly
- Keep implementation phases incremental and deliverable
