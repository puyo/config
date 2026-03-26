-- Editor options: indentation, display, spelling, and other global settings.

require("nvchad.options")

local o = vim.o
o.compatible = false
o.showtabline = 0 -- hide the tab bar
o.spelllang = "en_au" -- Australian English spelling
o.expandtab = true -- spaces not tabs
o.linespace = 2 -- extra pixels between lines (GUI only)
o.shiftwidth = 2 -- indent width
o.wildmode = "list:longest" -- tab-complete like bash
o.foldenable = false -- start with all folds open

-- Respect .editorconfig files (this is the default in nvim 0.9+)
vim.g.editorconfig = true
