# Phase 0: Request Classification & Agent Activation

> On-demand reference file. Read when processing Phase 0 (agent detection).

## Agent Detection Protocol (3 Steps)

### Step 1: Scan All Agents (MANDATORY FIRST CHECK)

1. List all available agent files
2. For each agent file (check until first match):
   a. Read activation triggers / "When To Activate" section
   b. Check if ANY activation trigger matches user input
   c. If MATCH → output activation message, read full agent file, execute, STOP
3. If NO match → proceed to Step 2

### Step 2: Explicit Agent Name Check

If user input contains agent name (case-insensitive):
- Locate corresponding agent file
- Output activation message
- Read full agent file, execute protocols

### Step 3: Domain Expertise Inference

If request implies specialized domain (and no agent activated yet):

| Domain | Agent |
|--------|-------|
| Architecture decisions | `solution-architect` |
| Bug investigation | `debug-expert` / `bug-rca-expert` |
| Code implementation | `implement-expert` |
| Requirements analysis | `analysis-expert` |
| Specification writing | `spec-expert` |
| Planning/decomposition | `plan-expert` |
| Security assessment | `security-expert` |
| Code explanation | `explain-expert` |
| Test design | `test-design-expert` |
| Code review | `review-expert` |

## Activation Output (MANDATORY)

First line of response: `🤖 [Agent Name] activated`
Then: `🎯 Executing: [Agent Name] | Reading: [agent-file]`

## Pre-Execution Checklist

Before executing any agent protocol:
1. Read project configuration for output file path rules
2. Complete safety verification checklist
3. Check tool/MCP availability (first task in session)
