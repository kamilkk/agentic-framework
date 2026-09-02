# Phase: Project Memory (Recall & Persist)

> On-demand reference file. Read when recalling prior context at task start or persisting durable findings at task end.

## What "memory" means here

Memory uses **Claude Code's native memory structure** — no bespoke store. The project
`CLAUDE.md` (auto-loaded every session) imports a small set of memory files via `@` imports:

```
CLAUDE.md
└── @.claude/memory/decisions.md   # Architecture/design decisions + WHY
    @.claude/memory/patterns.md    # Discovered codebase patterns & conventions
    @.claude/memory/glossary.md    # Domain term → codebase entity mappings
```

Because these are imported into `CLAUDE.md`, Claude Code loads them into context
automatically at session start. Gemini CLI reads the same files via `GEMINI.md`.

**Memory vs `_local_specification/`** — do not confuse them:

| Store | Holds | Lifetime |
|-------|-------|----------|
| `.claude/memory/*.md` | Durable, reusable facts about the project | Cross-session, cross-task |
| `_local_specification/*.md` | Per-task deliverables (ANALYSIS, PLAN, RCA, …) | Tied to one work item |

## Recall (task start — before Phase 1)

1. Project memory is already in context (imported by `CLAUDE.md`). Actively **consult** the
   file relevant to your task — a decision may already answer the question, a pattern may
   already exist, a term may already be mapped.
2. Surface what you used in the checkpoint's **Memory** line (or "none relevant").
3. Memory is data recorded at a point in time, **not ground truth**. Before relying on a
   remembered fact, verify it still holds against the code (anti-hallucination rule applies).

## Persist (task end — after verification)

Append a fact to memory **only** when it is durable and reusable — not task scratch:

| Write to | When |
|----------|------|
| `decisions.md` | An architecture/design decision was made — record the decision **and its rationale** |
| `patterns.md` | A codebase pattern or convention was discovered/confirmed and downstream work should follow it |
| `glossary.md` | A domain term was mapped to a concrete codebase entity (ties to the Terminology rule) |

Rules:
- **Durable only.** If it matters only to the current task, it belongs in `_local_specification/`, not memory.
- **One fact, with its why.** Keep entries short; a decision without its rationale is not worth remembering.
- **Verify before writing.** Only persist facts confirmed against the code.
- **Append, don't clobber.** Add to the file; do not rewrite existing entries unless correcting a now-wrong fact.
- **Surface it.** State what you persisted in your closing summary so the user can review.
- The user can also add memory directly with Claude Code's `#` shortcut or edit it via `/memory`.

## Entry format

Keep entries scannable and dated (`YYYY-MM-DD`):

```markdown
### 2026-09-02 — Discounts are applied before tax
Cart totals apply discount in `CartService.ApplyDiscount` (`src/cart/CartService.cs:88`)
**before** tax is computed in `TaxCalculator`. Any pricing change must preserve this order.
```
