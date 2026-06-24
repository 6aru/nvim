local M = {}

M.themes = {
    "gruvbox",
    "nord",
    "catppuccin-frappe",
    "kanagawa-wave",
    "rose-pine-moon",
    "everforest",
    "dracula",
    "moonfly",
    "github_dark_default",
}

function M.pick()
    require("fzf-lua").fzf_exec(M.themes, {
        prompt = "Colorscheme > ",
        actions = {
            ["default"] = function(selected)
                vim.cmd.colorscheme(selected[1])
            end,
        },
        preview = function(item)
            vim.schedule(function()
                pcall(vim.cmd.colorscheme, item[1])
            end)
            return ""
        end,
    })
end

return M
