# dotfiles

Personal macOS configuration files, stored using the same relative paths as `$HOME`.
Only individual configuration directories are linked; `~/.config` itself is not replaced.

## Managed configuration

- Shell: Zsh and Zim
- Window management: yabai, skhd, focus-pane
- Terminals: Kitty and Ghostty
- Editors: Neovim, Doom Emacs, Zed, and VS Code
- AI agents: Hermes, Codex, Pi, Claude Code, OpenCode, and Herdr
- CLI/TUI tools: tmux, Yazi, Superfile, Television, Fastfetch, and btop
- Homebrew trust configuration

Doom Emacs user configuration is stored in `~/.config/doom`. The Doom Emacs framework installation at `~/.config/emacs` is intentionally not managed here.

## Install

Clone the repository into any location and run:

```sh
./install.sh
```

If a destination already exists, the script moves it to a timestamped `.backup-YYYYMMDD-HHMMSS` path before creating the symlink.

## Restore generated dependencies

Downloaded plugins, dependencies, logs, sockets, conversations, caches, AI-agent credentials, and session history are excluded from Git. The complete AI-agent state directories are still stored under this checkout so the applications can write through their top-level symlinks without changing their expected paths.

Codex and Claude Code currently keep provider tokens inside their main configuration files. Sanitized examples are tracked instead; on a new machine, create the local ignored copies and then insert the tokens:

```sh
cp ~/.codex/config.example.toml ~/.codex/config.toml
cp ~/.claude/settings.example.json ~/.claude/settings.json
chmod 600 ~/.codex/config.toml ~/.claude/settings.json
```

Authenticate Hermes, Codex, Pi, and Claude Code normally to recreate their ignored credential files. Never force-add `auth.json`, `.env`, `config.toml`, or `settings.json` from these agent directories.

After installing on a new machine, let each application restore its generated data. In particular:

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
