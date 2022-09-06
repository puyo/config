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
  set guifont=Comic\ Shanns:h13,Menlo\ Regular:h13
  set fuoptions+=maxhorz " full screen options on mac
  set macmeta " option key works as M- key modifier
end

if has("gui_gtk3")
  set guifont=Comic\ Mono\ 11
  set linespace=1

  imap <M-s> <ESC><M-s>
  nnoremap <M-s> :w<CR>
  vmap <M-s> <ESC><M-s>gv

  inoremap <M-/> <ESC>lma:Commentary<CR>`ai
  nnoremap <M-/> :Commentary<CR>
  vnoremap <M-/> :Commentary<CR>gv

  inoremap <M-v> <ESC>"+pa
  nnoremap <M-v> "+P
  vnoremap <M-v> "+p

  imap <M-a> <ESC><M-a>
  nnoremap <M-a> ggVG
  vmap <M-a> <ESC><M-a>

  imap <M-b> <ESC><M-b>
  nnoremap <M-b> :CtrlPBuffer<CR>
  vmap <M-b> <ESC><M-b>

  imap <M-o> <ESC><M-o>
  nnoremap <M-o> :e
        \ <C-R>=
        \ substitute(expand("%:p:h"), ' ', '\\ ', 'g')
        \ .'/'<CR><BS>/
  vmap <M-o> <ESC><M-o>

  imap <M-p> <ESC><M-p>
  nnoremap <M-p> :CtrlP<CR>
  vmap <M-p> <ESC><M-p>

  imap <M-r> <ESC><M-r>
  nnoremap <M-r> :CtrlPMRUFiles<CR>
  vmap <M-r> <ESC><M-r>

  imap <M-w> <ESC><M-w>
  nnoremap <M-w> :silent Kwbd<CR>
  vmap <M-w> <ESC><M-w>

  imap <M-z> <ESC><M-z>
  nnoremap <M-z> u
  vmap <M-z> <ESC><M-z>

  vnoremap <M-c> "+ygv

  vnoremap <M-x> "+c

  " y yanks to OS clipboard, p pastes from OS clipboard
  set clipboard=unnamedplus

  function! FontSizePlus ()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
  endfunction

  function! FontSizeMinus ()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
  endfunction

  nmap <M--> :call FontSizeMinus()<CR>
  nmap <M-=> :call FontSizePlus()<CR>
endif
