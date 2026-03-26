set mouse=a
set clipboard+=unnamedplus
set guifont=ComicMono\ Nerd\ Font:h14

" Turn off tabline in nvim-qt
call rpcnotify(0, 'Gui', 'Option', 'Tabline', 0)

highlight Cursor guifg=white guibg=#fe019a
highlight iCursor guifg=black guibg=#fe019a

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

if exists("g:neovide")
  let g:neovide_cursor_animation_length = 0
  let g:neovide_cursor_short_animation_length = 0
  let g:neovide_cursor_trail_size = 0
  let g:neovide_cursor_vfx_mode = ""
  let g:neovide_position_animation_length = 0
  let g:neovide_scroll_animation_length = 0
end
