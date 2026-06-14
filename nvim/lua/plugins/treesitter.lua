local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then return end

configs.setup({
    ensure_installed = {
        "lua", "bash", "json", "yaml", "markdown", "markdown_inline",
        "html", "css", "xml", "vim", "vimdoc", "toml", "int",
    },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
