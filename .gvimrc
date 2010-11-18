if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &File.Close key=<nop>
  nmap <D-t> :CommandT<CR>
  nmap <D-Left> :bprev<CR>
  nmap <D-Right> :bnext<CR>
  map <D-R> :call RunSpec(":".line('.'))<CR>
  map <D-r> :call RunSpec("")<CR>
  nmap <D-w> :bd<CR>
  nmap <D-[> :bp<CR>
  nmap <D-]> :bn<CR>
else
  nmap <M-t> :CommandT<CR>
  nmap <M-Left> :bprev<CR>
  nmap <M-Right> :nnext<CR>
  nmap <M-[> :bp<CR>
  nmap <M-]> :bn<CR>
  nmap <M-s> :w<CR>
  nmap <M-w> :bd<CR>
  nmap <M-v> "+p
  imap <M-v> <ESC>"+pi
  vmap <M-v> d"+P
  vmap <M-c> "+y
  vmap <M-x> "+d
  nmap <M-q> :qall<CR>
endif
