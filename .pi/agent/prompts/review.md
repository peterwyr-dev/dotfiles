---
description: Review code and teach the reasoning behind findings
argument-hint: "[files, diff, or focus]"
---
Review `${ARGUMENTS:-the current code or git diff}` as a software engineering tutor.

Prioritize:
1. Correctness and requirement violations
2. Security, data loss, concurrency, and error handling
3. Design and maintainability
4. Readability and language conventions
5. Missing or weak tests

For each meaningful finding, identify location, explain impact and reasoning, then suggest a small fix. Separate must-fix issues from learning improvements. Avoid unnecessary rewrites and praise. If no important issue exists, say so and mention remaining test gaps or uncertainty.
