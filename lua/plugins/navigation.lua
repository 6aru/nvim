-- nvim-tree (sidebar file explorer)
-- Netrw (Neovim's built-in explorer) must be disabled before nvim-tree
-- loads, or the two can conflict over which one handles directory buffers.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ok, nvimtree = pcall(require, "nvim-tree")
if ok then
    nvimtree.setup({
        view = {
            width = 32,
            side = "left",
        },
        renderer = {
            group_empty = true,
            indent_markers = { enable = true },
        },
        filters = {
            dotfiles = false, -- show hidden files
        },
        git = {
            enable = true,
        },
        actions = {
            open_file = {
                quit_on_open = false,
            },
        },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Explorer" })
end

-- FZF-Lua (fuzzy finder for files/text/pickers)
local ok2, fzf = pcall(require, "fzf-lua")
if ok2 then
    fzf.setup({
        winopts = {
            height = 0.85,
            width = 0.80,
            preview = {
                layout = "vertical",
            },
        },
    })
end

-- Flash.nvim (jump anywhere on screen in a couple of keystrokes)
local ok3, flash = pcall(require, "flash")
if ok3 then
    flash.setup({})
    vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash jump" })
    vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
    vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
    vim.keymap.set({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
    vim.keymap.set("c", "<C-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
end

-- Harpoon2 (pin your working set of files, jump instantly)
local ok4, harpoon = pcall(require, "harpoon")
if ok4 then
    harpoon:setup()
    local keymap = vim.keymap
    keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: add file" })
    keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })
    for i = 1, 4 do
        keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon: file " .. i })
    end
end

-- Persistence.nvim (per-project session save/restore)
local ok5, persistence = pcall(require, "persistence")
if ok5 then
    persistence.setup({})
    vim.keymap.set("n", "<leader>Ss", function() require("persistence").load() end, { desc = "Restore session (this dir)" })
    vim.keymap.set("n", "<leader>Sl", function() require("persistence").load({ last = true }) end, { desc = "Restore last session" })
    vim.keymap.set("n", "<leader>Sd", function() require("persistence").stop() end, { desc = "Stop saving session" })
end
