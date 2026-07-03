# Green Coding Skill

## Metadata

- **Name**: green-coding
- **Always Active**: Yes (applied by default to code suggestions)
- **Trigger**: All code generation tasks. User can opt out: "Ignore green coding for this request"

## Purpose

Applies energy-efficient, resource-conscious coding patterns by default. Reduces CPU, memory, and network usage while respecting existing architecture. Sustainability as a first-class concern.

## Rules

### Rule 1: Prefer Efficient Data Structures

| Need | Prefer | Avoid |
|------|--------|-------|
| Lookup by key | HashMap/Dictionary | Linear search through list |
| Unique items | HashSet/Set | Array with manual dedup |
| Ordered access | Sorted collection | Sort on every access |
| Small fixed data | Array/Tuple | Object allocation |
| Streaming data | Iterator/Generator | Collect all into memory |

### Rule 2: Minimize Allocations

- Reuse objects when safe (StringBuilder, buffers)
- Use `readonly`/`const`/`final` for immutable data
- Prefer value types for small, short-lived data
- Avoid unnecessary boxing/unboxing
- Pool expensive objects (HTTP clients, DB connections)

### Rule 3: Efficient Async Patterns

- Use async/await for I/O operations (network, disk, DB)
- Avoid `async` for CPU-bound synchronous operations
- Use `Task.WhenAll` / `Promise.all` for parallel independent I/O
- Cancel operations that are no longer needed (CancellationToken)
- Avoid fire-and-forget without error handling

### Rule 4: Caching Strategy

| Data Profile | Strategy |
|-------------|----------|
| Rarely changes, frequently read | Cache aggressively (memory/distributed) |
| Changes per-request | Don't cache |
| Expensive to compute, same inputs | Memoize |
| Large dataset, partial access | Cache hot subset only |

### Rule 5: Network Efficiency

- Batch requests where possible (reduce round-trips)
- Use pagination for large datasets
- Compress payloads for large transfers
- Use appropriate HTTP caching headers
- Select only needed fields (avoid over-fetching)

### Rule 6: Database Efficiency

- Select only needed columns (no `SELECT *`)
- Use appropriate indexes
- Batch writes where possible
- Avoid N+1 query patterns (use eager loading or joins)
- Use connection pooling

## Decision Table

| Situation | Green Choice |
|-----------|-------------|
| Loop with string concatenation | StringBuilder / join() |
| Multiple sequential API calls | Parallel where independent |
| Loading entire table | Paginate or stream |
| Creating objects in hot loop | Object pooling or pre-allocation |
| Logging in tight loop | Conditional/sampled logging |
| Retrying failed calls | Exponential backoff with jitter |

## Verification

- [ ] No unnecessary allocations in hot paths
- [ ] I/O operations are async
- [ ] Independent operations are parallelized
- [ ] No N+1 query patterns
- [ ] Caching applied where data is stable and frequently read
