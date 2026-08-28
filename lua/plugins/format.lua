-- conform.nvim: async formatting on save, with a manual toggle + keymap.
-- Formatters must be installed on your system (e.g. `npm i -g prettier`,
-- `pip install black`, `cargo install stylua`, etc.) -- conform runs them,
-- it doesn't install them. Mason can install several of these too via
-- :Mason if you'd rather manage them from inside Neovim.
local ok, conform = pcall(require, "conform")
if not ok then return end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
})

vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print("Autoformat on save (this buffer): " .. tostring(not vim.b.disable_autoformat))
    else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Autoformat on save (global): " .. tostring(not vim.g.disable_autoformat))
    end
end, { bang = true, desc = "Toggle format-on-save (! for buffer-local)" })

vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { silent = true, desc = "Format buffer" })
