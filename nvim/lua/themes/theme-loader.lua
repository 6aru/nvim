local M = {}

function M.load()
  local home = os.getenv("HOME")

  local file = io.open(
    home .. "/.config/i3/.current_theme",
    "r"
  )

  if not file then
    vim.cmd.colorscheme("gruvbox")
    return
  end

  local theme = file:read("*l")

  file:close()

  local map = {
    gruvbox = "gruvbox",
    nord = "nord",
    dracula = "dracula",
    rose_pine = "rose-pine-moon",
    catppuccin = "catppuccin-frappe",
    kanagawa = "kanagawa-wave",
    everforest = "everforest",
    github_dark = "github_dark_default",
    moonfly = "moonfly",
  }

  vim.cmd.colorscheme(
    map[theme] or "gruvbox"
  )
end

return M
