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
  nnoremap <D-o> :e  <C-R>=substitute(expand("%:p:h"), ' ', '\\ ', 'g') .'/'<CR><BS>/
  set guifont=Menlo\ Regular:h13
  set fuoptions+=maxhorz " full screen options on mac
  set macmeta " option key works as M- key modifier
elseif has("gui")
  " gvim + xkeysnail super bindings
  inoremap <C-M-v> <ESC>"+p
  nnoremap <C-M-S-c> gcc
  nnoremap <C-M-a> ggVG
  nnoremap <C-M-b> :CtrlPBuffer<CR>
  nnoremap <C-M-o> :e <C-R>=substitute(expand("%:p:h"), ' ', '\\ ', 'g') .'/'<CR><BS>/
  nnoremap <C-M-p> :CtrlP<CR>
  nnoremap <C-M-r> :CtrlPMRUFiles<CR>
  nnoremap <C-M-v> "+p
  nnoremap <C-M-w> :silent Kwbd<CR>
  nnoremap <C-M-z> u
  vnoremap <C-M-S-c> gc
  vnoremap <C-M-c> "+yi
  vnoremap <C-M-v> c<ESC>"+p
  vnoremap <C-M-x> "+c

  " y yanks to OS clipboard, p pastes from OS clipboard
  set clipboard=unnamedplus
endif
