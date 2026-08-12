# tmux Backslash Split Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move side-by-side splitting from `prefix+|` to `prefix+\`.

**Architecture:** Change one binding in the personal configuration section and verify the effective prefix table in an isolated tmux server.

**Tech Stack:** tmux 3.7b configuration

## Global Constraints

- `prefix+\` creates a horizontal tmux split and inherits `#{pane_current_path}`.
- The custom `prefix+|` binding must be absent.
- `prefix+-` and all unrelated configuration remain unchanged.

---

### Task 1: Replace and verify the split binding

**Files:**
- Modify: `tmux.conf`
- Test: isolated tmux server prefix table

**Interfaces:**
- Consumes: tmux escaped backslash key syntax
- Produces: `bind-key -T prefix \\ split-window -h -c "#{pane_current_path}"`

- [x] Confirm the current custom binding uses `|`.
- [x] Replace only that binding with an escaped backslash key.
- [x] Load the full configuration and verify `\`, `|`, and `-` bindings.

No commit step is included because this directory is not a Git repository.
