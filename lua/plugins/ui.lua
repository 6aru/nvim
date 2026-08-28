-----------------------------------
-- Colorscheme: always the terminal's own colors
-----------------------------------
-- Fix IblScope for filetypes/edge cases where it isn't defined yet
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        local hl = vim.api.nvim_get_hl(0, { name = "IblScope", link = false })
        if vim.tbl_isempty(hl) then
            vim.api.nvim_set_hl(0, "IblScope", { ctermfg = 7, nocombine = true })
        end
    end,
})

vim.cmd.colorscheme("terminal")

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
        dashboard.button("s", "  Restore Session", ":lua require('persistence').load()<CR>"),
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
        { "<leader>l", group = "LSP" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>d", group = "Diagnostics (Trouble)" },
        { "<leader>S", group = "Session" },
    })
end

-- Trouble (pretty diagnostics/quickfix/todo list)
local ok8, trouble = pcall(require, "trouble")
if ok8 then
    trouble.setup({})
end
