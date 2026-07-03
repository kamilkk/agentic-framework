# Authoring Skills

This guide covers creating custom skills for the agentic framework.

## File Location

- Source: `skills/<name>/SKILL.md`
- Claude deployment: `.claude/skills/<name>/SKILL.md`
- Gemini deployment: Summarized into GEMINI.md skills section

## Structure

Use `skills/_template/SKILL.md` as your starting point:

```markdown
# Skill Name

## Purpose
One-line description of what this skill provides.

## Activation
When to apply this skill (always, on-demand, conditional).

## Rules

### Rule 1: [Name]
Description and examples.

### Rule 2: [Name]
Description and examples.

## Checklist
- [ ] Verification step 1
- [ ] Verification step 2
```

## Skill vs Agent

| Aspect | Skill | Agent |
|--------|-------|-------|
| Scope | Single technique or concern | Full workflow |
| Activation | Applied within any context | Activated by task type |
| Output | Modifies behavior | Produces artifacts |
| Example | "Validate before documenting" | "Analyze this bug end-to-end" |

Skills are **adjectives** (how to work). Agents are **verbs** (what work to do).

## Types of Skills

### Always-Active Skills
Applied to every interaction regardless of context:
- `anti-hallucination` — Verify before claiming
- `green-coding` — Efficient by default

Mark with: `## Activation: Always active`

### Conditional Skills
Applied when specific conditions are met:
- `white-box-tracing` — When verifying control flow
- `test-case-design` — When writing tests

Mark with: `## Activation: When [condition]`

### On-Demand Skills
Applied only when explicitly requested:
- `exhaustive-analysis` — When completeness required
- `document-consolidation` — When merging documents

Mark with: `## Activation: On request`

## Design Principles

### 1. Concise Rules
Each rule should be actionable in one read. If it needs a sub-document, it's too complex for a single skill.

### 2. Verifiable
Include a checklist that can be mechanically verified. Avoid subjective criteria.

### 3. Composable
Skills should combine cleanly. Avoid skills that contradict each other.

### 4. Tool-Agnostic
Write rules in terms of behavior, not tool-specific features:
- Good: "Read the file before editing"
- Bad: "Use the read_file tool before replace_string_in_file"

## Example: Creating a Logging Skill

```markdown
# Structured Logging

## Purpose
Ensure all log statements follow structured logging conventions with proper severity and context.

## Activation
When writing or reviewing code that includes logging statements.

## Rules

### Rule 1: Structured Format
Use structured logging (key-value pairs) instead of string interpolation.
- Good: `logger.Info("Order processed", "orderId", id, "amount", total)`
- Bad: `logger.Info($"Order {id} processed for {total}")`

### Rule 2: Severity Levels
| Level | Use When |
|-------|----------|
| Debug | Developer diagnostics, loop iterations |
| Info | Business events, state transitions |
| Warn | Recoverable issues, degraded behavior |
| Error | Failures requiring attention |
| Fatal | Unrecoverable, process must stop |

### Rule 3: Context Fields
Always include: correlation ID, operation name, and entity ID when available.

### Rule 4: No Sensitive Data
Never log: passwords, tokens, PII, full credit card numbers, or API keys.

## Checklist
- [ ] All logs use structured format (no string interpolation)
- [ ] Severity level matches the event type
- [ ] Context fields present (correlation ID where applicable)
- [ ] No sensitive data in log output
```

## Compilation for Gemini

Since Gemini uses a single flat file, skills are summarized during compilation. Write your SKILL.md assuming the full version is available (Claude) but ensure the core rules are captured in the first 3-5 bullet points (Gemini summary).

The installer extracts:
1. Skill name and purpose (first line + Purpose section)
2. Core rules (condensed to single-line bullets)
3. Activation condition

## Skill Interactions

Document known interactions in your skill:

```markdown
## Interactions
- **Complements**: anti-hallucination (both verify before acting)
- **Tension with**: exhaustive-analysis (when speed matters more than completeness)
- **Required by agents**: review-expert, security-expert
```
