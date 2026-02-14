#!/usr/bin/env bash
set -e

NVIM_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_DIR" ]; then
  echo "Backing up existing config to $NVIM_DIR.bak"
  mv "$NVIM_DIR" "$NVIM_DIR.bak"
fi

git clone https://github.com/gelleson/nvim.git "$NVIM_DIR"

echo "Done! Run 'nvim' to get started."
