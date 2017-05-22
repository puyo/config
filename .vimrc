" vim: set foldmethod=marker foldmarker={,}:

" Vundle {
set nocompatible " improved!
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" colour scheme
Plugin 'chriskempson/base16-vim'
" colour scheme
Plugin 'chriskempson/vim-tomorrow-theme'
" .rdoc syntax highlighting
Plugin 'depuracao/vim-rdoc'
" press <Tab> to complete the current word
Plugin 'ervandew/supertab'
" :W! to sudo write
Plugin 'gmarik/sudo-gui.vim'
" align code. e.g. :Tabularize / ,
Plugin 'godlygeek/tabular'
" allows custom text objects
Plugin 'kana/vim-textobj-user'
" .coffee syntax highlighting
Plugin 'kchmck/vim-coffee-script'
" jump to files: in directory tree, most-recently-used, open buffers
Plugin 'kien/ctrlp.vim'
" 'i' is a text object that selects the current indentation level. e.g. vii
Plugin 'michaeljsmith/vim-indent-object'
" 'r' is a text object that selects the current Ruby structure. e.g. vir
Plugin 'nelstrom/vim-textobj-rubyblock'
" .feature syntax highlighting
Plugin 'puyo/vim-cucumber'
" .haml syntax highlighting
Plugin 'puyo/vim-haml'
" kill buffers without closing their window
Plugin 'rgarver/Kwbd.vim'
" colour scheme
Plugin 'tomasr/molokai'
" press \\ or \\\ to toggle comments on a line
Plugin 'tpope/vim-commentary'
" tmux integration for running tests
Plugin 'tpope/vim-dispatch'
" UNIX commands :Unlink :Remove :Move :Chmod :Find :Locate :SudoWrite :W
Plugin 'tpope/vim-eunuch'
" Git commands :Ggrep
Plugin 'tpope/vim-fugitive'
" .md syntax highlighting
Plugin 'tpope/vim-markdown'
" Rails project mode
Plugin 'tpope/vim-rails'
" press . to repeat more sophisticated things
Plugin 'tpope/vim-repeat'
" Edit quotes and brackets more easily
Plugin 'tpope/vim-surround'
" press % to jump between Ruby keywords. e.g. do and end
Plugin 'vim-scripts/matchit.zip'
" :A to jump to the 'alternative' file
Plugin 'vim-scripts/a.vim'
" For running rspecs
Plugin 'thoughtbot/vim-rspec'
" Rust mode
Plugin 'wting/rust.vim'
" Elixir mode
Plugin 'elixir-lang/vim-elixir'
" Slim
Bundle 'slim-template/vim-slim.git'
" Emmet
Plugin 'mattn/emmet-vim'
" Argumentative
Plugin 'wellle/targets.vim'
" Rainbow parenthesis
Plugin 'kien/rainbow_parentheses.vim'
" Jade
Plugin 'digitaltoad/vim-jade'
" Stylus
Plugin 'wavded/vim-stylus'
" Javascript (more modern JS syntax like backticks)
Plugin 'pangloss/vim-javascript'
" Use .editorconfig files
Plugin 'editorconfig/editorconfig-vim'
" Syntax checking
Plugin 'scrooloose/syntastic'
" Status line
Plugin 'vim-airline/vim-airline'
" Status line themes
Plugin 'vim-airline/vim-airline-themes'
" Exchange text objects
Plugin 'tommcdo/vim-exchange'
" Manipulate function arguments
Plugin 'PeterRincker/vim-argumentative'
call vundle#end()

filetype plugin indent on     " auto indenting
" }

" Basics {
set noexrc " don't use local .vimrc files
set cpoptions+=a " :read updates alternative file name
set cpoptions+=A " :write updates alternative file name
set cpoptions+=c " continue searching after the current match
set cpoptions+=F " :write updates current buffer file name
set cpoptions+=m " show match parens after .5s
set cpoptions+=q " when joining lines, leave the cursor between lines
set history=100  " keep this many lines of command line history
set mousemodel=popup " right mouse button pops up a menu
"helptags ~/.vim/doc " add help searching for user installed packages
set t_Co=256 " use all 256 colours in 256 colour terminals
" }

" Folding {
set foldenable " turn on folding
set foldmethod=indent " fold on indent
set foldlevel=100 " don't autofold anything (but I can still fold manually)
" }

" Files and buffers {
set nobackup " don't backup files
set noswapfile " don't create swapfiles
set backupdir=~/.vim/backup " where to put backup files
set fileformats=unix,dos,mac " support all three, in this order
set directory=~/.vim/tmp
set hidden " let me open multiple unsaved buffers
set autowrite " autowrite, save the file when calling external commands
set autoread " reload file from disk if it changed before I modified it
set wildignore+=*.o,*.obj,.git,.sass-cache,tmp,coverage

