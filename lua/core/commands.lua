vim.api.nvim_create_user_command("ThemeReload", function()
    require("themes.theme-loader").load()
end, {})
