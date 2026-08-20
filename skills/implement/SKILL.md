---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

# Implement Skill

## Metadata

- **Name**: implement
- **Always Active**: No
- **Trigger**: Implement a piece of work based on a spec or set of tickets.
- **Source**: Adapted from [mattpocock/skills](https://github.com/mattpocock/skills) (MIT) — `skills/engineering/implement`

## Purpose

Implement a spec or set of tickets test-first, then review the work before committing.

---

Implement the work described by the user in the spec or tickets.

Use the `test-case-design` skill where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit your work to the current branch.
