# Test Case Design Skill

## Metadata

- **Name**: test-case-design
- **Always Active**: No
- **Trigger**: When designing, writing, or reviewing test cases. Activated by keywords: test cases, test design, equivalence partitioning, BVA, decision tables, state transitions, pairwise, covering arrays.

## Purpose

Guides professional test case design using black-box and white-box techniques. Ensures systematic coverage with traceability to requirements.

## Techniques

### 1. Equivalence Partitioning (EP)

Divide input domain into classes where all values in a class are treated equivalently:

- **Valid Equivalence Partitions (VEP)**: Inputs the system should accept
- **Invalid Equivalence Partitions (IEP)**: Inputs the system should reject
- Rule: At least 1 test per partition (valid AND invalid)

### 2. Boundary Value Analysis (BVA)

Test at the edges of equivalence partitions:

| Boundary | Test Values |
|----------|------------|
| Min-1 | Just below minimum (invalid) |
| Min | Exact minimum (valid) |
| Min+1 | Just above minimum (valid) |
| Max-1 | Just below maximum (valid) |
| Max | Exact maximum (valid) |
| Max+1 | Just above maximum (invalid) |

### 3. Decision Tables

For complex business rules with multiple conditions:

```
| Condition 1 | T | T | F | F |
| Condition 2 | T | F | T | F |
| Action 1    | X |   | X |   |
| Action 2    |   | X |   | X |
```

- One column = one test case
- Collapse identical action columns (don't-care conditions)

### 4. State Transition Testing

For systems with defined states:
1. Draw state transition diagram
2. Identify: states, transitions, events, guards, actions
3. Test cases: cover all transitions (0-switch coverage minimum)
4. Optional: cover all transition pairs (1-switch) for higher coverage

### 5. Pairwise / t-way Testing

For combinatorial explosion of parameters:
- Instead of testing all combinations (N^k), test all pairs
- Reduces test count dramatically while catching most interaction bugs
- Use covering array algorithms for 3-way+ interactions

## Test Case Structure

```markdown
### TC-{ID}: {Title} [Priority: HIGH/MEDIUM/LOW]
- **Technique**: {EP/BVA/Decision Table/State Transition/Pairwise}
- **Preconditions**: {required state}
- **Steps**:
  1. {action}
  2. {action}
- **Expected Result**: {specific, observable outcome}
- **Traces to**: {requirement/AC reference}
```

## Coverage Verification

After designing test cases:
- [ ] Every requirement has ≥1 test case
- [ ] Positive paths covered (happy path)
- [ ] Negative paths covered (error/validation)
- [ ] Boundary values tested
- [ ] State transitions exercised (if applicable)
- [ ] No orphan test cases (every TC traces to a requirement)

## Risk-Based Prioritization

| Risk Level | Priority | Test Depth |
|-----------|----------|-----------|
| High (critical path, money, security) | Must test | EP + BVA + Decision Tables |
| Medium (important but recoverable) | Should test | EP + BVA |
| Low (cosmetic, rare path) | Could test | EP only |
