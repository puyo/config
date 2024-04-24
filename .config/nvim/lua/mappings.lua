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

local function edit_last_file_expr()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)

  for _, file in ipairs(vim.v.oldfiles) do
    local file_stat = vim.loop.fs_stat(file)
    if file_stat and file_stat.type == "file" and file ~= current_file then
      return ":e " .. file .. "<cr>"
    end
  end

  return ""
end

-- Keep oldfiles up to date so we can switch between them
vim.cmd([[
function! UpdateOldFiles()
  let file = expand('%:p')
  let idx = index(v:oldfiles, file)
  if idx != -1
    call remove(v:oldfiles, idx)
  endif
  call insert(v:oldfiles, file, 0)
endfunction
autocmd! BufEnter * call UpdateOldFiles()
]])

local map = vim.keymap.set
local telescope_builtin = require("telescope.builtin")
local tabufline = require("nvchad.tabufline")
local comment = require("Comment.api")

map("c", "<M-BS>", "<C-W>", { desc = "Back word" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i" }, "<D-/>", comment.toggle.linewise.current, { desc = "Toggle comment" })
map({ "n", "i", "v" }, "<D-b>", telescope_builtin.buffers, { desc = "Browse buffers" })
map({ "n", "i", "v" }, "<D-o>", edit_current_buffer_dir_expr, { desc = "Open buffer", expr = true })
map({ "n", "i", "v" }, "<D-p>", telescope_builtin.git_files, { desc = "Browse project files" })
map({ "n", "i", "v" }, "<D-r>", telescope_builtin.oldfiles, { desc = "Browse recent files" })
map({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map({ "n", "i", "v" }, "<D-w>", tabufline.close_buffer, { desc = "Close buffer" })
map({ "n", "i", "v" }, "<D-z>", "<cmd>undo<cr>", { desc = "Undo", silent = true })
map({ "n", "i", "v" }, "<D-{>", tabufline.prev, { desc = "Go to prev buffer" })
map({ "n", "i", "v" }, "<D-}>", tabufline.next, { desc = "Go to next buffer" })
map({ "n", "v" }, "<leader><tab>", edit_last_file_expr, { desc = "Go to last buffer", expr = true, silent = true })

-- stop nvchad messing with C-i
vim.keymap.set("n", "<tab>", "")
vim.keymap.del("n", "<tab>")

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
" vmap " S"
" vmap ' S'
" vmap ) S)
" vmap ( S)

" select all
imap <D-a> <ESC><D-a>
nnoremap <D-a> ggVG
vmap <D-a> <ESC><D-a>

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

" Strip trailing whitespace when I save source files.
function! StripTrailingWhitespaces() range
  silent! execute a:firstline . "," . a:lastline . 's/\s\+$/\1/e'
  normal! g`"
endfunction
command! -range=% StripTrailingWhitespaces <line1>,<line2>call StripTrailingWhitespaces()

]])
