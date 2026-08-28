local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then return end

configs.setup({
    ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "bash", "python", "javascript", "typescript", "tsx",
        "html", "css", "json", "jsonc", "yaml", "toml", "xml",
        "markdown", "markdown_inline",
        "c", "go", "rust",
        "git_config", "gitcommit", "gitignore", "diff",
        "regex",
    },
    -- Auto-installs the parser for any new filetype you open, so you rarely
    -- need to touch ensure_installed by hand. Requires a C compiler on PATH
    -- (gcc/clang/cc) -- most systems already have one.
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})
