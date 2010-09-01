if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  nmap <D-t> :CommandT<CR>
  nmap <D-Left> :bprev<CR>
  nmap <D-Right> :bnext<CR>
  nmap <D-R> :<CR>
  map <D-R> :call RunSpec(":".line('.'))<CR>
  map <D-r> :call RunSpec("")<CR>
else
  nmap <M-t> :CommandT<CR>
  nmap <M-Left> :bprev<CR>
  nmap <M-Right> :nnext<CR>
endif
