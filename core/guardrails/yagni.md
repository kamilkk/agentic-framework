# YAGNI (You Aren't Gonna Need It)

> Scope lock and minimalism enforcement. Applied to ALL code generation.

## Core Principle

**Build exactly what's asked. Nothing more.** Every line of code is a liability — maintenance cost, bug surface, cognitive load. The best code is code you don't write.

## Decision Table

| Situation | YAGNI Response |
|-----------|---------------|
| "Should I add error handling for X?" | Only if X can actually happen in the current flow |
| "Should I add a helper/utility?" | Only if used 2+ times RIGHT NOW (not "might be useful later") |
| "Should I add logging?" | Only at system boundaries and error paths |
| "Should I add comments?" | Only if the WHY is non-obvious. Never explain WHAT code does |
| "Should I add types/interfaces?" | Only if consumed by multiple callers RIGHT NOW |
| "Should I add validation?" | Only at system boundaries (API input, user input) |
| "Should I add tests?" | Only for the code actually written, not hypothetical scenarios |
| "Should I refactor while here?" | NO. Scope lock. Make the change, nothing more |
| "Should I add config for this?" | Only if it actually varies between environments |
| "Should I use a design pattern?" | Only if the pattern solves a CURRENT problem, not a future one |

## The Subtraction Heuristic

Before adding anything, ask:
1. Can I achieve this by **deleting** code?
2. Can I achieve this by **reusing** an existing function?
3. Can I achieve this with **fewer** dependencies?
4. Can I achieve this with a **simpler** data structure?

If YES to any → do that instead.

## Dependency Diet

- **No new packages** unless standard library is provably impossible
- **No framework upgrades** unless required by the task
- **No new abstractions** unless 3+ consumers exist RIGHT NOW
- **No wrapper libraries** around things that work fine directly

## Scope Lock Protocol

Once task scope is established:
1. **LOCK** — Define exactly what changes are needed
2. **EXECUTE** — Make only those changes
3. **VERIFY** — Check no extra changes crept in
4. **STOP** — Do not "improve" adjacent code

## Anti-Patterns (Things YAGNI Prevents)

- ❌ "While I'm here, let me also fix..."
- ❌ "This might be useful later..."
- ❌ "Best practice says we should also..."
- ❌ "Let me add extensibility for..."
- ❌ "I'll add a factory in case we need..."
- ❌ "Let me abstract this in case..."
- ❌ Adding TODO comments for "future improvements"
- ❌ Creating interfaces with single implementations
- ❌ Adding configuration for hardcoded values that never change
