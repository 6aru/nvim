return {
    -- Dependencies
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    -- Treesitter (pinned to the classic "master" branch: it's frozen/stable
    -- and keeps the simple configs.setup() API + auto_install, so parsers
    -- build themselves with no external tree-sitter CLI required)
    { "nvim-treesitter/nvim-treesitter", branch = "master" },

    -- LSP stack
    "neovim/nvim-lspconfig",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",

    -- Completion
    -- Pinned to the "v1" branch: blink.cmp's default branch moved to a V2
    -- release that hard-requires a separate "saghen/blink.lib" dependency.
    -- v1 stays self-contained (fits our fuzzy.implementation="lua" setup
    -- in lua/plugins/completion.lua with zero extra plugins needed).
    { "saghen/blink.cmp", branch = "v1" },
    "rafamadriz/friendly-snippets",

    -- Formatting & linting
    "stevearc/conform.nvim",
    "mfussenegger/nvim-lint",

    -- File navigation
    "nvim-tree/nvim-tree.lua",
    "ibhagwan/fzf-lua",
    "folke/flash.nvim",
    { "ThePrimeagen/harpoon", branch = "harpoon2" },
    "folke/persistence.nvim",

    -- UI
    "nvim-lualine/lualine.nvim",
    "akinsho/bufferline.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "goolord/alpha-nvim",
    "folke/which-key.nvim",
    "folke/trouble.nvim",
    "numToStr/Comment.nvim",
    "kylechui/nvim-surround",
    "folke/todo-comments.nvim",

    -- Editing
    "windwp/nvim-autopairs",
    "gaoDean/autolist.nvim",

    -- Git
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- Markdown
    { "iamcco/markdown-preview.nvim", branch = "master" },
    "MeanderingProgrammer/render-markdown.nvim",
}