" Strip trailing whitespace when I save source files.
function! StripTrailingWhitespaces() range
silent! execute a:firstline . "," . a:lastline . 's/\s\+$/\1/e'
normal! g`"
endfunction
command! -range=% StripTrailingWhitespaces <line1>,<line2>call StripTrailingWhitespaces()


"autocmd BufWritePre *.{h,c,hpp,cpp,cc,hh,rb,sh,erb,feature,html,css,scss,sass,haml} :call StripTrailingWhitespaces()

set wildignore+=node_modules
let g:ctrlp_match_window_reversed = 0

" }

" Appearance {

syntax on " syntax highlighting
if has("gui")
  colorscheme base16-materia
else
  colorscheme molokai
endif
set synmaxcol=200 " faster syntax highlighting
set clipboard+=unnamed " share windows clipboard
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set noerrorbells " no error bells
set visualbell " don't beep
set t_vb= " terminal code for flashing the screen
set incsearch " highlight search matches as I type the search query
set nohlsearch " don't highlight the last search, I find it distracting
set showmatch " parens matching (like Emacs paren blink)
set scrolloff=10 " always show 10 lines above and below cursor
set sidescrolloff=10 " always show 10 lines side of cursor
set guioptions+=c " use console dialogs for simple choices
set guioptions-=m " hide menu bar
set guioptions-=T " hide tool bar
set guioptions-=l " hide left scroll bar
set guioptions-=r " hide right scroll bar
"set guioptions+=l " left scroll bar always
"set guioptions-=r " don't always display right scroll bar
"set guioptions+=R " display right scroll when vertical split
set nowrap " do not wrap long lines
"set cursorcolumn " highlight current column
set cursorline " highlight current line
set laststatus=2 " always show the status line
set lazyredraw " do not redraw while running macros
set linespace=0 " do not insert extra pixels between rows
"set list " needed to display tabs
"set listchars=tab:>- " only display tabs, not other whitespace
set shortmess=aOstT " try to avoid 'press a key' prompts
set report=0 " tell us when anything has changed
set number " line numbers on the left
set wildmode=list:longest " bash-like tab completion
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc, " ignore these
\*.jpg,*.gif,*.png,*~,*.swp
set statusline="%f %m%r%h%w[ff=%{&ff}][ft=%Y][%l/%L,%v]"
if has("gui_macvim")
set fuoptions+=maxhorz " full screen options on mac
set macmeta
endif
" }

" Text and code editing {
set backspace=indent,eol,start " allow backspacing over everything
set nojoinspaces " only insert one space when joining sentences
set expandtab " no actual tabs by default
set tabstop=8  " tab size (how many characters wide tabs are)
set shiftwidth=2 " general purpose indent/unindent size
set softtabstop=2 " number of spaces to insert instead of a tab
set shiftround " round up to the next indentation column
set completeopt= " don't use a pop up menu for completions
set ignorecase " ignore case in patterns
set infercase " infer case in patterns
set smartcase " infer case in searches
set formatoptions+=r " auto-insert comment leader when pressing enter
set formatoptions+=q " format comments with gq
set iskeyword+=-,_,$,@,%,#,? " these are not word dividers
set complete=.,b " complete using current buffer, then all open buffers
" }

" File types {
filetype plugin indent on
augroup filetypedetect
au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru} setlocal filetype=ruby
au BufNewFile,BufRead {Gemfile,Guardfile} setlocal filetype=ruby
au BufNewFile,BufRead *.json setlocal nowrap smartindent
au BufNewFile,BufRead *.txt setlocal filetype=text
au BufNewFile,BufRead *.ejs setlocal filetype=html
au BufNewFile,BufRead *.hamlc setlocal filetype=haml
au BufNewFile,BufRead *.md.erb setlocal filetype=markdown
au BufNewFile,BufRead *.markdown.liquid setlocal filetype=markdown
au BufNewFile,BufRead *.as setlocal filetype=javascript

au FileType c setlocal sw=4 sts=4 makeprg=make
au FileType ruby setlocal makeprg=rake path+=lib tw=78 ts=2 et sw=2 sts=2
au FileType eruby setlocal makeprg=rake
au FileType css setlocal makeprg=rake
au FileType text setlocal wrap linebreak nolist tw=0 wm=0 spell
au FileType python setlocal et ts=4 sw=4 sts=4
au FileType plaintex setlocal spell
au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist tw=0 wm=0 spell
au FileType slim setlocal comments+=b:'
au FileType coffee setlocal ts=4 sw=4 sts=4
au FileType javascript setlocal ts=4 sw=4 sts=4

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
augroup END
" }

" rails.vim {
" " app to spec and back
" autocmd User Rails/app/assets/javascripts/**/*.js.coffee let b:rails_alternate = substitute(substitute(rails#buffer().path(), 'app/assets', 'spec', ''), '\.js\.coffee', '_spec.js.coffee', '')
" autocmd User Rails/spec/javascripts/*/*.js.coffee let b:rails_alternate = substitute(substitute(rails#buffer().path(), 'spec/javascripts', 'app/assets/javascripts', ''), '_spec\.js\.coffee', '.js.coffee', '')

" " lib to spec and back
" autocmd User Rails/lib/assets/javascripts/*.js.coffee let b:rails_alternate = substitute(substitute(rails#buffer().path(), 'lib/assets/javascripts', 'spec/javascripts/lib', ''), '\.js\.coffee', '_spec.js.coffee', '')
" autocmd User Rails/spec/javascripts/lib/*.js.coffee let b:rails_alternate = substitute(substitute(rails#buffer().path(), 'spec/javascripts/lib', 'lib/assets/javascripts', ''), '_spec\.js\.coffee', '.js.coffee', '')
" }

" Ex commands {

" HTMLize - TOhtml then strip the cruft
let html_use_css = 1
let html_number_lines = 0
function! HTMLize(line1, line2) range
exec (a:line1. ',' . a:line2) . 'TOhtml'
exec '0,/<body/d'
exec '$-1,$d'
endfunction
command! -range=% HTMLize :call HTMLize(<line1>, <line2>)

" }

" Shortcuts {

" All those commands that start with <Leader> now start with , not \
let mapleader=","

nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>r :CtrlPMRUFiles<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>s :w<CR>
nnoremap <Leader>a :wall<CR>
nnoremap <Leader>p "+p
vnoremap <Leader>c "+y
nnoremap <Leader>w :bd<CR>
nnoremap <Leader>q :qall<CR>

" Simpler visual mode quoting
vmap " hS"
vmap ' hS'
vmap ) hS)
vmap ( hS)

"nnoremap <C-s> :update<CR>
"inoremap <C-s> <C-o>:update<CR>
"vnoremap <C-s> <Esc>:update<CR>gv

" easier split navigation {
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <bar> <C-w>v
nnoremap - <C-w>s
" }

" use ; instead of : because it is quicker
nnoremap ; :

" Use ;w!! to sudo save a file
cnoremap w!! w !sudo tee % >/dev/null

" Don't lose highlight
vnoremap < <gv
vnoremap > >gv

" Disable commands I never want to use, in case I hit them accidentally
nnoremap <F1> <Esc>
inoremap <F1> <Esc>a
nnoremap K <nop>

" M-a switches between alternative files (.cpp <=> .hpp)
nnoremap <M-a> :A<CR>
inoremap <M-a> <ESC>:A<CR>

" Compilation and quickfix
nnoremap <F9> :copen<CR>
nnoremap <F10> :cnext<CR>
nnoremap <F11> :cprev<CR>

" Allow %/ to be put in :e lines and be expanded to the currently open file's
" directory.
cnoremap %/ <C-R>=expand("%:p:h")."/"<CR>
nnoremap ,e :e <C-R>=substitute(expand("%:p:h"), ' ', '\\ ', 'g').'/'<CR><BS>/

" Alt-Backspace is delete word back, like bash/emacs
cnoremap <M-BS> <C-W>

" :bd does not disturb the split layout
cabbrev bd silent Kwbd

" :q quits reliably
cabbrev q qall

" :wq writes and quits reliably
cabbrev wq wqall

function! RubyHashes() range
silent! execute a:firstline . "," . a:lastline . 's/:\([a-z_]\{-1,}\)\s\{-}=>/\1:/Ig'
endfunction
command! -range=% RubyHashes  <line1>,<line2>call RubyHashes()

" Navigate through open buffers with C-Tab/C-S-Tab or M-Left/Right {
map <M-Left> <ESC>:bp<RETURN>
map <M-Right> <ESC>:bn<RETURN>
" }

" Eclipse moving blocks of text {
nmap <M-j> :<C-U>move .+1<CR>==
nmap <M-k> :<C-U>move .-2<CR>==
imap <M-j> <C-o>:<C-u>move .+1<CR><C-o>==
imap <M-k> <C-o>:<C-u>move .-2<CR><C-o>==
vmap <M-j> :move '>+1<CR>gv
vmap <M-k> :move '<-2<CR>gv
nmap <M-h> <<
nmap <M-l> >>
imap <M-h> <C-o><<
imap <M-l> <C-o>>>
vmap <M-h> <gv
vmap <M-l> >gv
" }

" vmap <D-Bslash> :Align<Bar><CR>gv=gv
" nmap <D-Bslash> vii:Align<Bar><CR>gv=

" }

" JSLint {
au FileType javascript setl makeprg=jsl\ -nologo\ -nocontext\ -nosummary\ -process\ % errorformat=%f(%l):\ %m
" }

" Tabularize {
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }

" Highlight superfluous whitespace on the ends of lines {
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }

" Create missing directories on save {
augroup BWCCreateDir
autocmd!
autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END
" }

" Syntax checking {
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby', 'javascript'], 'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }
