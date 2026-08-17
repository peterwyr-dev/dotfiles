#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
BACKUP_TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

paths=(
  ".zshenv"
  ".yabairc"
  ".hermes"
  ".codex"
  ".pi"
  ".claude"
  ".config/nvim"
  ".config/zsh"
  ".config/herdr"
  ".config/kitty"
  ".config/opencode"
  ".config/skhd"
  ".config/focus-pane"
  ".config/ghostty"
  ".config/superfile"
  ".config/tmux"
  ".config/fastfetch"
  ".config/btop"
  ".config/doom"
  ".config/homebrew"
  ".config/television"
  ".config/zed"
  ".config/yazi"
  "Library/Application Support/Code/User/settings.json"
  "Library/Application Support/Code/User/keybindings.json"
)

next_backup_path() {
  local destination="$1"
  local backup="${destination}.backup-${BACKUP_TIMESTAMP}"
  local counter=1

  while [[ -e "$backup" || -L "$backup" ]]; do
    backup="${destination}.backup-${BACKUP_TIMESTAMP}-${counter}"
    ((counter += 1))
  done

  printf '%s\n' "$backup"
}

link_path() {
  local relative="$1"
  local source="${DOTFILES_DIR}/${relative}"
  local destination="${HOME}/${relative}"
  local backup

  if [[ ! -e "$source" && ! -L "$source" ]]; then
    printf 'Missing source, skipping: %s\n' "$source" >&2
    return
  fi

  mkdir -p "$(dirname "$destination")"

  if [[ -L "$destination" ]] && [[ "$(readlink "$destination")" == "$source" ]]; then
    printf 'Already linked: ~/%s\n' "$relative"
    return
  fi

  if [[ -e "$destination" || -L "$destination" ]]; then
    backup="$(next_backup_path "$destination")"
    mv "$destination" "$backup"
    printf 'Backed up: %s -> %s\n' "$destination" "$backup"
  fi

  ln -s "$source" "$destination"
  printf 'Linked: ~/%s -> %s\n' "$relative" "$source"
}

for path in "${paths[@]}"; do
  link_path "$path"
done

printf '\nDotfiles installation complete.\n'
