# Multi-Agent Orchestration Skill

## Metadata

- **Name**: multi-agent-orchestration
- **Always Active**: No
- **Trigger**: When designing multi-agent workflows, choosing orchestration patterns, planning sub-agent architectures, or evaluating delegation strategies.

## Purpose

Science-backed sub-agent orchestration architecture design. Covers pattern selection, topology, task decomposition, context management, error compounding mitigation, and cost optimization.

## Orchestration Patterns

### 1. Pipeline (Sequential)

```
Agent A → Agent B → Agent C → Result
```
- **Use when**: Tasks have strict ordering dependencies
- **Strength**: Simple, predictable, easy to debug
- **Weakness**: Slow (serial), single point of failure

### 2. Router (Dispatch)

```
Router → selects → Agent A | Agent B | Agent C
```
- **Use when**: Different request types need different experts
- **Strength**: Specialization, clear boundaries
- **Weakness**: Router must classify correctly

### 3. Orchestrator-Worker

```
Orchestrator → dispatches → [Worker A, Worker B, Worker C]
             ← collects  ← [Result A, Result B, Result C]
             → synthesizes → Final Result
```
- **Use when**: Independent subtasks can run in parallel
- **Strength**: Fast (parallel), scalable
- **Weakness**: Orchestrator complexity, context management

### 4. Evaluator-Optimizer

```
Generator → Evaluator → (feedback loop) → Generator → ... → Approved
```
- **Use when**: Quality matters more than speed
- **Strength**: Iterative improvement
- **Weakness**: Expensive, potential infinite loops (cap iterations)

### 5. Best-of-N

```
[Agent A, Agent B, Agent C] → Evaluator → Best Result
```
- **Use when**: High-stakes decisions needing consensus/verification
- **Strength**: Robustness, catches individual errors
- **Weakness**: N× cost

## Pattern Selection Decision Tree

```
Is the task decomposable into independent parts?
  YES → Are parts truly independent (no data dependencies)?
    YES → Orchestrator-Worker (parallel)
    NO  → Pipeline (sequential)
  NO → Is it a classification/routing problem?
    YES → Router
    NO  → Is quality critical (willing to pay N×)?
      YES → Best-of-N or Evaluator-Optimizer
      NO  → Single agent (don't orchestrate)
```

## Task Decomposition Rules

1. **Atomic tasks**: Each sub-task has single responsibility
2. **Clear contracts**: Define input/output schema for each worker
3. **No shared state**: Workers communicate only through orchestrator
4. **Idempotent workers**: Safe to retry on failure
5. **Bounded context**: Each worker gets minimum necessary context

## Error Compounding Mitigation

Multi-agent systems amplify errors. Mitigation:

| Risk | Mitigation |
|------|-----------|
| Worker produces incorrect output | Validate against schema before synthesis |
| Worker hallucinates | Anti-hallucination skill on each worker |
| Context lost between agents | Pass explicit context, not implicit |
| Conflicting results | Conflict resolution protocol (majority/weighted) |
| Cascade failure | Timeout + graceful degradation per worker |

## Context Management

```
RULE: Each worker gets EXACTLY what it needs. No more.
- Input contract: {schema definition}
- Available tools: {restricted list}
- Time budget: {maximum duration}
- Output contract: {expected shape}
```

## Anti-Patterns

- ❌ Passing entire conversation to sub-agents (context explosion)
- ❌ Letting workers call other workers directly (mesh chaos)
- ❌ No timeout on worker execution
- ❌ Trusting worker output without validation
- ❌ Orchestrating when a single agent suffices (overhead > benefit)
