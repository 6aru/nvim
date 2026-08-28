# Your Ultimate Neovim Config — Setup Guide

This is your original config (custom git-clone plugin manager, nvim-tree +
fzf-lua, which-key, etc.) upgraded with a full LSP + completion + formatting
stack, a colorscheme that always matches your terminal, and a few
productivity plugins wired up. Nothing about your existing plugin manager,
options, or most keymaps was thrown away — this builds on top of it.

## 1. What changed, at a glance

| Area | Before | Now |
|---|---|---|
| Colors | 10 downloaded colorscheme plugins + 10 `:Gruvbox`/`:Nord`/etc. commands + a `.theme` file | One `colors/terminal.lua` scheme that renders using your **terminal's own 16 ANSI colors** — no plugin, no switching commands needed |
| LSP | None | `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim`, native `vim.lsp.enable()` |
| Completion | None | `blink.cmp` (pure-Lua, no build step) |
| Formatting | One ad-hoc `<leader>pf` → shell out to `prettier` | `conform.nvim`: per-filetype formatters, format-on-save, toggleable |
| Navigation | oil.nvim (floating, edit dirs as text) | swapped for `nvim-tree.lua` (always-visible sidebar); + `flash.nvim` wired up (it was installed but never configured), + Harpoon2, + session persistence |
| Diagnostics UI | None | `trouble.nvim` for a proper diagnostics/quickfix/TODO list |
| Multi-config switching | N/A | `bin/nvim-switch` script using Neovim's built-in `NVIM_APPNAME` |

## 2. Prerequisites

- **Neovim 0.11+** (this config uses the native `vim.lsp.config`/`vim.lsp.enable`
  API). Check with `nvim --version`. If you're behind, update Neovim first —
  everything here depends on it.
- **git** — your plugin manager shells out to it.
- **A C compiler** (`gcc`/`clang`/`cc`) on `PATH` — needed for Treesitter to
  build parsers.
- **A terminal with 16-color ANSI theming** (basically all of them: Alacritty,
  Kitty, WezTerm, iTerm2, Windows Terminal, GNOME Terminal, tmux...). This is
  what the colorscheme reads from.
- **Node.js** is recommended (Mason installs several LSP servers, like
  `ts_ls`, via npm under the hood).

## 3. Install

```bash
# Back up your current config first
mv ~/.config/nvim ~/.config/nvim.bak

# Unzip this config into place
unzip neovim-main.zip -d ~/.config/
mv ~/.config/neovim-main ~/.config/nvim

# Launch — first boot clones every plugin, so it'll pause for a bit
nvim
```

On first launch, `:PlugList` (see your original plugin manager) will show
everything that got cloned into `~/.local/share/nvim/plugins`. Language
servers themselves aren't installed yet — that happens next.

Open `:Mason` and install servers, or just start editing: with
`ensure_installed` set in `lua/plugins/lsp.lua`, `mason-lspconfig` installs
missing servers for you automatically on startup.

## 4. The terminal colorscheme (the part you specifically asked for)

`colors/terminal.lua` sets `termguicolors = false` and paints every
highlight group (editor UI, syntax, Treesitter, diagnostics, git signs,
which-key, blink.cmp's menu) using only the 16 standard ANSI color slots
(0–15), via `ctermfg`/`ctermbg` — never a fixed hex value.

Those 16 slots aren't defined by Neovim — they're defined by **your
terminal's color scheme/profile**. So:

- Change your terminal's theme (Alacritty `colors.toml`, Kitty `kitty.conf`,
  iTerm2 profile, Windows Terminal scheme, a tmux theme, `pywal`, etc.) and
  Neovim's colors update automatically — no `:colorscheme` command, no
  restart required for the terminal-level palette to apply on next redraw.
- If your terminal is configured to be transparent/blurred, Neovim is too
  — `Normal`'s background is intentionally left unset (`ctermbg = "NONE"`),
  so it just shows whatever's behind your terminal window.
- **No colorscheme plugin required.** All 10 previously-downloaded themes
  (gruvbox, dracula, nord, catppuccin, kanagawa, everforest, moonfly,
  github, rose-pine, e-ink) and `xiyaowong/transparent.nvim` were removed
  from `lua/plugin-list.lua`, along with the `:Gruvbox`/`:Nord`/etc.
  commands and the `.theme` file mechanism in the old `plugins/ui.lua`.

