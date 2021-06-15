if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &File.Open… key=<nop>
  macmenu &File.Close key=<nop>
  macmenu &File.Print key=<nop>
  macmenu &Edit.Find.Find\ Next key=<nop>
  macmenu &Tools.Make key=<nop>
  nnoremap <D-w> :silent Kwbd<CR>
  nnoremap <D-p> :CtrlP<CR>
  nnoremap <D-r> :CtrlPMRUFiles<CR>
  nnoremap <D-b> :CtrlPBuffer<CR>
  vnoremap <D-/> :Commentary<CR>
  nnoremap <D-o> :e
    \ <C-R>=
    \ substitute(expand("%:p:h"), ' ', '\\ ', 'g')
    \ .'/'<CR><BS>/
  nnoremap <D-g> :AsyncRun git grep -n<Space>
  set guifont=Menlo\ Regular:h13
  set fuoptions+=maxhorz " full screen options on mac
  set macmeta " option key works as M- key modifier
elseif has("gui")
  nnoremap <leader>w :silent Kwbd<CR>
  nnoremap <leader>p :CtrlP<CR>
  nnoremap <leader>r :CtrlPMRUFiles<CR>
  nnoremap <leader>b :CtrlPBuffer<CR>
  vnoremap <leader>/ :Commentary<CR>
  nnoremap <leader>o :e
    \ <C-R>=
    \ substitute(expand("%:p:h"), ' ', '\\ ', 'g')
    \ .'/'<CR><BS>/
  nnoremap <leader>g :AsyncRun git grep -n<Space>
endif

