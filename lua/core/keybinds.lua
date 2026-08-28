-- map leader
vim.g.mapleader = " "
local keymap = vim.keymap

local function opts(desc)
    return { silent = true, noremap = true, desc = desc }
end

-- General
keymap.set("n", "<leader>a", "gg<S-v>G", opts("Select all"))
keymap.set("v", "<", "<gv", opts("Indent left"))
keymap.set("v", ">", ">gv", opts("Indent right"))

-- Window
keymap.set("n", "<leader>m", ":Alpha<cr>", opts("Menu"))

-- Tab bindings
keymap.set("n", "<leader>t", ":tabnew<cr>", opts("New tab"))
keymap.set("n", "<leader>x", ":tabclose<cr>", opts("Close tab"))
keymap.set("n", "<leader>j", ":tabnext<cr>", opts("Next tab"))
keymap.set("n", "<leader>k", ":tabprevious<cr>", opts("Previous tab"))

-- Buffer navigation
keymap.set("n", "<Tab>", ":bnext<cr>", opts("Next buffer"))
keymap.set("n", "<S-Tab>", ":bprevious<cr>", opts("Previous buffer"))
keymap.set("n", "<leader>q", ":bd<cr>", opts("Close buffer"))

-- Split generation
keymap.set("n", "<leader>v", ":vsplit", opts("Vertical split"))
keymap.set("n", "<leader>s", ":split", opts("Horizontal split"))

-- Resize splits
keymap.set("n", "<C-Left>", ":vertical resize +3<cr>", opts("Resize left"))
keymap.set("n", "<C-Right>", ":vertical resize -3<cr>", opts("Resize right"))

-- File explorer keymap lives in lua/plugins/navigation.lua, next to
-- nvim-tree's own setup.

-- fzf-lua: file/text finding
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", opts("Find files"))
keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", opts("Find word"))
keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", opts("Find help"))
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", opts("Find buffer"))
keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", opts("Recent files"))
keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", opts("Buffer diagnostics"))
keymap.set("n", "<leader>fc", function()
    require("fzf-lua").files({
        cwd = vim.fn.stdpath("config"),
    })
end, opts("Find config"))

-- Git
keymap.set("n", "<leader>gg", ":vertical Git<cr>", opts("Git status"))
keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", opts("Git branches"))

-- Diagnostics list (Trouble)
keymap.set("n", "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>", opts("Diagnostics (workspace)"))
keymap.set("n", "<leader>dw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts("Diagnostics (buffer)"))
keymap.set("n", "<leader>dq", "<cmd>Trouble qflist toggle<cr>", opts("Quickfix list"))
keymap.set("n", "<leader>dt", "<cmd>Trouble todo toggle<cr>", opts("TODO list"))

-- Preview
keymap.set("n", "<leader>pp", ":MarkdownPreviewToggle<cr>", opts("Preview markdown"))

-- NOTE: LSP keymaps (gd, gr, K, <leader>lr, <leader>la, <leader>lf, ...) live
-- in lua/plugins/lsp.lua and lua/plugins/format.lua, close to the plugins
-- that back them. Harpoon/persistence keymaps live in lua/plugins/navigation.lua.
