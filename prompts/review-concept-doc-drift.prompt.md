# Review Concept Doc Drift

## Prompt

Analyze drift between a concept/design document and the actual implementation:

**Document**: {path to concept/design document}
**Implementation**: {path to code or service}

## Expected Output Format

```markdown
# Drift Analysis: {Document Title} vs Implementation

## Document Summary
{Brief summary of what the document describes}

## Implementation Summary
{Brief summary of what's actually built}

## Drift Findings

### 🔴 Significant Drift (Design ≠ Reality)
| # | Document Says | Implementation Does | Impact |
|---|--------------|-------------------|--------|

### 🟡 Minor Drift (Evolved but compatible)
| # | Document Says | Implementation Does | Assessment |
|---|--------------|-------------------|-----------|

### ✅ Aligned (Document matches implementation)
| # | Aspect | Status |
|---|--------|--------|

## Statistics
- **Total aspects checked**: {N}
- **Aligned**: {n} ({%})
- **Minor drift**: {n} ({%})
- **Significant drift**: {n} ({%})

## Recommendations

### Update Document (Implementation is correct)
- {item 1 — doc is outdated}

### Update Implementation (Document is correct)
- {item 1 — code drifted from intended design}

### Needs Discussion (Unclear which is correct)
- {item 1 — intentional change or accidental drift?}
```

## Instructions

- Read BOTH the document and implementation completely
- Don't assume drift is bad — it may be intentional evolution
- Classify: is the document wrong, or is the code wrong?
- Check: API contracts, data models, flows, error handling, security model
- Be precise: cite specific sections and file:line numbers
