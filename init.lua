require("core.options")
require("core.keybinds")
require("core.autocmds")

require("themes.theme-loader").load()

require("plugin-manager").setup()

require("plugins.ui")
require("plugins.navigation")
require("plugins.editing")
require("plugins.treesitter")
require("plugins.git")
require("plugins.lint")
require("plugins.todo")
