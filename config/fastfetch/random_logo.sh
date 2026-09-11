#!/usr/bin/env bash

LOGO_DIR="$HOME/.config/fastfetch/logo"
TARGET="$HOME/.config/fastfetch/current.png"

LOGO=$(find "$LOGO_DIR" -type f -name "*.png" | shuf -n 1)
ln -sf "$LOGO" "$TARGET"

