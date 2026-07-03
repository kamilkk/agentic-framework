# Exhaustive Analysis Skill

## Metadata

- **Name**: exhaustive-analysis
- **Always Active**: No
- **Trigger**: When 100% coverage is required — comprehensive audits, categorizing all occurrences, large file analysis, or when completeness is critical.

## Purpose

Provides methodical analysis that guarantees 100% coverage without shortcuts. Uses batch processing for large datasets with progress reporting and completion verification.

## Rules

### Rule 1: No Shortcuts

- Process EVERY item in the dataset — no sampling, no "and similar..."
- If dataset is large, process in batches with explicit progress tracking
- Never assume items are "the same" without verification
- Report completion percentage after each batch

### Rule 2: Batch Processing Protocol

For datasets > 20 items:

```
BATCH PROTOCOL:
1. Count total items: N
2. Set batch size: min(20, N/3)
3. Process batch 1: items 1-{batch_size}
4. Report: "Processed {batch_size}/{N} ({percentage}%)"
5. Continue until 100%
6. Final report: "Complete: {N}/{N} processed"
```

### Rule 3: Categorization Completeness

When categorizing items:
- Define categories BEFORE starting (don't add mid-process)
- Every item must be assigned to exactly one category
- If item doesn't fit → create "Other/Uncategorized" with explanation
- Final check: sum of category counts = total items

### Rule 4: Progress Reporting

| Dataset Size | Reporting Frequency |
|-------------|-------------------|
| 1-10 items | After completion |
| 11-50 items | Every 10 items |
| 51-200 items | Every 25 items |
| 200+ items | Every 50 items or 10% |

### Rule 5: Completion Guarantee

Before declaring analysis complete:
1. Verify total count matches expected
2. Verify no items skipped (cross-reference IDs/indices)
3. Verify all categories have entries
4. Report final statistics

## Decision Table

| Situation | Action |
|-----------|--------|
| "Analyze all X in the project" | Count first, then batch process ALL |
| "Find all occurrences of Y" | Search exhaustively, report count |
| "Categorize these items" | Define categories, assign each, verify totals |
| Large file (>500 lines) | Read in chunks, process each chunk |
| "How many X exist?" | Count exhaustively, don't estimate |

## Output Format

```markdown
## Analysis Complete

**Total Items**: {N}
**Processed**: {N}/{N} (100%)
**Categories**:
| Category | Count | Percentage |
|----------|-------|-----------|

**Verification**: Sum = {N} ✅
```
