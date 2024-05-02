set mouse=a
set clipboard+=unnamedplus
set guifont=ComicMono\ Nerd\ Font:h13

" Turn off tabline in nvim-qt
call rpcnotify(0, 'Gui', 'Option', 'Tabline', 0)

highlight Cursor guifg=white guibg=#fe019a
highlight iCursor guifg=black guibg=#fe019a

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
