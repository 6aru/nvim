<div align="center">

<p align="center">
  <a href="https://neovim.io/"><img src="https://img.shields.io/badge/Neovim-0.12.4-57A143?style=for-the-badge&logo=neovim&logoColor=181818" alt="Neovim"></a>
  <a href="https://github.com/6aru/nvim/stargazers"><img src="https://img.shields.io/github/stars/6aru/neovim?style=for-the-badge&color=181818" alt="Stars"></a>
  <a href="https://github.com/6aru/nvim/network/members"><img src="https://img.shields.io/github/forks/6aru/neovim?style=for-the-badge&color=181818" alt="Forks"></a>
  <a href="https://github.com/6aru/nvim/commits/main"><img src="https://img.shields.io/github/last-commit/6aru/neovim?style=for-the-badge&color=181818" alt="Last Commit"></a>
</p>

A minimal, LSP-powered Neovim config with no plugin-manager framework —
and colors that always match your terminal.

</div>

---

## Why

Most Neovim configs ship a colorscheme. This one doesn't — it reads
yours. `colors/terminal.lua` renders using your terminal's own 16 ANSI
colors instead of a fixed palette, so changing your terminal's theme
changes Neovim's, automatically. No `:colorscheme` switching, no theme
plugins, no config to touch.

Everything else follows the same idea: a small, readable set of plugins,
wired together by hand, with nothing hidden behind a framework.

## Features

- **Zero-framework plugin manager** — a ~90 line loader, plain `git
  clone`, no Lazy or Packer
- **Full LSP stack** — `nvim-lspconfig` + `mason.nvim` + `blink.cmp` +
  `conform.nvim`, native `vim.lsp.enable()`
- **Terminal-native colors** — one scheme, always in sync with your
  terminal's theme, free transparency included
- **Fast navigation** — sidebar file tree, fuzzy finding, single-key
  motions, file pinning, session persistence
- **Multi-config switching** — hop between separate Neovim setups with
  one command

## Requirements

- Neovim 0.11+
- git, a C compiler
- A terminal with 16-color ANSI theming

Full list, including recommended tools and formatters, is in the
[wiki](../../wiki/Requirements).

## Install

```bash
git clone https://github.com/6aru/nvim.git ~/.config/nvim
nvim
```

Plugins clone themselves on first launch. See the
[Installation](../../wiki/Installation) and
[Post-Installation Setup](../../wiki/Post-Installation-Setup) wiki pages
for what to do next.

## Documentation

| | |
|---|---|
| [Requirements](../../wiki/Requirements) | What needs to be on your system |
| [Installation](../../wiki/Installation) | Step-by-step setup |
| [Keymaps](../../wiki/Keymaps) | Full keybinding reference |
| [Colorscheme](../../wiki/Colorscheme) | How the terminal-matching colors work |
| [Multi-Config Switching](../../wiki/Multi-Config-Switching) | Running more than one Neovim setup |
| [Troubleshooting](../../wiki/Troubleshooting) | Fixes for common issues |

## License

MIT
