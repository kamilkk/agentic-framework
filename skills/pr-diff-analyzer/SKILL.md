# PR Diff Analyzer Skill

## Metadata

- **Name**: pr-diff-analyzer
- **Always Active**: No
- **Trigger**: When parsing git diff output into structured data for code review or change analysis.

## Purpose

Parses raw git diff output into structured JSON with file paths, change status, hunks, line counts, and impact-area categories. Transforms terminal diff output into a structured contract.

## Parsing Protocol

### Input: Raw Git Diff

```bash
git diff --name-status origin/main...origin/feature-branch
git diff --stat origin/main...origin/feature-branch
git diff origin/main...origin/feature-branch -- path/to/file
```

### Output Schema

```json
{
  "files": [
    {
      "path": "src/services/cart.service.ts",
      "status": "Modified",
      "additions": 15,
      "deletions": 3,
      "hunks": [
        {
          "startLine": 42,
          "endLine": 57,
          "context": "applyDiscount method"
        }
      ],
      "impactArea": "business-logic"
    }
  ],
  "summary": {
    "totalFiles": 5,
    "totalAdditions": 87,
    "totalDeletions": 12,
    "impactAreas": ["business-logic", "api", "tests"]
  }
}
```

### File Status Mapping

| Git Status | Parsed Status |
|-----------|---------------|
| A | Added |
| M | Modified |
| D | Deleted |
| R{score} | Renamed |
| C{score} | Copied |

### Impact Area Classification

| File Pattern | Impact Area |
|-------------|-------------|
| `**/controllers/**`, `**/routes/**` | api |
| `**/services/**`, `**/handlers/**` | business-logic |
| `**/models/**`, `**/entities/**` | data-model |
| `**/tests/**`, `**/*.spec.*`, `**/*.test.*` | tests |
| `**/config/**`, `*.config.*`, `*.json` | configuration |
| `**/migrations/**` | database |
| `**/*.css`, `**/*.scss`, `**/components/**` | ui |
| `**/docs/**`, `**/*.md` | documentation |
| `Dockerfile`, `*.yml`, `*.yaml` (CI) | infrastructure |

## Usage in Review Workflow

1. Run `git diff --name-status` to get file list
2. Parse each file into structured format
3. Classify impact areas
4. Feed structured data to review agents
5. Use impact areas to route to specialized reviewers

## Hunk Extraction

For each modified file:
1. Parse `@@` hunk headers for line ranges
2. Extract surrounding function/class context
3. Note: additions (lines starting with `+`), deletions (`-`)
4. Group related hunks by logical change
