# White-Box Tracing Skill

## Metadata

- **Name**: white-box-tracing
- **Always Active**: No
- **Trigger**: Verifying code changes via path tracing, fault localization, coverage analysis, program slicing, or when explaining/applying structural code analysis methods.

## Purpose

Guides white-box tracing and structural code analysis — control flow, data flow, program slicing, symbolic execution, fault localization, and coverage analysis. Use to verify correctness of code changes with evidence.

## Methods

### 1. Control Flow Graph (CFG) Traversal

Trace all paths through a function/method:
- Identify entry point and all exit points
- Map branching (if/else, switch, try/catch)
- Identify loops and their termination conditions
- Report: all paths enumerated with conditions

### 2. Data Flow Analysis

Track how data moves through the system:
- **Definition**: Where is the variable assigned?
- **Use**: Where is it read?
- **Kill**: Where is it overwritten?
- Track: def-use chains for variables of interest

### 3. Program Slicing

Extract the subset of code that affects a specific variable/output:

- **Forward slice**: "What does this variable affect downstream?"
- **Backward slice**: "What code contributed to this value?"
- Report: minimal set of statements in the slice

### 4. Fault Localization (SBFL)

When a bug exists, rank suspicious statements:
- Use Spectrum-Based Fault Localization formulas (Ochiai, Tarantula)
- Suspiciousness = f(passed tests executing line, failed tests executing line)
- Rank statements by suspiciousness score

### 5. Coverage Analysis

Verify test/path coverage:
- **Statement coverage**: Which lines are exercised?
- **Branch coverage**: Which decision outcomes are tested?
- **Path coverage**: Which complete paths are traversed?
- Report: uncovered paths/branches

## Application Protocol

### When Verifying a Code Change

```
1. Identify modified function(s)
2. Build CFG for each modified function
3. Enumerate all paths through the change
4. For each path:
   a. Define input conditions that trigger this path
   b. Trace data flow through the path
   c. Verify output/side-effects are correct
5. Report:
   - Paths verified: N
   - All paths produce correct results: YES/NO
   - Uncovered paths: {list}
```

### When Investigating a Bug

```
1. Identify the failure point (file:line)
2. Backward slice from failure point
3. Identify all variables contributing to failure
4. For each variable in slice:
   a. Trace definitions and uses
   b. Identify where unexpected value originates
5. Report root cause with evidence chain
```

## Output Format

```markdown
## Trace Report: {Function/Change}

### Paths Enumerated
| # | Path | Condition | Result |
|---|------|-----------|--------|
| 1 | {A→B→C} | {when X > 0} | ✅ Correct |
| 2 | {A→B→D} | {when X ≤ 0} | ❌ Bug — {detail} |

### Data Flow
- `variable`: defined at {file:line}, used at {file:line}

### Verdict: {PASS/FAIL}
{Evidence summary}
```
