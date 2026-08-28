-- Autopairs
local ok, autopairs = pcall(require, "nvim-autopairs")
if ok then
    autopairs.setup({})
end

-- Autolist (markdown lists)
local ok2, autolist = pcall(require, "autolist")
if ok2 then
    autolist.setup({})
    vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
end

-- Render-markdown
-- Deliberately minimal: no filled block/inline backgrounds (those depend on
-- getting a highlight-vs-text contrast pair exactly right for whatever
-- terminal theme is active -- easy to get wrong, and looks like a
-- highlighter marker even when it is right). Colors alone (see
-- colors/terminal.lua) carry the "this is code" signal instead.
local ok3, render_md = pcall(require, "render-markdown")
if ok3 then
    render_md.setup({
        code = {
            sign = false,
            width = "block",
            left_pad = 1,
            right_pad = 1,
            border = "thin",
        },
        heading = {
            sign = false,
        },
    })
end

-- Comment.nvim
local ok, comment = pcall(require, "Comment")

if ok then
    comment.setup()
end

-- nvim-surround
local ok2, surround = pcall(require, "nvim-surround")

if ok2 then
    surround.setup({})
end

-- Markdown-preview
vim.g.mkdp_filetypes = { "markdown" }
vim.defer_fn(function()
    pcall(vim.cmd, "call mkdp#util#install()")
end, 100)
