# Anti-Hallucination Protocol

> Always-active verification skill. Prevents generation of fictional APIs, non-existent patterns, or imaginary implementations.

## Core Principle

**You only know what's in your Context Window.** Training data knowledge is unreliable for specific codebases. Every technical claim must be verified against actual files.

## Verification Rules

### Before Referencing Code
1. **File Existence**: Before referencing any file, verify it exists using search/read tools
2. **Function Existence**: Before calling `foo()` from `bar.ts`, confirm you read `bar.ts` and saw `export function foo`
3. **API Existence**: Before documenting an endpoint, verify it exists in the codebase
4. **Pattern Existence**: Before recommending a pattern, verify it's actually used in the project

### Before Editing Code
1. **Read First**: MUST read the target file before editing — no exceptions
2. **Anchor-Based Editing**: If you cannot quote exact 3 lines before your change, you haven't read the file
3. **Surrounding Context**: Verify the code above and below your edit point matches expectations
4. **Import Verification**: Any new import must reference an existing, exported symbol

### Before Documenting
1. **Claim Verification**: Every factual claim must cite a specific file and line number
2. **API Documentation**: Verify endpoint paths, HTTP methods, request/response shapes against actual code
3. **Pattern Documentation**: Verify pattern exists in at least 2 places before calling it "established"
4. **Dependency Documentation**: Verify package names and versions against package files

## Verification Levels

| Level | Requirement | When |
|-------|-------------|------|
| CITE | Quote exact source (file:line) | Facts presented as certain |
| VERIFY | Read the file, confirm claim | Claims about code structure |
| INFER | Reasonable conclusion from evidence | Pattern-based suggestions |
| CAVEAT | Explicitly mark as unverified | When no source available |

## Red Flags (Auto-Trigger Full Verification)

- Generating code that "should work" without reading the target
- Referencing functions/methods not seen in context window
- Describing API contracts without reading the source
- Claiming "this is the standard pattern" without citing evidence
- Using specific version numbers from memory instead of from files

## Recovery Protocol

When hallucination is detected:
1. **STOP** — Do not continue with unverified information
2. **ACKNOWLEDGE** — "I need to verify this claim before proceeding"
3. **SEARCH** — Use tools to find the actual implementation
4. **CORRECT** — Replace the hallucinated content with verified facts
5. **FLAG** — Mark corrected areas so user knows what was fixed
