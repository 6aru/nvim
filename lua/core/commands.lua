-- :TermColorTest -- opens a scratch buffer showing all 16 ANSI colors with
-- labels, so you can see exactly what your terminal is handing Neovim.
-- Useful for spotting a palette where two slots are too close together
-- (e.g. "bright black" nearly matching your background).
vim.api.nvim_create_user_command("TermColorTest", function()
    local buf = vim.api.nvim_create_buf(false, true)
    local names = {
        "0 black", "1 red", "2 green", "3 yellow",
        "4 blue", "5 magenta", "6 cyan", "7 white",
        "8 bright black", "9 bright red", "10 bright green", "11 bright yellow",
        "12 bright blue", "13 bright magenta", "14 bright cyan", "15 bright white",
    }
    local lines = { "Background detected as: " .. vim.o.background, "" }
    for i = 0, 15 do
        table.insert(lines, string.format("  %-20s  ####  sample text  ####", names[i + 1]))
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = 50,
        height = #lines + 1,
        row = 2,
        col = 5,
        border = "rounded",
        title = " Terminal ANSI colors ",
    })
    for i = 0, 15 do
        local group = "TermColorTest" .. i
        vim.api.nvim_set_hl(0, group, { ctermfg = i })
        vim.api.nvim_buf_add_highlight(buf, -1, group, i + 2, 0, -1)
    end
end, { desc = "Preview all 16 ANSI terminal colors" })
