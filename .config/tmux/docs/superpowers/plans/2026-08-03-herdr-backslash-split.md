# Herdr Backslash Split Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Change Herdr side-by-side splitting from `prefix+|` to `prefix+\`.

**Architecture:** Patch a temporary copy, validate it with Herdr 0.7.5, then install the validated file. Preserve every unrelated line.

**Tech Stack:** Herdr 0.7.5, TOML, `herdr config check`

## Global Constraints

- Side-by-side split uses `Ctrl+s` followed by backslash.
- Stacked split remains `prefix+minus`.
- Preserve all unrelated Herdr settings.

---

### Task 1: Replace and verify the Herdr split binding

**Files:**
- Modify: `/Users/wangyiran/.config/herdr/config.toml`
- Stage: `/private/tmp/herdr-backslash-split-20260803.toml`
- Backup: `/private/tmp/herdr-config-before-backslash-20260803.toml`

**Interfaces:**
- Consumes: Herdr keybinding parser and TOML backslash escaping
- Produces: a validated backslash split binding

- [x] Confirm the current binding is `prefix+|`.
- [x] Back up and patch a temporary copy.
- [x] Require `herdr config check` to pass on the candidate.
- [x] Install and revalidate the real configuration.

No commit step is included because the target is a user-level runtime configuration.
