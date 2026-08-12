# Personal tmux Configuration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the approved personal tmux controls without changing the existing theme and status-line setup.

**Architecture:** Put all user controls under the existing `# My personal config` heading. Leave the Catppuccin block byte-for-byte unchanged.

**Tech Stack:** tmux 3.7b configuration, zsh, macOS `pbcopy` compatibility through tmux's normal buffer behavior only (no custom copy bindings)

## Global Constraints

- Prefix must be `C-s`.
- Do not add custom `v` or `y` bindings.
- Preserve the existing Catppuccin and status-line configuration.

---

### Task 1: Add and verify personal controls

**Files:**
- Modify: `tmux.conf`
- Test: isolated tmux server started with `tmux -S /private/tmp/codex-tmux-config.sock -f tmux.conf`

**Interfaces:**
- Consumes: tmux 3.7b configuration syntax
- Produces: effective global options and prefix-table bindings

- [x] **Step 1: Run assertions against the current config and confirm the required prefix is absent.**
- [x] **Step 2: Add the approved options and bindings under `# My personal config`.**
- [x] **Step 3: Load the complete file in an isolated tmux server.**
- [x] **Step 4: Query options and bindings; confirm `C-s`, inherited-directory creation/splits, navigation, resizing, reload, and no custom `v`/`y`.**
- [x] **Step 5: Compare the Catppuccin block with its pre-edit snapshot.**

No commit step is included because `/Users/wangyiran/.config/tmux` is not a Git repository.
