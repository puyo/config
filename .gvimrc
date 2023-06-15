if has("gui_gtk3")
  set guifont=Comic\ Mono\ 11
  set linespace=1

  imap <C-M-s> <ESC><C-M-s>
  nnoremap <C-M-s> :w<CR>
  vmap <C-M-s> <ESC><C-M-s>gv

  inoremap <C-M-/> <ESC>lma:Commentary<CR>`ai
  nnoremap <C-M-/> :Commentary<CR>
  vnoremap <C-M-/> :Commentary<CR>gv

  inoremap <C-M-v> <ESC>"+pa
  nnoremap <C-M-v> "+P
  vnoremap <C-M-v> "+p

  imap <C-M-a> <ESC><C-M-a>
  nnoremap <C-M-a> ggVG
  vmap <C-M-a> <ESC><C-M-a>

  imap <C-M-b> <ESC><C-M-b>
  nnoremap <C-M-b> :CtrlPBuffer<CR>
  vmap <C-M-b> <ESC><C-M-b>

  imap <C-M-o> <ESC><C-M-o>
  nnoremap <C-M-o> :e
        \ <C-R>=
        \ substitute(expand("%:p:h"), ' ', '\\ ', 'g')
        \ .'/'<CR><BS>/
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

  " recompute window size after font size changes
  set guioptions+=k

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

  nmap <C-M-_> :call FontSizeMinus()<CR>
  nmap <C-M-=> :call FontSizePlus()<CR>
endif
