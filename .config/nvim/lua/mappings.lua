require "nvchad.mappings"

local function current_buffer_dir()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  local buffer_dir = vim.fs.dirname(buffer_name)
  local escaped_buffer_dir = vim.fn.substitute(buffer_dir, " ", "\\ ", "g")
  return escaped_buffer_dir
end

local function edit_current_buffer_dir_expr()
  return ":e " .. current_buffer_dir() .. "/"
end

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set({ "n", "i", "v" }, "<D-b>", require("telescope.builtin").buffers, { desc = "Buffers" })
vim.keymap.set({ "n", "i", "v" }, "<D-o>", edit_current_buffer_dir_expr, { desc = "Open buffer", expr = true })
vim.keymap.set({ "n", "i", "v" }, "<D-p>", require("telescope.builtin").git_files, { desc = "Project files" })
vim.keymap.set({ "n", "i", "v" }, "<D-r>", require("telescope.builtin").oldfiles, { desc = "Recent files" })
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save buffer" })
vim.keymap.set({ "n", "i", "v" }, "<D-w>", "<cmd>silent confirm bd<cr>", { desc = "Close buffer" })
vim.keymap.set({ "n", "i", "v" }, "<D-z>", "<cmd>silent undo<cr>", { desc = "Undo" })

-- close fuzzy file finder instantly on Esc
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  },
}

-- haven't figured out how to convert these to lua yet
vim.cmd [[
" paste
inoremap <D-v> <ESC>"+pa
nnoremap <D-v> "+P
vnoremap <D-v> "+p

" copy
vnoremap <D-c> "+ygv

" cut
vnoremap <D-x> "+c
]]
