# ⚡ BARU's Neovim

> A clean, modern, and scratch-built Neovim configuration seamlessly integrated with the i3 window manager.

<p align="center">
  <img src="https://github.com/6aru/nvim/blob/main/Screenshot.png" alt="BARU Neovim Workspace" width="100%" style="border-radius: 8px;">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-≥_0.11-85EA2D?style=flat-square&logo=neovim&logoColor=white" alt="Neovim Version">
  <img src="https://img.shields.io/github/stars/6aru/nvim?style=flat-square&color=DFAF87" alt="Stars">
  <img src="https://img.shields.io/github/forks/6aru/nvim?style=flat-square&color=8FA87A" alt="Forks">
  <img src="https://img.shields.io/github/last-commit/6aru/nvim?style=flat-square&color=88C0D0" alt="Last Commit">
</p>

---

## ✨ Features

*   ** Pure Vanilla Spirit:** Built entirely from scratch. No LazyVim, NvChad, or AstroNvim bloat—just pure, optimized Lua.
*   **🔄 Dynamic i3 Sync:** Automatically detects your active i3 window manager theme and adapts Neovim's colorscheme instantly.
*   **📂 Modern Navigation:** Fluid file management with `Oil.nvim` and lightning-fast fuzzy searching via `FZF-Lua`.
*   **🎨 Polished UI:** Featuring an elegant `Alpha` dashboard, a streamlined `Lualine` statusline, and a clean `Bufferline` tab management system with transparency support.
*   **📝 Markdown Optimized:** Out-of-the-box support for autolists, live previews, and gorgeous rendering.

---

## 🎨 Theme Integration

Instead of hardcoding your look, this configuration reads your environment dynamically. It checks your i3 configuration state file:

```text
~/.config/i3/.current_theme
