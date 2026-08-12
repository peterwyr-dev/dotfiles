# Kitty Top Padding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the tmux top status line touch Kitty's top content edge while preserving padding on the other three sides.

**Architecture:** Patch a temporary copy, validate it with Kitty 0.48.2, and copy it back to the hard-linked real config. Reload Kitty after validation.

**Tech Stack:** Kitty 0.48.2 configuration, `kitty +runpy`, Kitty remote control

## Global Constraints

- Parsed padding must be left 15, top 0, right 15, bottom 15.
- Preserve all unrelated Kitty configuration.
- Keep `/Users/wangyiran/.config/kitty/kitty.conf` and `/Users/wangyiran/my_config/kitty/kitty.conf` hard-linked.

---

### Task 1: Patch, validate, and install the padding change

**Files:**
- Modify: `/Users/wangyiran/.config/kitty/kitty.conf`
- Stage: `/private/tmp/kitty-top-padding-20260803.conf`
- Backup: `/private/tmp/kitty-config-before-top-padding-20260803.conf`

**Interfaces:**
- Consumes: Kitty `window_padding_width` CSS edge syntax
- Produces: `window_padding_width 0 15 15 15`

- [x] Confirm current padding parses to 15 on all four edges.
- [x] Back up and patch a temporary copy.
- [x] Validate the candidate as left 15, top 0, right 15, bottom 15.
- [x] Install the candidate after approval and verify both paths remain hard-linked.
- [x] Reload Kitty configuration and re-check the installed value.

No commit step is included because this task changes a user-level runtime configuration.
