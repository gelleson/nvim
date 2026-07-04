# nvim

AstroNvim v5+ personal configuration.

## Install

```bash
bash <(curl -s https://raw.githubusercontent.com/gelleson/nvim/main/install.sh)
```

### Install with GitHub CLI

If you prefer using [`gh`](https://cli.github.com/) instead of `git clone`/`curl`, authenticated with a token (e.g. `GH_TOKEN`):

```bash
GH_TOKEN=<your_token> sh -c '[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s); gh repo clone gelleson/nvim ~/.config/nvim'
```

Then run `nvim` — plugins install automatically on first launch.

## Prerequisites

- Neovim 0.10+
- git
- [GitHub CLI](https://cli.github.com/) (`gh`) — only required for the `gh repo clone` install method
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

## Language Packs

Lua, Rust, Python, Go, Gleam, TypeScript, YAML, TOML, Java, Zig, SQL, Nix, JSON, Helm, Angular, Markdown, Just, Dart

## Extras

- [neotest](https://github.com/nvim-neotest/neotest) for test running
- [opencode-nvim](https://github.com/AstroNvim/astrocommunity) AI integration
