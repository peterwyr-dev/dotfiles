# tmux Top Status Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move the tmux status line from the bottom to the top.

**Architecture:** Add one native global tmux option under `# General usability`. Do not edit the Catppuccin block.

**Tech Stack:** tmux 3.7b configuration

## Global Constraints

- Effective `status-position` must be `top`.
- Existing status styling and content must remain unchanged.

---

### Task 1: Set and verify the status position

**Files:**
- Modify: `tmux.conf`
- Test: isolated tmux server

**Interfaces:**
- Consumes: tmux global option `status-position`
- Produces: a top-positioned status line

- [x] Confirm the current effective value is `bottom`.
- [x] Add `set -g status-position top` under `# General usability`.
- [x] Load the full config in an isolated server and require `status-position top`.
- [x] Confirm the Catppuccin block hash is unchanged.

No commit step is included because this directory is not a Git repository.
