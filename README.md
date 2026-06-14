# BARU's Neovim Integrated with i3

<p align="center">
  <img src="https://github.com/6aru/nvim/blob/main/Screenshot.png" alt="Screenshot" width="100%">
</p>

<p align="center">

![Neovim](https://img.shields.io/badge/Neovim-Stable-green)

![GitHub stars](https://img.shields.io/github/stars/6aru/nvim)

![GitHub forks](https://img.shields.io/github/forks/6aru/nvim)

![GitHub last commit](https://img.shields.io/github/last-commit/6aru/nvim)

</p>

---

## Features

- Lightweight custom Neovim configuration
- Built from scratch
- No LazyVim
- No NvChad
- No AstroNvim
- Automatic i3 theme synchronization
- Oil.nvim file explorer
- FZF-Lua fuzzy finder
- Treesitter syntax highlighting
- Alpha dashboard
- Lualine statusline
- Bufferline tabs
- Git integration
- Markdown workflow
- Transparent background support
- Simple plugin manager written in Lua

---

## Theme Integration

This configuration automatically reads:

```text
~/.config/i3/.current_theme
```

and applies the matching Neovim colorscheme.

Supported themes:

- Gruvbox
- Nord
- Dracula
- Catppuccin Frappe
- Rose Pine Moon
- Kanagawa Wave
- Everforest
- GitHub Dark
- Moonfly

This allows Neovim to stay synchronized with the active i3 theme.

---

## Requirements

### Required

- Neovim ≥ 0.11
- Git

### Recommended

- Ripgrep
- FZF
- fd
- NodeJS
- npm

### Optional

- Prettier
- Nerd Font (JetBrainsMono Nerd Font recommended)

---

## Installation

```bash
git clone https://github.com/USERNAME/nvim.git

mkdir -p ~/.config

cp -r nvim ~/.config/
```

Launch:

```bash
nvim
```

Plugins install automatically on first launch.

---

## Plugins

### Navigation

- Oil.nvim
- FZF-Lua

### UI

- Alpha.nvim
- Lualine.nvim
- Bufferline.nvim
- Indent Blankline
- Which Key
- Colorizer

### Editing

- Treesitter
- Comment.nvim
- nvim-surround
- nvim-autopairs

### Git

- vim-fugitive
- gitsigns.nvim

### Markdown

- render-markdown.nvim
- markdown-preview.nvim
- autolist.nvim

### Themes

- Gruvbox
- Nord
- Dracula
- Catppuccin
- Rose Pine
- Kanagawa
- Everforest
- GitHub Dark
- Moonfly

---

## Keybindings

| Key | Action |
|------|---------|
| Space+ff | Find Files |
| Space+fw | Live Grep |
| Space+fh | Help Tags |
| Space+fc | Search Config |
| Space+e | File Explorer |
| Space+t | New Tab |
| Space+x | Close Tab |
| Space+j | Next Tab |
| Space+k | Previous Tab |
| Tab | Next Buffer |
| Shift+Tab | Previous Buffer |
| Space+gg | Git Status |
| Space+gb | Git Branches |
| Space+pp | Markdown Preview |
| Space+pf | Format File |

---

## Directory Layout

```text
nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── autocmds.lua
│   │
│   ├── plugins/
│   │   ├── ui.lua
│   │   ├── navigation.lua
│   │   ├── editing.lua
│   │   ├── git.lua
│   │   ├── treesitter.lua
│   │   └── todo.lua
│   │
│   ├── themes/
│   │   └── theme-loader.lua
│   │
│   ├── plugin-list.lua
│   └── plugin-manager.lua
│
└── .gitignore
```

---

## Credits

Foundation and inspiration from:

- https://github.com/tonybanters/nvim
- https://codeberg.org/justaguylinux
