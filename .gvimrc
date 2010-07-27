if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
else
  nmap <silent> <Leader>t :CommandT<CR>
endif
