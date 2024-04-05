require("nvchad.options")

local o = vim.o
o.compatible = false
o.showtabline = 0
o.spelllang = "en_au"
o.expandtab = true
o.linespace = 2

-- no really
vim.cmd([[
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=0
]])
