if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  nmap <D-t> :CommandT<CR>
  nmap <D-Left> :bprev<CR>
  nmap <D-Right> :bnext<CR>
else
  nmap <M-t> :CommandT<CR>
  nmap <M-Left> :bprev<CR>
  nmap <M-Right> :nnext<CR>
endif
