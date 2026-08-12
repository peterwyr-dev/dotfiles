# Herdr Personal Configuration Design

## Goal

Give Herdr the same basic muscle memory as the approved tmux personal configuration while retaining Herdr defaults outside that scope.

## Mapping

- Use `ctrl+s` as the prefix.
- Keep new panes and tabs in the source working directory.
- Enable mouse capture.
- Map tabs to `c`, `p`, `n`, and `1..9`.
- Map side-by-side and stacked splits to `|` and `-`.
- Map pane focus to `h`, `j`, `k`, and `l`.
- Map close, zoom, detach, and reload to `x`, `z`, `d`, and `r`.
- Disable resize mode because its default `prefix+r` conflicts with reload and the user does not need resizing.

## Safety

Preserve `onboarding = false`. Validate a staged file with Herdr 0.7.5 before replacing the real configuration. Reload only if the Herdr server is running.
