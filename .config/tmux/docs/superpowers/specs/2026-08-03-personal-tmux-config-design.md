# Personal tmux Configuration Design

## Goal

Keep the existing Catppuccin and status-line configuration unchanged while adding a small personal configuration layer at the top of `tmux.conf`.

## Behavior

- Replace the default prefix with `C-s`; pressing `C-s C-s` sends `C-s` to the active program.
- Enable mouse support, a 100,000-line history, one-based window/pane numbering, automatic window renumbering, and Vi copy-mode keys.
- Make new windows and splits inherit the active pane's working directory.
- Add `|` and `-` split bindings without removing tmux's original split bindings.
- Add `h`, `j`, `k`, `l` pane navigation and repeatable `H`, `J`, `K`, `L` five-cell resizing.
- Bind `r` to reload this exact config file and show a confirmation.
- Do not add custom `v` or `y` copy-mode bindings.

## Verification

Load the file into an isolated tmux server, query the effective options and key tables, and confirm the existing Catppuccin section remains unchanged.
