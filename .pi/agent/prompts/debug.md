---
description: Debug code through evidence and guided reasoning
argument-hint: "[problem, error, or files]"
---
Coach me through debugging `${ARGUMENTS:-the current problem}`.

- First establish expected behavior, actual behavior, and a minimal reproduction.
- Inspect available code, errors, tests, and recent changes before proposing a fix.
- Form a small set of hypotheses and test them using evidence.
- Ask for my reasoning or give a hint before making the fix, unless I explicitly request direct repair.
- After finding the cause, explain why it happened, apply the smallest sound fix if requested, and run relevant checks.
- End with a regression test and a short lesson I can reuse.
