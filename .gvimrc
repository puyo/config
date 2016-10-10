if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &File.Close key=<nop>
  macmenu &File.Print key=<nop>
  macmenu &Tools.Make key=<nop>
  nnoremap <D-w> :silent Kwbd<CR>
  nnoremap <D-p> :CtrlP<CR>
  nnoremap <D-r> :CtrlPMRUFiles<CR>
  nnoremap <D-b> :CtrlPBuffer<CR>
  set guifont=Menlo\ Regular:h15
endif

