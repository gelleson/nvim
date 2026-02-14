#!/usr/bin/env bash
set -e

NVIM_DIR="$HOME/.config/nvim"

if ! command -v nvim &>/dev/null; then
  echo "Neovim not found, installing..."
  if command -v brew &>/dev/null; then
    brew install neovim
  elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install -y neovim
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y neovim
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm neovim
  else
    echo "Could not detect package manager. Install Neovim manually: https://github.com/neovim/neovim/releases"
    exit 1
  fi
fi

if [ -d "$NVIM_DIR" ]; then
  BACKUP="$NVIM_DIR.bak.$(date +%s)"
  echo "Backing up existing config to $BACKUP"
  mv "$NVIM_DIR" "$BACKUP"
fi

git clone https://github.com/gelleson/nvim.git "$NVIM_DIR"

echo "Done! Run 'nvim' to get started."
