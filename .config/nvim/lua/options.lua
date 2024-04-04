require("nvchad.options")

local o = vim.o
o.compatible = false
o.showtabline = 0
o.spelllang = "en_au"
o.expandtab = true

-- no really
vim.cmd([[
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=0
]])
