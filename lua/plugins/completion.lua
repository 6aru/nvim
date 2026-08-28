-- blink.cmp: completion + snippets + signature help.
-- fuzzy.implementation = "lua" deliberately skips the optional Rust
-- matcher, so there's no cargo/prebuilt-binary step -- it just works with
-- our plain git-clone plugin manager, on any machine.
local ok, blink = pcall(require, "blink.cmp")
if not ok then return end

blink.setup({
    fuzzy = { implementation = "lua" },
    keymap = { preset = "default" }, -- <C-y> accept, <C-space> open/docs, <C-n>/<C-p> select
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = { border = "rounded" },
        list = { selection = { preselect = false, auto_insert = false } },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
})
