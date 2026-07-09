-- Colorscheme
require("themes.theme-loader").load()

-- Lualine
local ok, lualine = pcall(require, "lualine")
if ok then
    lualine.setup({
        options = {
            theme = "auto",
            component_separators = "",
            section_separators = "",
        },
    })
end

-- Bufferline
local ok2, bufferline = pcall(require, "bufferline")
if ok2 then
    bufferline.setup({})
end

-- Alpha (dashboard)
local ok3, alpha = pcall(require, "alpha")
if ok3 then
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
    "",
    "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
    "████╗  ██║██║   ██║██║████╗ ████║",
    "██╔██╗ ██║██║   ██║██║██╔████╔██║",
    "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "",
    "      Pure • Fast • Minimal",
    "",
    }
    dashboard.section.buttons.val = {
        dashboard.button("f", "󰈞  Find File",      ":FzfLua files<CR>"),
        dashboard.button("r", "󰋚  Recent Files",   ":FzfLua oldfiles<CR>"),
        dashboard.button("g", "󰊢  Live Grep",      ":FzfLua live_grep<CR>"),
        dashboard.button("n", "󰝒  New File",       ":ene <BAR> startinsert<CR>"),
        dashboard.button("q", "󰗼  Quit",           ":qa<CR>"),
    }
    alpha.setup(dashboard.config)
end

-- Indent blankline
local ok4, ibl = pcall(require, "ibl")
if ok4 then
    ibl.setup({
        indent = { char = "│" },
        scope = { enabled = false },
    })
end

-- Colorizer
local ok5, colorizer = pcall(require, "colorizer")
if ok5 then
    colorizer.setup({
        filetypes = { "*" },
        buftypes = {},
        user_commands = true,
        options = {
            parsers = {
                css = true,
                css_fn = true,
                hex = { default = true },
                names = { enable = false },
            },
            display = {
                mode = { "background", "virtualtext" },
                virtualtext = { char = "■" },
            },
        },
    })
end

-- Transparent
local ok6, transparent = pcall(require, "transparent")
if ok6 then
    transparent.setup({})
end

-- Which-key
local ok7, wk = pcall(require, "which-key")
if ok7 then
    wk.setup({
        icons = {
            breadcrumb = "»",
            separator = "→",
            group = "+",
        },
        win = {
            border = "rounded",
        },
    })
    wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>p", group = "Preview" },
        { "<leader>ct", desc = "Change Theme" },
    })
end
