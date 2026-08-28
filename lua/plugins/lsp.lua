-- LSP stack: mason (installer) + mason-lspconfig (bridge) + nvim-lspconfig
-- (server config data only) + Neovim's native vim.lsp.config/vim.lsp.enable.
--
-- To add a language: find its server name at
-- https://github.com/mason-org/mason-lspconfig.nvim#available-lsp-servers
-- and add it to `ensure_installed` below. Mason will install the binary
-- and mason-lspconfig will auto vim.lsp.enable() it -- nothing else to do.

local ok_mason, mason = pcall(require, "mason")
if ok_mason then
    mason.setup()
end

-- Merge blink.cmp's richer completion capabilities into every LSP client
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end
vim.lsp.config("*", { capabilities = capabilities })

-- Per-server tweaks (extends, doesn't replace, nvim-lspconfig's defaults)
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

-- A broad, generalist starter set. Trim or extend to taste.
local ok_masonlsp, masonlsp = pcall(require, "mason-lspconfig")
if ok_masonlsp then
    masonlsp.setup({
        ensure_installed = {
            "lua_ls",       -- Lua (editing this config)
            "pyright",      -- Python
            "ts_ls",        -- JavaScript/TypeScript
            "html",
            "cssls",
            "jsonls",
            "yamlls",
            "bashls",
            "marksman",     -- Markdown
        },
    })
end

-- Diagnostics UI
vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 2 },
    severity_sort = true,
    float = { border = "rounded", source = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})

-- Buffer-local keymaps, only set once a language server actually attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local function opts(desc)
            return { buffer = bufnr, silent = true, noremap = true, desc = desc }
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
        vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", opts("Find references"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover docs"))
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename symbol"))
        vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", opts("Document symbols"))
        vim.keymap.set("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", opts("Workspace symbols"))
    end,
})

-- Diagnostic navigation/inspection works even without LSP (nvim-lint also
-- feeds vim.diagnostic), so these stay global rather than LspAttach-only.
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { silent = true, desc = "Line diagnostics" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { silent = true, desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { silent = true, desc = "Next diagnostic" })
