-- "terminal" colorscheme
--
-- Instead of shipping a fixed palette, this scheme turns termguicolors OFF
-- and paints every highlight group using ONLY the 16 standard ANSI color
-- slots (0-15). Neovim then never decides what "red" or "blue" actually
-- looks like -- your terminal emulator does, because ANSI colors 0-15 are
-- whatever RGB values your terminal's profile/theme assigns them.
--
-- Practical effect: change your terminal's theme (Alacritty/Kitty/WezTerm
-- config, iTerm profile, Windows Terminal scheme, tmux theme, etc.) and
-- Neovim's colors follow automatically -- no :colorscheme switch needed.
--
-- Bonus: because we never set an explicit background color, Normal (and
-- every UI surface below) falls through to the terminal's own background,
-- which is also what gives you "free" transparency if your terminal is
-- configured to be transparent/blurred.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = false
vim.g.colors_name = "terminal"

-- Standard ANSI slots for reference (0-7 normal, 8-15 bright):
--   0 black  1 red     2 green  3 yellow
--   4 blue   5 magenta 6 cyan   7 white
--   8 grey   9 bred   10 bgreen 11 byellow
--  12 bblue 13 bmagenta 14 bcyan 15 bwhite
--
-- "bright black" (8) is meant to read as a muted grey against DARK
-- backgrounds. Against LIGHT backgrounds it's frequently rendered as a
-- pale, near-white grey, which makes anything using it (comments, line
-- numbers, etc.) nearly invisible. Neovim 0.10+ auto-detects light vs.
-- dark by querying the terminal (falls back to "dark" if the terminal
-- doesn't answer -- you can override with :set background=light).
-- We pick the muted color based on that instead of hardcoding slot 8.
local function muted()
  return vim.o.background == "light" and 0 or 8
end

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function apply()
  local m = muted()

  -- ============ Core editor surfaces ============
  hi("Normal", { ctermfg = "NONE", ctermbg = "NONE" })
  hi("NormalNC", { ctermfg = "NONE", ctermbg = "NONE" })
  hi("NormalFloat", { ctermfg = "NONE", ctermbg = "NONE" })
  hi("FloatBorder", { ctermfg = m, ctermbg = "NONE" })
  hi("FloatTitle", { ctermfg = 4, ctermbg = "NONE", bold = true })
  hi("SignColumn", { ctermbg = "NONE" })
  hi("FoldColumn", { ctermbg = "NONE", ctermfg = m })
  hi("EndOfBuffer", { ctermfg = m })
  hi("NonText", { ctermfg = m })
  hi("Whitespace", { ctermfg = m })
  hi("Conceal", { ctermfg = m })
  hi("LineNr", { ctermfg = m, ctermbg = "NONE" })
  hi("CursorLineNr", { ctermfg = 3, ctermbg = "NONE", bold = true })
  hi("CursorLine", { ctermbg = "NONE", underline = false })
  hi("CursorColumn", { ctermbg = "NONE" })
  hi("ColorColumn", { reverse = true })
  hi("Cursor", { ctermfg = 0, ctermbg = 7 })
  hi("Visual", { reverse = true })
  hi("VisualNOS", { reverse = true })
  hi("Search", { ctermfg = 0, ctermbg = 3 })
  hi("IncSearch", { ctermfg = 0, ctermbg = 1 })
  hi("CurSearch", { ctermfg = 0, ctermbg = 1 })
  hi("MatchParen", { ctermfg = 3, bold = true, underline = true })
  hi("Directory", { ctermfg = 4, bold = true })
  hi("Title", { ctermfg = 4, bold = true })
  hi("ErrorMsg", { ctermfg = 1, bold = true })
  hi("WarningMsg", { ctermfg = 3 })
  hi("MoreMsg", { ctermfg = 2 })
  hi("Question", { ctermfg = 2 })
  hi("ModeMsg", { ctermfg = "NONE" })
  hi("WinSeparator", { ctermfg = m, ctermbg = "NONE" })
  hi("VertSplit", { ctermfg = m, ctermbg = "NONE" })
  hi("StatusLine", { ctermfg = "NONE", ctermbg = "NONE", bold = true })
  hi("StatusLineNC", { ctermfg = m, ctermbg = "NONE" })
  hi("TabLine", { ctermfg = m, ctermbg = "NONE" })
  hi("TabLineFill", { ctermbg = "NONE" })
  hi("TabLineSel", { ctermfg = 0, ctermbg = 4, bold = true })
  hi("Pmenu", { reverse = true })
  hi("PmenuSel", { ctermfg = 0, ctermbg = 4, bold = true })
  hi("PmenuSbar", { ctermbg = m })
  hi("PmenuThumb", { ctermbg = 7 })
  hi("WildMenu", { ctermfg = 0, ctermbg = 4 })
  hi("SpecialKey", { ctermfg = m })

  -- ============ Syntax ============
  hi("Comment", { ctermfg = m, italic = true })
  hi("Constant", { ctermfg = 5 })
  hi("String", { ctermfg = 2 })
  hi("Character", { ctermfg = 2 })
  hi("Number", { ctermfg = 5 })
  hi("Boolean", { ctermfg = 5 })
  hi("Float", { ctermfg = 5 })
  hi("Identifier", { ctermfg = 6 })
  hi("Function", { ctermfg = 4, bold = true })
  hi("Statement", { ctermfg = 1 })
  hi("Conditional", { ctermfg = 1 })
  hi("Repeat", { ctermfg = 1 })
  hi("Label", { ctermfg = 1 })
  hi("Operator", { ctermfg = "NONE" })
  hi("Keyword", { ctermfg = 1 })
  hi("Exception", { ctermfg = 1 })
  hi("PreProc", { ctermfg = 3 })
  hi("Include", { ctermfg = 3 })
  hi("Define", { ctermfg = 3 })
  hi("Macro", { ctermfg = 3 })
  hi("Type", { ctermfg = 3 })
  hi("StorageClass", { ctermfg = 3 })
  hi("Structure", { ctermfg = 3 })
  hi("Typedef", { ctermfg = 3 })
  hi("Special", { ctermfg = 6 })
  hi("SpecialChar", { ctermfg = 6 })
  hi("Tag", { ctermfg = 6 })
  hi("Delimiter", { ctermfg = "NONE" })
  hi("Underlined", { underline = true, ctermfg = 4 })
  hi("Ignore", { ctermfg = m })
  hi("Todo", { ctermfg = 0, ctermbg = 3, bold = true })
  hi("Error", { ctermfg = 15, ctermbg = 1 })

  -- ============ Treesitter (link onto the groups above) ============
  local ts_links = {
    ["@variable"] = "Identifier",
    ["@variable.builtin"] = "Special",
    ["@variable.parameter"] = "Identifier",
    ["@property"] = "Identifier",
    ["@field"] = "Identifier",
    ["@constant"] = "Constant",
    ["@constant.builtin"] = "Special",
    ["@string"] = "String",
    ["@string.escape"] = "SpecialChar",
    ["@number"] = "Number",
    ["@boolean"] = "Boolean",
    ["@function"] = "Function",
    ["@function.builtin"] = "Function",
    ["@function.call"] = "Function",
    ["@method"] = "Function",
    ["@method.call"] = "Function",
    ["@constructor"] = "Special",
    ["@keyword"] = "Keyword",
    ["@keyword.function"] = "Keyword",
    ["@keyword.return"] = "Keyword",
    ["@keyword.operator"] = "Keyword",
    ["@conditional"] = "Conditional",
    ["@repeat"] = "Repeat",
    ["@type"] = "Type",
    ["@type.builtin"] = "Type",
    ["@attribute"] = "PreProc",
    ["@namespace"] = "Type",
    ["@punctuation.delimiter"] = "Delimiter",
    ["@punctuation.bracket"] = "Delimiter",
    ["@punctuation.special"] = "Special",
    ["@comment"] = "Comment",
    ["@tag"] = "Tag",
    ["@tag.attribute"] = "Identifier",
    ["@tag.delimiter"] = "Delimiter",
    ["@markup.heading"] = "Title",
    ["@markup.link"] = "Underlined",
    ["@markup.raw"] = "String",
  }
  for group, link in pairs(ts_links) do
    vim.api.nvim_set_hl(0, group, { link = link })
  end

  -- ============ Diagnostics ============
  hi("DiagnosticError", { ctermfg = 1 })
  hi("DiagnosticWarn", { ctermfg = 3 })
  hi("DiagnosticInfo", { ctermfg = 4 })
  hi("DiagnosticHint", { ctermfg = 6 })
  hi("DiagnosticOk", { ctermfg = 2 })
  hi("DiagnosticUnderlineError", { undercurl = true, ctermfg = 1 })
  hi("DiagnosticUnderlineWarn", { undercurl = true, ctermfg = 3 })
  hi("DiagnosticUnderlineInfo", { undercurl = true, ctermfg = 4 })
  hi("DiagnosticUnderlineHint", { undercurl = true, ctermfg = 6 })
  hi("DiagnosticVirtualTextError", { ctermfg = 1 })
  hi("DiagnosticVirtualTextWarn", { ctermfg = 3 })
  hi("DiagnosticVirtualTextInfo", { ctermfg = 4 })
  hi("DiagnosticVirtualTextHint", { ctermfg = 6 })
  hi("LspReferenceText", { ctermbg = m })
  hi("LspReferenceRead", { ctermbg = m })
  hi("LspReferenceWrite", { ctermbg = m, underline = true })
  hi("LspInlayHint", { ctermfg = m, italic = true })

  -- ============ Git / gitsigns / diff ============
  hi("DiffAdd", { ctermfg = 2, ctermbg = "NONE" })
  hi("DiffChange", { ctermfg = 3, ctermbg = "NONE" })
  hi("DiffDelete", { ctermfg = 1, ctermbg = "NONE" })
  hi("DiffText", { ctermfg = 4, ctermbg = "NONE" })
  hi("GitSignsAdd", { ctermfg = 2 })
  hi("GitSignsChange", { ctermfg = 3 })
  hi("GitSignsDelete", { ctermfg = 1 })

  -- ============ Plugin UI glue ============
  hi("WhichKey", { ctermfg = 1 })
  hi("WhichKeyGroup", { ctermfg = 4 })
  hi("WhichKeyDesc", { ctermfg = "NONE" })
  hi("WhichKeySeparator", { ctermfg = m })
  hi("WhichKeyBorder", { ctermfg = m })
  hi("TodoFgTODO", { ctermfg = 0, ctermbg = 4, bold = true })
  hi("TodoFgFIX", { ctermfg = 0, ctermbg = 1, bold = true })
  hi("TodoFgNOTE", { ctermfg = 0, ctermbg = 6, bold = true })
  hi("TodoFgWARN", { ctermfg = 0, ctermbg = 3, bold = true })
  hi("BlinkCmpMenu", { reverse = true })
  hi("BlinkCmpMenuBorder", { ctermfg = m })
  hi("BlinkCmpMenuSelection", { ctermfg = 0, ctermbg = 4, bold = true })
  hi("BlinkCmpDoc", { reverse = true })
  hi("BlinkCmpDocBorder", { ctermfg = m })
  hi("IblIndent", { ctermfg = m })
  hi("IblScope", { ctermfg = "NONE" })

  -- ============ render-markdown.nvim ============
  -- Deliberately minimal: no filled backgrounds anywhere. A filled
  -- background always needs a text color chosen specifically to sit on
  -- top of it, and that pairing is exactly what kept breaking across
  -- different terminal palettes. Foreground-only color can't have that
  -- problem -- it's the same technique Comment/String/Function already
  -- use, just applied to markdown. Since colors/terminal.lua runs before
  -- render-markdown.setup() (see lua/plugins/editing.lua), these values
  -- win over the plugin's own defaults.
  hi("RenderMarkdownH1", { ctermfg = 1, bold = true })
  hi("RenderMarkdownH2", { ctermfg = 3, bold = true })
  hi("RenderMarkdownH3", { ctermfg = 2, bold = true })
  hi("RenderMarkdownH4", { ctermfg = 6, bold = true })
  hi("RenderMarkdownH5", { ctermfg = 4, bold = true })
  hi("RenderMarkdownH6", { ctermfg = 5, bold = true })
  hi("RenderMarkdownH1Bg", { ctermfg = 1, ctermbg = "NONE", bold = true })
  hi("RenderMarkdownH2Bg", { ctermfg = 3, ctermbg = "NONE", bold = true })
  hi("RenderMarkdownH3Bg", { ctermfg = 2, ctermbg = "NONE", bold = true })
  hi("RenderMarkdownH4Bg", { ctermfg = 6, ctermbg = "NONE", bold = true })
  hi("RenderMarkdownH5Bg", { ctermfg = 4, ctermbg = "NONE", bold = true })
  hi("RenderMarkdownH6Bg", { ctermfg = 5, ctermbg = "NONE", bold = true })
  hi("RenderMarkdownCode", { ctermfg = "NONE", ctermbg = "NONE" })
  hi("RenderMarkdownCodeInline", { ctermfg = 3, ctermbg = "NONE" })
  hi("RenderMarkdownCodeInfo", { ctermfg = m, ctermbg = "NONE" })
  hi("RenderMarkdownCodeBorder", { ctermfg = m, ctermbg = "NONE" })
  hi("RenderMarkdownCodeFallback", { ctermfg = m, ctermbg = "NONE" })
  hi("RenderMarkdownBullet", { ctermfg = 3 })
  hi("RenderMarkdownIndent", { ctermfg = m })
  hi("RenderMarkdownQuote", { ctermfg = 2, italic = true })
  hi("RenderMarkdownDash", { ctermfg = m })
  hi("RenderMarkdownLink", { ctermfg = 4, underline = true })
  hi("RenderMarkdownWikiLink", { ctermfg = 4, underline = true })
  hi("RenderMarkdownTableHead", { ctermfg = 4, bold = true })
  hi("RenderMarkdownTableRow", { ctermfg = "NONE" })
  hi("RenderMarkdownTableFill", { ctermfg = m })
  hi("RenderMarkdownSuccess", { ctermfg = 2 })
  hi("RenderMarkdownInfo", { ctermfg = 4 })
  hi("RenderMarkdownHint", { ctermfg = 6 })
  hi("RenderMarkdownWarn", { ctermfg = 3 })
  hi("RenderMarkdownError", { ctermfg = 1 })
  hi("RenderMarkdownMath", { ctermfg = 5 })
  hi("RenderMarkdownUnchecked", { ctermfg = m })
  hi("RenderMarkdownChecked", { ctermfg = 2 })
  hi("RenderMarkdownTodo", { ctermfg = 3, bold = true })

  -- ============ nvim-tree ============
  hi("NvimTreeNormal", { ctermfg = "NONE", ctermbg = "NONE" })
  hi("NvimTreeNormalNC", { ctermfg = "NONE", ctermbg = "NONE" })
  hi("NvimTreeEndOfBuffer", { ctermfg = m })
  hi("NvimTreeWinSeparator", { ctermfg = m, ctermbg = "NONE" })
  hi("NvimTreeRootFolder", { ctermfg = 4, bold = true })
  hi("NvimTreeFolderName", { ctermfg = 4, bold = true })
  hi("NvimTreeOpenedFolderName", { ctermfg = 4, bold = true })
  hi("NvimTreeEmptyFolderName", { ctermfg = m })
  hi("NvimTreeFolderIcon", { ctermfg = 4 })
  hi("NvimTreeIndentMarker", { ctermfg = m })
  hi("NvimTreeSymlink", { ctermfg = 6, underline = true })
  hi("NvimTreeSpecialFile", { ctermfg = 3, underline = true })
  hi("NvimTreeImageFile", { ctermfg = 5 })
  hi("NvimTreeExecFile", { ctermfg = 2, bold = true })
  hi("NvimTreeGitDirty", { ctermfg = 3 })
  hi("NvimTreeGitStaged", { ctermfg = 2 })
  hi("NvimTreeGitNew", { ctermfg = 2 })
  hi("NvimTreeGitRenamed", { ctermfg = 3 })
  hi("NvimTreeGitDeleted", { ctermfg = 1 })
  hi("NvimTreeGitMerge", { ctermfg = 5 })
  hi("NvimTreeGitIgnored", { ctermfg = m })
end

apply()

-- Re-apply if you (or Neovim's own OSC11 terminal query) change light/dark,
-- so the muted color stays correct instead of going invisible.
vim.api.nvim_create_augroup("TerminalColorscheme", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
  group = "TerminalColorscheme",
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "terminal" then
      apply()
    end
  end,
})

-- Some plugins' own plugin/*.lua files (auto-sourced by Neovim *after*
-- init.lua finishes) redefine their default highlight links at that point
-- -- e.g. render-markdown.nvim relinking RenderMarkdownCode to ColorColumn
-- -- which silently overwrites what we just set above. Re-apply once more
-- after Neovim has fully finished starting up so ours is always the final
-- word, no matter what order plugins loaded in.
vim.api.nvim_create_autocmd("VimEnter", {
  group = "TerminalColorscheme",
  once = true,
  callback = function()
    if vim.g.colors_name == "terminal" then
      apply()
    end
  end,
})
