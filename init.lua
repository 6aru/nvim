require("core.options")
require("core.keybinds")
require("core.autocmds")
require("core.commands")

require("plugin-manager").setup()

require("themes.theme-loader").load()

require("plugins.ui")
require("plugins.navigation")
require("plugins.editing")
require("plugins.treesitter")
require("plugins.git")
require("plugins.lint")
require("plugins.todo")
require("plugins.theme-picker")
