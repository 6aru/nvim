# ⚡ Ultimate Neovim Config

> A clean, understandable, LSP-powered Neovim config with zero plugin-manager
> framework and colors that always match your terminal.

See **[GUIDE.md](./GUIDE.md)** for the full step-by-step setup, keymap
reference, and troubleshooting guide.

---

## 🎯 Philosophy

* **Lightweight:** Minimal overhead, instant startup times.
* **Understandable:** No plugin-manager framework, no abstraction layers —
  pure, readable Lua you can fully read in one sitting.
* **Synchronized:** Colors always follow your terminal's own theme — no
  colorscheme plugins, no switching commands.

## ✨ Features

* ⚡ **Zero-Framework Lua Engine:** A ~90-line custom plugin loader (plain
  `git clone`, no Lazy/Packer).
* 🧠 **Full LSP + completion + formatting:** `nvim-lspconfig` + `mason.nvim`
  + `blink.cmp` + `conform.nvim`.
* 📁 **Modern navigation:** `nvim-tree.lua` sidebar, `fzf-lua`, `flash.nvim`, Harpoon2,
  session persistence.
* 🎨 **Terminal-native colors:** one `colors/terminal.lua` scheme that reads
  its palette from your terminal's own 16 ANSI colors — change your
  terminal theme, Neovim follows.
* 🪟 **Free transparency:** no background is ever forced, so a transparent
  terminal shows straight through.
* 🔁 **Multi-config switching:** `bin/nvim-switch` picks between separate
  Neovim config profiles via `NVIM_APPNAME`.