If text looks invisible in specific spots (comments, line numbers, etc.),
run `:TermColorTest` to see all 16 of your terminal's ANSI colors rendered
side by side — it'll immediately show you if two slots are too close
together. The scheme now also picks its "muted" color based on
`vim.o.background` (Neovim 0.10+ auto-detects light vs. dark by querying
the terminal) instead of always using slot 8, since bright-black often
renders as a pale, barely-visible grey on light backgrounds. If
auto-detection guesses wrong, override it with `:set background=light` (or
`dark`) and the scheme re-applies automatically.

`colors/terminal.lua` also explicitly styles every `render-markdown.nvim`
group, and does it with **no filled backgrounds at all** — headings,
inline code, and fenced code blocks are colored text only, no highlighted
box behind them. That's a deliberate minimal look, and it also sidesteps
an entire class of bug: a filled background needs a text color chosen to
contrast with it specifically, and that pairing is what kept breaking
across different terminal palettes (Gruvbox's muted grey sits closer to
its foreground than it looks in isolation, for instance). Foreground-only
color can't have that problem — it's the same approach `Comment`/`String`/
`Function` already use. `lua/plugins/editing.lua` also configures
`render-markdown.nvim` itself with `sign = false` and a narrower
`width = "block"` for fenced code, instead of full-width bars.

If you'd rather have the bolder, filled-background look
`render-markdown.nvim` uses by default, remove the `RenderMarkdownH*Bg`,
`RenderMarkdownCode`, and `RenderMarkdownCodeInline` overrides from
`colors/terminal.lua` — just be aware that then re-introduces the
contrast-pairing problem described above, since the "right" background
color is genuinely terminal-dependent.

(Visual-mode selection and the completion popup still use `reverse = true`
— that's the standard, expected look for a transient selection/menu, not
static document styling, so it was left alone.)

**One tradeoff to know about:** `nvim-colorizer.lua` (which highlights hex
codes like `#ff0000` with their real color) *requires* `termguicolors = true`
to run at all — it hard-errors without it, it doesn't degrade gracefully.
Since that directly conflicts with matching your terminal's palette, it was
left out of this config entirely rather than fought with. If you want it
back for a specific project, you can `:set termguicolors` in that session
before installing/enabling it — just know you'll lose terminal-matching
while it's on.

If you ever want a specific *fixed* look regardless of terminal (e.g. for a
screen recording), you can still `:colorscheme <anything>` after installing
a theme plugin manually — the terminal scheme is just the default, not a
restriction.

## 5. LSP, completion, and formatting

**LSP** (`lua/plugins/lsp.lua`): uses Neovim's native
`vim.lsp.config()` / `vim.lsp.enable()` (0.11+), with `nvim-lspconfig`
supplying the community server definitions and `mason.nvim` +
`mason-lspconfig.nvim` installing binaries and auto-enabling them.

Default servers installed: `lua_ls`, `pyright` (Python), `ts_ls`
(JS/TS), `html`, `cssls`, `jsonls`, `yamlls`, `bashls`, `marksman`
(Markdown).

