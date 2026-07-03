# Workspace Search Skill

## Metadata

- **Name**: workspace-search
- **Always Active**: No
- **Trigger**: When searching documentation or code in multi-repository workspaces with inconsistent naming.

## Purpose

Efficient workspace search methodology with variation-aware strategies. Applies hybrid search (classify → locate → filter → scan → expand) with terminology resolution and parallel tool execution.

## Search Methodology

### Step 1: Classify Query

| Query Type | Primary Tool | Fallback |
|-----------|-------------|----------|
| Exact string/symbol | grep_search | file_search |
| Concept/idea | semantic_search | grep with variations |
| File by name | file_search | grep in paths |
| Pattern/convention | grep_search (regex) | semantic_search |

### Step 2: Generate Search Variations

Before searching, generate term variations:

```
EXAMPLE: Searching for "shopping cart"
Variations: cart, basket, shopping, bag, trolley
Regex: cart|basket|shopping|bag

EXAMPLE: Searching for "user permissions"
Variations: permission, role, access, authorization, auth, rbac
Regex: permission|role|auth|rbac|access.control
```

### Step 3: Execute Search (Parallel When Possible)

1. Try primary tool with variations
2. If insufficient results → try fallback tool
3. If still insufficient → broaden search (remove qualifiers, shorten terms)
4. Stop when: ≥3 relevant results found OR all variations exhausted

### Step 4: Filter & Rank Results

| Signal | Weight |
|--------|--------|
| Exact match | Highest |
| In relevant directory | High |
| Recent modification | Medium |
| In documentation vs code | Depends on query type |

### Step 5: Expand (If Needed)

If initial search is too narrow:
1. Check imports/references from found files
2. Search for related terms discovered in results
3. Broaden directory scope

## Search Efficiency Rules

### DO

- Start narrow, expand if needed
- Use grep for structured/exact matches
- Use semantic_search for concepts
- Generate 3-5 term variations upfront
- Use file_search for known filename patterns
- Read only relevant sections of large files

### DON'T

- Don't read entire large files when searching for specific content
- Don't run 10 searches sequentially — batch with regex alternation
- Don't search without variations in projects with inconsistent naming
- Don't use semantic_search in parallel (tool limitation)
- Don't keep searching after finding 3+ relevant results

## Recovery Protocol

| Situation | Recovery |
|-----------|----------|
| 0 results | Broaden: shorter terms, remove qualifiers |
| Too many results (100+) | Narrow: add directory filter, more specific term |
| Wrong results | Different variations, different tool |
| Tool timeout | Retry with smaller scope |
| File too large to read | Use grep to find specific lines, then read range |
