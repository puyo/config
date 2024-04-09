require("nvchad.mappings")

local function current_buffer_dir()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  local buffer_dir = vim.fs.dirname(buffer_name)
  local escaped_buffer_dir = vim.fn.substitute(buffer_dir, " ", "\\ ", "g")
  return escaped_buffer_dir
end

local function edit_current_buffer_dir_expr()
  return ":e " .. current_buffer_dir() .. "/"
end

local map = vim.keymap.set
local telescope_builtin = require("telescope.builtin")

map("c", "<M-BS>", "<C-W>", { desc = "Back word" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<D-b>", telescope_builtin.buffers, { desc = "Buffers" })
map({ "n", "i", "v" }, "<D-o>", edit_current_buffer_dir_expr, { desc = "Open buffer", expr = true })
map({ "n", "i", "v" }, "<D-p>", telescope_builtin.git_files, { desc = "Project files" })
map({ "n", "i", "v" }, "<D-r>", telescope_builtin.oldfiles, { desc = "Recent files" })
map({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map({ "n", "i", "v" }, "<D-w>", "<cmd>silent confirm bd<cr>", { desc = "Close buffer" })
map({ "n", "i", "v" }, "<D-z>", "<cmd>silent undo<cr>", { desc = "Undo" })
map({ "n", "i" }, "<D-/>", require("Comment.api").toggle.linewise.current, { desc = "Comment toggle" })

-- open current code in github, gitlab, etc., browser

local git_open_in_browser = function(mode)
  local gitlinker = require("gitlinker")
  local gitlinker_actions = require("gitlinker.actions")
  gitlinker.get_buf_range_url(mode, { action_callback = gitlinker_actions.open_in_browser })
end

map("n", "gB", function()
  git_open_in_browser("n")
end, { silent = false })

map("v", "gB", function()
  git_open_in_browser("v")
end, { silent = false })

-- close fuzzy file finder instantly on Esc
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  },
})

-- haven't figured out how to convert these to lua yet
vim.cmd([[
" don't overwrite the clipboard/register when pasting so I can paste repeatedly the same text
xnoremap p P

" s in visual mode starts surround
vmap s S

" Or just type the quote you want
vmap " S"
vmap ' S'
vmap ) S)
vmap ( S)

" paste
inoremap <D-v> <ESC>"+pa
nnoremap <D-v> "+P
vnoremap <D-v> "+p

" toggle comment, maintain selection
vmap <D-/> gcgv

" copy
vnoremap <D-c> "+ygv

" cut
vnoremap <D-x> "+c

" Don't lose highlight after indenting it
vnoremap < <gv
vnoremap > >gv

" Zoom font size

" guifont = "ComicMono Nerd Font:h13"
" \@<= means lookbehind, the whole regexp only matches if the prefix is present

function! FontSizePlus ()
  let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
  let l:gf_size_whole = l:gf_size_whole + 1
  let l:new_font_size = ':h'.l:gf_size_whole
  let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
endfunction

function! FontSizeMinus ()
  let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
  let l:gf_size_whole = l:gf_size_whole - 1
  let l:new_font_size = ':h'.l:gf_size_whole
  let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
endfunction

nmap <D--> :call FontSizeMinus()<CR>
nmap <D-=> :call FontSizePlus()<CR>
]])
