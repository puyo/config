if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &File.Close key=<nop>
  macmenu &File.Print key=<nop>
  macmenu &Tools.Make key=<nop>
  nmap <D-w> :silent Kwbd<CR>
  nmap <D-[> :bp<CR>
  nmap <D-]> :bn<CR>
  nmap <D-t> :CtrlP<CR>
  nmap <D-r> :CtrlPMRUFiles<CR>
  nmap <D-b> :CtrlPBuffer<CR>
  set guifont=Menlo\ Regular:h12
else
  nmap <M-t> :CtrlP<CR>
  nmap <M-r> :CtrlPMRUFiles<CR>
  nmap <M-b> :CtrlPBuffer<CR>
  nmap <M-[> :bp<CR>
  nmap <M-]> :bn<CR>
  nmap <M-w> :Kwbd<CR>
  nmap <M-v> "+p
  imap <M-v> <ESC>"+pi
  vmap <M-v> d"+P
  vmap <M-c> "+y
  vmap <M-x> "+d
  nmap <M-q> :qall<CR>
endif
