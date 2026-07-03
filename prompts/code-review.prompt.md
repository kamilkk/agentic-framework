# Code Review

## Prompt

Review the following code changes:

**Files**: {list of files or PR reference}
**Focus**: {specific concerns, or "general review"}

## Expected Output Format

```markdown
# Code Review: {Title}

## Summary
- **Files Reviewed**: {count}
- **Quality Score**: {1-5}/5
- **Recommendation**: {APPROVE | REQUEST CHANGES | DISCUSS}

## Findings

### 🔴 Critical (Must Fix)
| # | File:Line | Issue | Suggestion |
|---|-----------|-------|-----------|

### 🟠 High (Should Fix)
| # | File:Line | Issue | Suggestion |
|---|-----------|-------|-----------|

### 🟡 Medium (Consider)
| # | File:Line | Issue | Suggestion |
|---|-----------|-------|-----------|

### 💬 Suggestions (Optional)
| # | File:Line | Suggestion |
|---|-----------|-----------|

## Checklist
- [ ] Correctness — logic is sound
- [ ] Security — no OWASP violations
- [ ] Performance — no obvious inefficiencies
- [ ] Patterns — follows project conventions
- [ ] Tests — adequate coverage for changes
- [ ] Naming — clear, consistent terminology

## Positive Notes
{Acknowledge good patterns, clean code, thoughtful design}
```

## Instructions

- Verify claims against actual code (anti-hallucination)
- Check for OWASP Top 10 security issues
- Verify existing patterns are followed
- Check test coverage for new logic
- Be constructive — suggest improvements, don't just criticize
- Prioritize: don't nitpick if there are critical issues
