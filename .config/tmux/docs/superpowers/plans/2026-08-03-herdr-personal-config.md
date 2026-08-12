# Herdr Personal Configuration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add tmux-style basic bindings to Herdr without changing unrelated defaults.

**Architecture:** Stage the complete TOML file under `/private/tmp`, validate it with Herdr 0.7.5, then copy the validated file to `~/.config/herdr/config.toml`. The existing config contains only `onboarding = false`, which remains intact.

**Tech Stack:** Herdr 0.7.5, TOML, `herdr config check`

## Global Constraints

- Prefix is `ctrl+s`.
- No resize bindings are needed.
- Preserve `onboarding = false`.
- Do not change Herdr theme or agent/workspace behavior.

---

### Task 1: Stage, validate, and install the Herdr config

**Files:**
- Modify: `/Users/wangyiran/.config/herdr/config.toml`
- Stage: `/private/tmp/herdr-personal-config-20260803.toml`

**Interfaces:**
- Consumes: Herdr 0.7.5 keybinding schema
- Produces: a validated Herdr configuration with tmux-style basic controls

- [x] **Step 1:** Confirm the current target lacks `prefix = "ctrl+s"`.
- [x] **Step 2:** Build the complete candidate TOML in the staging file.
- [x] **Step 3:** Run `HERDR_CONFIG_PATH=/private/tmp/herdr-personal-config-20260803.toml herdr config check` and require success.
- [x] **Step 4:** Copy the validated candidate to `/Users/wangyiran/.config/herdr/config.toml` after write approval.
- [x] **Step 5:** Re-run `herdr config check` against the installed file and reload only when `herdr status server` reports a running server.

No commit step is included because the Herdr configuration directory is not a Git repository.
