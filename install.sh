#!/usr/bin/env bash
set -e

NVIM_DIR="$HOME/.config/nvim"

install_nvim() {
  echo "Installing Neovim..."
  if command -v brew &>/dev/null; then
    brew install neovim
  elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update && sudo apt-get install -y neovim
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y neovim
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm neovim
  else
    echo "Could not detect package manager. Install Neovim manually: https://github.com/neovim/neovim/releases"
    exit 1
  fi
}

if ! command -v nvim &>/dev/null; then
  install_nvim
else
  NVIM_VER=$(nvim --version | head -1 | grep -oP '\d+\.\d+')
  if [ "$(echo "$NVIM_VER < 0.10" | bc)" -eq 1 ]; then
    echo "Neovim $NVIM_VER found, but 0.10+ is required. Upgrading..."
    install_nvim
  fi
fi

if [ -d "$NVIM_DIR" ]; then
  BACKUP="$NVIM_DIR.bak.$(date +%s)"
  echo "Backing up existing config to $BACKUP"
  mv "$NVIM_DIR" "$BACKUP"
fi

git clone https://github.com/gelleson/nvim.git "$NVIM_DIR"

echo "Done! Run 'nvim' to get started."
