local opt = vim.opt

-- global statusline
opt.laststatus = 3

-- fat cursor
opt.guicursor = ""

-- disable cmd messages
opt.showmode = false

-- enable system clipboard
opt.clipboard = "unnamedplus"

-- (optional) cursorline is drawn without a background fill by colors/terminal.lua
opt.cursorline = true

-- scrolloff for cursor
opt.scrolloff = 8

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- statusline characters
opt.fillchars = { eob = " " }

-- enhance searching
opt.ignorecase = true
opt.smartcase = true

-- disable mouse
opt.mouse = ""

-- numberline
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- disable highlight search
opt.hlsearch = false

-- no wrap
opt.wrap = false


-- enable signcolumn
opt.signcolumn = "yes"

-- default split from bottom-right
opt.splitbelow = true
opt.splitright = true

-- NOTE: termguicolors is intentionally NOT set here. colors/terminal.lua
-- sets it to false itself, so Neovim renders using your terminal's own
-- 16-color ANSI palette instead of fixed hex values from a theme plugin.

-- file recovery
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250