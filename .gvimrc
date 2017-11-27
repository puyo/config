if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &File.Open\.\.\. key=<nop>
  macmenu &File.Close key=<nop>
  macmenu &File.Print key=<nop>
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
  set guifont=Menlo\ Regular:h12
  set fuoptions+=maxhorz " full screen options on mac
  set macmeta " option key works as M- key modifier
endif

