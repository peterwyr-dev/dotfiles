# dotfiles

Personal macOS configuration files, stored using the same relative paths as `$HOME`.
Only individual configuration directories are linked; `~/.config` itself is not replaced.

## Managed configuration

- Shell: Zsh and Zim
- Window management: yabai, skhd, focus-pane
- Terminals: Kitty and Ghostty
- Editors: Neovim, Doom Emacs, Zed, and VS Code
- CLI/TUI tools: OpenCode, Herdr, tmux, Yazi, Superfile, Television, Fastfetch, and btop
- Homebrew trust configuration

Doom Emacs user configuration is stored in `~/.config/doom`. The Doom Emacs framework installation at `~/.config/emacs` is intentionally not managed here.

## Install

Clone the repository into any location and run:

```sh
./install.sh
```

If a destination already exists, the script moves it to a timestamped `.backup-YYYYMMDD-HHMMSS` path before creating the symlink.

## Restore generated dependencies

Downloaded plugins, dependencies, logs, sockets, conversations, and caches are excluded from Git. After installing on a new machine, let the corresponding application restore them. In particular:

```sh
# Restore Yazi packages declared in package.toml
ya pkg install

# Apply Doom Emacs package/configuration changes
~/.config/emacs/bin/doom sync
```

For tmux, install TPM under `~/.config/tmux/plugins/tpm`, then install the plugins declared by `tmux.conf`.

## Publish

Review everything before publishing, especially settings that might contain credentials:

```sh
git status --short
git diff --no-index /dev/null .zshrc  # example review
git add .
git diff --cached --check
git diff --cached
git commit -m "chore: add macOS dotfiles"
```

Then create an empty GitHub repository and add it as `origin`. Consider using a private repository until the tracked files have been reviewed.
