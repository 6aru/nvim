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
    eink = "e-ink",
  }

  local ok = pcall(
  vim.cmd.colorscheme,
  map[theme] or "gruvbox"
)

if not ok then
  vim.cmd.colorscheme("gruvbox")
end

end
  
return M
