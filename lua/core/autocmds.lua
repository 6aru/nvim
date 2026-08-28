local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",
})