**To add a language:** open `lua/plugins/lsp.lua`, find the
`ensure_installed` list, and add the server name (look it up at
[mason-lspconfig's server list](https://github.com/mason-org/mason-lspconfig.nvim#available-lsp-servers)),
e.g. `"gopls"` for Go or `"rust_analyzer"` for Rust. Restart Neovim; Mason
installs it and it auto-attaches.

**Completion** (`lua/plugins/completion.lua`): `blink.cmp`, configured with
`fuzzy.implementation = "lua"` — deliberately avoiding the optional Rust
matcher/prebuilt binary, so there's zero build step and it works with your
plain git-clone plugin manager out of the box.

**Formatting** (`lua/plugins/format.lua`): `conform.nvim`, per-filetype
formatters, runs on save automatically. Formatters (prettier, black,
stylua, shfmt, ...) must be installed on your system separately — conform
runs them, it doesn't install them. `:FormatToggle` turns off
format-on-save globally; `:FormatToggle!` toggles it just for the current
buffer.

## 6. Keymap reference (leader = space)

**LSP** (active once a server attaches to the buffer):
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references (via fzf-lua) |
| `K` | Hover docs |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code action |
| `<leader>lf` | Format buffer (works even without an attached LSP) |
| `<leader>ls` / `<leader>lw` | Document / workspace symbols |
| `<leader>ld` | Line diagnostics (float) |
| `[d` / `]d` | Prev / next diagnostic |

**Diagnostics list (Trouble):** `<leader>dd` workspace diagnostics,
`<leader>dw` buffer diagnostics, `<leader>dq` quickfix, `<leader>dt` TODOs.

**Navigation:**
| Key | Action |
|---|---|
| `<leader>e` | Toggle nvim-tree sidebar |
| `<leader>ff` / `<leader>fw` | Find files / live grep |
| `<leader>fb` / `<leader>fo` | Buffers / recent files |
| `<leader>fd` | Buffer diagnostics (fzf) |
| `<leader>fc` | Find files in your Neovim config |
| `s` / `S` | Flash jump / Flash Treesitter jump |
| `<leader>ha` | Harpoon: pin current file |
| `<leader>hh` | Harpoon: open quick menu |
| `<leader>1`–`<leader>4` | Harpoon: jump to pinned file 1–4 |
| `<leader>Ss` / `<leader>Sl` | Restore session (this dir) / restore last session |

**Git:** `<leader>gg` status, `<leader>gb` branches, `]h`/`[h` next/prev
hunk, `<leader>gp` preview hunk, `<leader>gs`/`<leader>gr` stage/reset hunk,
`<leader>gB` blame line.

Everything else (tabs, splits, buffers, markdown preview) is unchanged from
your original config — see `lua/core/keybinds.lua`.

## 7. Switching between multiple Neovim configs

This uses Neovim's built-in `NVIM_APPNAME` environment variable — no
plugin, fully supported by Neovim itself. Each profile name gets its own
isolated `~/.config/<name>`, `~/.local/share/<name>`,
`~/.local/state/<name>` — so plugins, Mason installs, and sessions from one
config never collide with another.

1. Keep this config at `~/.config/nvim` — that makes it the default
   (`nvim` with no env var uses it).
2. Any other config lives in a sibling folder with its own `init.lua`, e.g.:
   ```
   ~/.config/nvim-minimal/init.lua
   ~/.config/nvim-lazyvim/init.lua
   ```
3. Add an alias for the switcher script included at `bin/nvim-switch`:
   ```bash
   # ~/.bashrc or ~/.zshrc
   alias vims="~/.config/nvim/bin/nvim-switch"
   ```
4. Run `vims` any time — it fuzzy-lists every `~/.config/nvim*` folder that
   has an `init.lua` and launches the one you pick. Extra args pass through
   to nvim, e.g. `vims somefile.py`.

You can also just do it manually any time without the script:
`NVIM_APPNAME=nvim-minimal nvim`.

## 8. Useful commands

- `:PlugUpdate` / `:PlugList` / `:PlugClean` — your original plugin manager
  commands, unchanged.
- `:Mason` — browse/install/remove LSP servers, formatters, linters.
- `:checkhealth vim.lsp` — diagnose LSP issues.
- `:FormatToggle` / `:FormatToggle!` — disable format-on-save globally / for
  this buffer.
- `:Trouble diagnostics toggle` — same as `<leader>dd`.

## 9. Troubleshooting

- **A language server won't attach:** run `:checkhealth vim.lsp`, and make
  sure the file has a recognizable root marker (`.git`, `package.json`,
  `pyproject.toml`, etc. — see `:help lspconfig-all` for each server's
  markers).
- **Colors look wrong / too plain:** your terminal's ANSI palette might be
  the default 16-color VGA-ish set. Most terminals let you pick or import a
  nicer 16-color scheme (search "\<your terminal\> color scheme") — since
  Neovim just inherits it, upgrading your terminal's theme upgrades Neovim's
  too.
- **Treesitter parser fails to build:** you're missing a C compiler. Install
  `gcc`/`clang`/build-essential for your OS.
- **blink.cmp completion feels slightly slower than expected:** that's the
  pure-Lua fuzzy matcher (see §5) trading a little speed for zero build
  steps. If you're comfortable installing Rust, you can switch
  `fuzzy.implementation` to `"prefer_rust_with_warning"` in
  `lua/plugins/completion.lua` and add a `build` step for blink.cmp in
  `lua/plugin-list.lua` (the plugin manager already supports a `build`
  field — see the comment in `lua/plugin-manager.lua`).
