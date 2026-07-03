# Error Handling Skill

## Metadata

- **Name**: error-handling
- **Always Active**: No
- **Trigger**: When implementing error recovery, designing fallback strategies, or debugging agent workflow failures.

## Purpose

Unified error recovery, self-correction, graceful degradation, and systematic debugging for agent workflows and code implementation.

## Recovery Strategies

### Strategy 1: Retry with Backoff

```
WHEN: Transient failures (network, timeout, rate limit)
HOW:
  1. Wait: initial_delay * 2^attempt (exponential backoff)
  2. Add jitter: random(0, delay * 0.1)
  3. Max attempts: 3
  4. If still failing → escalate to fallback
```

### Strategy 2: Fallback Degradation

```
WHEN: Primary approach fails
HOW:
  1. Identify fallback alternatives (ordered by preference)
  2. Try next alternative
  3. If all fail → report failure with context
  4. Never silently swallow errors
```

### Strategy 3: Self-Correction

```
WHEN: Own output is detected as incorrect
HOW:
  1. STOP — acknowledge the error
  2. DIAGNOSE — identify what went wrong
  3. CORRECT — fix the specific issue
  4. VERIFY — confirm correction is valid
  5. CONTINUE — resume from corrected state
```

## Error Categories

| Category | Examples | Recovery |
|----------|---------|----------|
| Transient | Network timeout, rate limit | Retry with backoff |
| Input | Invalid parameter, missing data | Validate → report to user |
| State | File not found, resource locked | Check preconditions → report |
| Logic | Wrong result, assertion failure | Self-correct → verify |
| Fatal | Permission denied, corrupt data | Report → stop → ask user |

## Agent Workflow Errors

### Search Failure
- Primary search returns no results →
  1. Try alternate terminology/variations
  2. Broaden search scope
  3. Try different search tool (grep → semantic, or vice versa)
  4. Report: "Unable to locate — may not exist"

### File Read Failure
- File doesn't exist or can't be read →
  1. Verify path is correct (check for typos)
  2. Search for similar filenames
  3. Report: file not found + what was tried

### Tool Failure
- Tool returns error →
  1. Check: Is the input valid?
  2. Try alternative approach
  3. Report failure with error detail

### Scope Escalation
- Task exceeds current agent's capabilities →
  1. Acknowledge scope boundary
  2. Identify correct agent/approach
  3. Report: "This requires {X}, which is beyond my scope"

## Verification After Recovery

After any error recovery:
- [ ] Original goal still achievable?
- [ ] Recovery introduced no new errors?
- [ ] User informed of recovery (if visible impact)?
- [ ] Root cause noted (to prevent recurrence)?
