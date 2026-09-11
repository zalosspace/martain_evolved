#!/usr/bin/env bash

set -e

read -rp "Restore will overwrite existing files. Continue? [y/N]: " ans
[[ "$ans" != "y" ]] && exit 1

echo "♻️ Restoring previous rice..."

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Restore ~/.config contents 
if [ -d "$HOME/backup.config" ]; then
  for item in "$HOME"/backup.config/*; do
    name=$(basename "$item")
    echo "→ Restoring .config/$name"
    mv "$item" "$HOME/.config/"
  done
fi

# Restore home dotfiles
if [ -d "$HOME/backup.home" ]; then
  for item in "$HOME"/backup.home/*; do
    name=$(basename "$item")
    echo "→ Restoring ~/$name"
    mv "$item" "$HOME/"
  done
fi

echo "Restore complete."
echo "Restart bspwm if needed: bspc wm -r"

