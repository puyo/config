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
  " autokey super bindings

  imap <C-M-s> <ESC><C-M-s>
  nnoremap <C-M-s> :w<CR>
  vmap <C-M-s> <ESC><C-M-s>gv

  inoremap <C-M-m> <ESC>lma:Commentary<CR>`ai
  nnoremap <C-M-m> :Commentary<CR>
  vnoremap <C-M-m> :Commentary<CR>gv

  inoremap <C-M-v> <ESC>"+pa
  nnoremap <C-M-v> "+p
  vnoremap <C-M-v> "+p

  imap <C-M-a> <ESC><C-M-a>
  nnoremap <C-M-a> ggVG
  vmap <C-M-a> <ESC><C-M-a>

  imap <C-M-b> <ESC><C-M-b>
  nnoremap <C-M-b> :CtrlPBuffer<CR>
  vmap <C-M-b> <ESC><C-M-b>

  imap <C-M-o> <ESC><C-M-o>
  nnoremap <C-M-o> :e <C-R>=substitute(expand("%:p:h"), ' ', '\\ ', 'g') .'/'<CR><BS>/
  vmap <C-M-o> <ESC><C-M-o>

  imap <C-M-p> <ESC><C-M-p>
  nnoremap <C-M-p> :CtrlP<CR>
  vmap <C-M-p> <ESC><C-M-p>

  imap <C-M-r> <ESC><C-M-r>
  nnoremap <C-M-r> :CtrlPMRUFiles<CR>
  vmap <C-M-r> <ESC><C-M-r>

  imap <C-M-w> <ESC><C-M-w>
  nnoremap <C-M-w> :silent Kwbd<CR>
  vmap <C-M-w> <ESC><C-M-w>

  imap <C-M-z> <ESC><C-M-z>
  nnoremap <C-M-z> u
  vmap <C-M-z> <ESC><C-M-z>

  vnoremap <C-M-c> "+ygv

  vnoremap <C-M-x> "+c

  " y yanks to OS clipboard, p pastes from OS clipboard
  set clipboard=unnamedplus
endif
