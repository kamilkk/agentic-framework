# Test Case Design Skill

## Metadata

- **Name**: test-case-design
- **Always Active**: No
- **Trigger**: When designing, writing, or reviewing test cases OR building features/fixing bugs test-first. Activated by keywords: test cases, test design, equivalence partitioning, BVA, decision tables, state transitions, pairwise, covering arrays, TDD, red-green, test-first, seams, mocking.
- **Source**: The TDD section is adapted from [mattpocock/skills](https://github.com/mattpocock/skills) (MIT) — `skills/engineering/tdd`.

## Purpose

Guides professional test case design using black-box and white-box techniques, plus test-driven development (the red-green loop). Ensures systematic coverage with traceability to requirements, and tests that verify behaviour through public interfaces rather than implementation details.

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

---

## Test-Driven Development (TDD)

TDD is the **red → green** loop: write a failing test, then only enough code to pass it. The techniques above tell you *which* cases to write; this section governs *how* to drive implementation with them so the tests are worth keeping.

When exploring the codebase, read `CONTEXT.md` (if it exists) so test names and interface vocabulary match the project's domain language, and respect ADRs in the area you're touching. When the shape of the interface under test is itself in question (how deep the module is, where the seam belongs), use the `codebase-design` skill for the vocabulary.

### What a good test is

Tests verify behaviour through **public interfaces**, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification: `"user can checkout with valid cart"` tells you exactly what capability exists, and it survives refactors because it doesn't care about internal structure.

### Seams: where tests go

A **seam** is the public boundary you test at — the interface where you observe behaviour without reaching inside. Tests live at seams, never against internals.

**Test only at pre-agreed seams.** Before writing any test, write down the seams under test and confirm them with the user. No test is written at an unconfirmed seam. You can't test everything, so agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case. Prefer the **highest** seam possible; the fewer seams across the codebase, the better.

Ask: "What's the public interface, and which seams should we test?"

### Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Don't anticipate future tests or add speculative features.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle. Each test is a **tracer bullet** that responds to what the last cycle taught you.
- **Vertical, not horizontal.** Don't write all tests first and all implementation second. Work in vertical slices: one test → one implementation → repeat.
- **Refactoring is not part of the loop.** It belongs to the review stage (see the `code-review` skill), not the red → green implementation cycle.

### Anti-patterns

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behaviour hasn't changed.
- **Tautological**: the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a hand-derived snapshot, a constant asserted equal to itself), so it passes by construction. Expected values must come from an independent source of truth: a known-good literal, a worked example, the spec.
- **Horizontal slicing**: writing all tests first, then all implementation — you test the *shape* of imagined behaviour and commit to test structure before understanding the implementation.

### Good vs bad tests

**Good** — integration-style, through real interfaces, asserting observable behaviour:

```typescript
// GOOD: tests observable behavior via the public API
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

Characteristics: tests behaviour callers care about, uses public API only, survives internal refactors, describes WHAT not HOW, one logical assertion per test.

**Bad** — coupled to internal structure, or verifying through a side channel:

```typescript
// BAD: asserts on internal call, breaks on refactor
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});

// BAD: bypasses the interface to verify
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// GOOD: verifies through the interface
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```

### When to mock

Mock at **system boundaries** only: external APIs (payment, email), databases (prefer a test DB), time/randomness, sometimes the file system. **Do not** mock your own classes, internal collaborators, or anything you control.

Design boundaries to be mockable:

1. **Use dependency injection** — pass external dependencies in rather than constructing them internally (`processPayment(order, paymentClient)` beats `processPayment(order)` that news up a `StripeClient`).
2. **Prefer SDK-style interfaces over generic fetchers** — a specific function per external operation (`api.getUser(id)`, `api.createOrder(data)`) means each mock returns one specific shape, with no conditional logic in test setup.
