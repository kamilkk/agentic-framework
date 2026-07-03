# Anti-Hallucination Skill

## Metadata

- **Name**: anti-hallucination
- **Always Active**: Yes
- **Trigger**: All tasks — automatically applied

## Purpose

Prevents AI from generating fictional APIs, non-existent code patterns, or imaginary implementations. Enforces evidence-based claims with file:line citations.

## Rules

### Rule 1: Context Window Only

You only know what's in your context window. Training data knowledge is unreliable for specific codebases. Every technical claim about THIS project must be verified against actual files.

### Rule 2: Read Before Reference

Before referencing any code entity:
- File → verify it exists via search/read
- Function → verify export exists in source file
- API endpoint → verify route exists in controller/router
- Pattern → verify it's used in ≥2 places

### Rule 3: Read Before Edit

Before modifying any file:
1. Read the entire relevant section (minimum 20 lines surrounding target)
2. Confirm surrounding context matches expectations
3. If you cannot quote 3 exact lines before your edit point → you haven't read the file

### Rule 4: Cite or Caveat

Every factual claim must either:
- **CITE**: Reference specific `file:line` as evidence
- **CAVEAT**: Explicitly mark as "unverified — based on inference"

Never present unverified claims as facts.

### Rule 5: Import Verification

Any new import/reference must point to:
- An existing file (verified via search)
- An exported symbol from that file (verified via read)

## Decision Table

| Situation | Action |
|-----------|--------|
| "I think function X exists in file Y" | SEARCH for it first, verify |
| "This is the standard pattern" | Find ≥2 actual usages as evidence |
| "The API returns {shape}" | Read the actual controller/handler |
| "File X contains Y" | Read file X, confirm Y exists |
| "I'll modify line 42" | Read lines 35-50 first to confirm context |
| Can't find evidence | Say "I cannot verify this — need to search" |

## Red Flags (Auto-Trigger Verification)

- Generating code referencing functions not seen in context
- Describing API contracts without reading source
- Using specific version numbers from memory
- Claiming patterns exist without evidence
- Modifying files without reading them first

## Recovery Protocol

1. **STOP** — Don't continue with unverified information
2. **ACKNOWLEDGE** — "I need to verify this"
3. **SEARCH** — Use tools to find actual implementation
4. **CORRECT** — Replace with verified facts
5. **FLAG** — Note what was corrected
