# Document Consolidation Skill

## Metadata

- **Name**: document-consolidation
- **Always Active**: No
- **Trigger**: When merging multiple document versions, creating SSOT from multiple sources, or combining overlapping documentation.

## Purpose

Guides merging or consolidating multiple document versions into one authoritative document (Single Source of Truth). Uses a 7-phase process with strengths-based fusion and conflict resolution.

## 7-Phase Process

### Phase 1: Inventory

1. List ALL source documents
2. Note: author, date, version, purpose
3. Identify: which is most recent? Most authoritative? Most complete?

### Phase 2: Analysis

For each document:
1. Extract unique content (not in other docs)
2. Extract shared content (duplicated across docs)
3. Note: tone, structure, detail level
4. Mark: strengths of each document

### Phase 3: Conflict Classification

| Conflict Type | Resolution Strategy |
|--------------|-------------------|
| Factual contradiction | Verify against source code/reality |
| Different detail levels | Use the more detailed version |
| Different structure | Choose structure that serves the audience |
| Different terminology | Use the project's canonical terms |
| Outdated information | Use most recent verified version |

### Phase 4: Resolution

For each conflict:
1. Classify type (from table above)
2. Apply resolution strategy
3. Document decision: "Chose X because Y"
4. Mark unresolvable conflicts for human review

### Phase 5: Structuring

Build the consolidated document:
1. Choose optimal structure (from strongest source or new)
2. Place content in logical order
3. Eliminate redundancy (say it once, well)
4. Ensure flow between sections

### Phase 6: Verification

- [ ] All unique content from each source is preserved
- [ ] No contradictions remain (or are flagged)
- [ ] No information was silently dropped
- [ ] Terminology is consistent throughout
- [ ] Document serves its intended audience

### Phase 7: Publication

1. Add metadata (date, sources, version)
2. Mark as SSOT
3. Note: which source docs are now superseded
4. Recommend: archive/delete superseded docs

## Conflict Resolution Matrix

| Source A says | Source B says | Both recent? | Resolution |
|--------------|--------------|-------------|-----------|
| X = true | X = false | Yes | Verify against code |
| X = true | X = false | A newer | Use A (unless B has evidence) |
| Detailed explanation | Brief mention | — | Use detailed, credit both |
| Different structure | Different structure | — | Choose by audience need |
| Info present | Info absent | — | Include (don't drop) |

## Anti-Patterns

- ❌ Silently dropping content that "seems old"
- ❌ Choosing one source entirely and ignoring others
- ❌ Creating a document longer than all sources combined
- ❌ Introducing new content not in any source
- ❌ Leaving contradictions unresolved without flagging
