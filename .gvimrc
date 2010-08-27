if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
else
  nmap <M-t> :CommandT<CR>
endif
