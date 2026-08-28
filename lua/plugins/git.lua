-- Git-related configuration
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
    on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function opts(desc)
            return { buffer = bufnr, silent = true, desc = desc }
        end

        vim.keymap.set("n", "]h", gs.next_hunk, opts("Next hunk"))
        vim.keymap.set("n", "[h", gs.prev_hunk, opts("Prev hunk"))
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts("Preview hunk"))
        vim.keymap.set("n", "<leader>gs", gs.stage_hunk, opts("Stage hunk"))
        vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts("Reset hunk"))
        vim.keymap.set("n", "<leader>gB", gs.blame_line, opts("Blame line"))
    end,
})
