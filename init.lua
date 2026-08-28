require("core.options")
require("core.keybinds")
require("core.autocmds")
require("core.commands")

require("plugin-manager").setup()

require("plugins.completion") -- blink.cmp, loaded first so lsp.lua can read its capabilities
require("plugins.lsp")
require("plugins.format")
require("plugins.ui")
require("plugins.navigation")
require("plugins.editing")
require("plugins.treesitter")
require("plugins.git")
require("plugins.lint")
require("plugins.todo")
