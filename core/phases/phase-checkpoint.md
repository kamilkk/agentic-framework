# Checkpoint Protocol — Reference & Examples

> On-demand reference file. Read when producing checkpoints for Tier 1+ tasks.

## Full Checkpoint Template

```markdown
═══════════════════════════════════════════════════════════════════
📋 **CHECKPOINT** [Tier 1/2/3] · [Session: First/Continuing] · [Mode: @teach/@dev/default]
═══════════════════════════════════════════════════════════════════
**Docs Read**: [list of specific files read]
**Key Terms**: [2–3 most critical terms with one-word context]
**Critical Insight**: [ONE sentence: What would go wrong without docs?]
**System 2 Proof**:
- **Analyzed**: [1-3 sentences]
- **Verified**: [1-3 sentences — cite files]
- **Questioned**: [1-3 sentences]
- **Simplified**: [1-3 sentences]
═══════════════════════════════════════════════════════════════════
```

## Size Rules

- **Tier 1**: 8–25 lines total (including borders)
- **Tier 2+**: 12–30 lines total (including borders)
- Content: 4–6 lines of substance

## Good System 2 Proof Examples

- ✅ "Analyzed request: user wants single field added. YAGNI check: not adding validation beyond request."
- ✅ "Verified message contract in shared library. Existing CQRS pattern fits. Risk: none."
- ✅ "Confirmed entity in service. Verified endpoint in API docs. Pattern matches CQRS."
- ✅ "Initial thought: custom validator. Refinement: existing library already provides this (simpler)."

## Bad Patterns

- ❌ 50+ lines of doc summaries before answer
- ❌ Vague proof ("I analyzed things") — no evidence
- ❌ Restating the task as proof of thinking

## Confidence Levels

| Level | Range | Indicator | When |
|-------|-------|-----------|------|
| CERTAIN | 95-100% | ✅ | Direct quote from docs, verified code |
| HIGH | 80-94% | 🟢 | Strong evidence, pattern match |
| MEDIUM | 60-79% | 🟡 | Reasonable inference, single source |
| LOW | 40-59% | 🟠 | Assumption-based, needs verification |
| UNCERTAIN | <40% | 🔴 | Speculative → ASK USER |

## Session Continuity Rules

- **First task**: Full checkpoint + full doc search
- **Subsequent tasks (same session)**: Checkpoint STILL required, but reference prior reads
- **Context window reset**: Treat as new session (re-search docs)
