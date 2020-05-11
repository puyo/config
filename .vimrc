" vim: set foldmethod=marker foldmarker={,}:

set nocompatible " improved!

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug {

" colour schemes
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'tomasr/molokai'
Plug 'zefei/cake16'

Plug 'puyo/vim-colors-pencil-warm'

" .rdoc syntax highlighting
Plug 'depuracao/vim-rdoc'

" press <Tab> to complete the current word
Plug 'ervandew/supertab'

" :W! to sudo write
Plug 'gmarik/sudo-gui.vim'

" allows custom text objects
Plug 'kana/vim-textobj-user'

" jump to files: in directory tree, most-recently-used, open buffers
Plug 'kien/ctrlp.vim'

" 'i' is a text object that selects the current indentation level. e.g. vii
Plug 'michaeljsmith/vim-indent-object'

" 'r' is a text object that selects the current Ruby structure. e.g. vir
Plug 'nelstrom/vim-textobj-rubyblock'

" File types
Plug 'digitaltoad/vim-jade'             " .jade
Plug 'elixir-lang/vim-elixir'           " .ex, exs
Plug 'elmcast/elm-vim'                  " .elm
Plug 'idris-hackers/idris-vim'          " .idr
Plug 'kchmck/vim-coffee-script'         " .coffee
Plug 'leafgarland/typescript-vim'       " .ts
Plug 'mustache/vim-mustache-handlebars' " .hbr
Plug 'pangloss/vim-javascript'          " .js
Plug 'puyo/vim-cucumber'                " .feature
Plug 'puyo/vim-haml'                    " .haml
Plug 'slashmili/alchemist.vim'          " .ex, .exs
Plug 'tpope/vim-rails'                  " .rb, .erb
Plug 'wavded/vim-stylus'                " .stylus
Plug 'rust-lang/rust.vim'               " .rs

" elixir: mix format on save
Plug 'mhinz/vim-mix-format'

" kill buffers without closing their window
Plug 'rgarver/Kwbd.vim'

" gc to toggle comments
Plug 'tpope/vim-commentary'

" UNIX commands :Unlink :Remove :Move :Chmod :Find :Locate :SudoWrite :W
Plug 'tpope/vim-eunuch'

" Git commands :Ggrep
Plug 'tpope/vim-fugitive'

" GitHub commands :Gbrowse
Plug 'tpope/vim-rhubarb'

" .md syntax highlighting
Plug 'tpope/vim-markdown'

" press . to repeat more sophisticated things
Plug 'tpope/vim-repeat'

" Edit quotes and brackets more easily
Plug 'tpope/vim-surround'

" press % to jump between Ruby keywords. e.g. do and end
Plug 'vim-scripts/matchit.zip'

" Emmet
Plug 'mattn/emmet-vim'

" Argument text objects - ia, aa
Plug 'wellle/targets.vim'

" Use .editorconfig files
Plug 'editorconfig/editorconfig-vim'

" Status line
Plug 'vim-airline/vim-airline'

" Status line themes
Plug 'vim-airline/vim-airline-themes'

" Exchange text objects
Plug 'tommcdo/vim-exchange'

" Find project root and auto change directory to it
Plug 'airblade/vim-rooter'

" Version of :%s that previews that changes that will be made
Plug 'osyo-manga/vim-over'

" Async lint engine
Plug 'w0rp/ale'

" Align stuff
Plug 'junegunn/vim-easy-align'

" Cycle themes
Plug 'vim-scripts/CycleColor'

" Project mode
Plug 'tpope/vim-projectionist'

" Haskell
Plug 'dag/vim2hs'

" AsyncRun ...
Plug 'skywind3000/asyncrun.vim'

" chruby support
Plug 'mikepjb/vim-chruby'

" Svelte
Plug 'evanleck/vim-svelte'

" Racket
Plug 'wlangstroth/vim-racket'

call plug#end()
" }

" Basics {
filetype plugin indent on " auto indenting
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

" CtrlP {

let g:ctrlp_match_window_reversed = 0
let g:ctrlp_prompt_mappings = {
\ 'PrtInsert("c")':       ['<c-v>', '<insert>', '<MiddleMouse>'],
\ }

" }

" Multiple VCS's:
let g:ctrlp_user_command = {
  \ 'types': {
  \   1: ['.git', 'cd %s && git ls-files'],
  \   },
  \ 'fallback': 'find %s -type f'
  \ }

" }

" Appearance {

syntax on " syntax highlighting

if has("termguicolors")
  set termguicolors
endif

if has("gui")
  " colorscheme spacemacs-theme
  let g:pencil_higher_contrast_ui = 0   " 0=low (def), 1=high
  let g:airline_theme = 'pencil'

  set background=light

  colorscheme pencil-warm

  hi! link elixirStringDelimiter  String
  hi! link elixirAtom             Symbol
else
  set background=dark
  colorscheme pencil-warm
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
au BufNewFile,BufRead *.txt setlocal filetype=text
au BufNewFile,BufRead *.ejs setlocal filetype=html
au BufNewFile,BufRead *.hamlc setlocal filetype=haml
au BufNewFile,BufRead *.md.erb setlocal filetype=markdown
au BufNewFile,BufRead *.markdown.liquid setlocal filetype=markdown
au BufNewFile,BufRead *.as setlocal filetype=javascript
augroup END

augroup filetypes
au FileType c setlocal sw=4 sts=4 makeprg=make
au FileType ruby setlocal makeprg=rake path+=lib tw=78 ts=2 et sw=2 sts=2
au FileType eruby setlocal makeprg=rake
au FileType css setlocal makeprg=rake
au FileType text setlocal wrap linebreak nolist tw=0 wm=0 spell
au FileType python setlocal et ts=4 sw=4 sts=4
au FileType plaintex setlocal spell
au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist tw=0 wm=0 spell
au FileType slim setlocal comments+=b:'
au FileType coffee setlocal ts=2 sw=2 sts=2
au FileType javascript setlocal ts=2 sw=2 sts=2
au FileType json setlocal nowrap smartindent
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

nnoremap <C-]> g<C-]>

nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>r :CtrlPMRUFiles<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>s :w<CR>
nnoremap <Leader>a :wall<CR>
nnoremap <Leader>p "+p
vnoremap <Leader>c "+y
nnoremap <Leader>w :bd<CR>
nnoremap <Leader>q :qall<CR>

" Quoting {
"
" Press s to surround selection with quotes, same as Spacemacs
vmap s S

" Or just type the quote you want
vmap " hS"
vmap ' hS'
vmap ) hS)
vmap ( hS)

let g:surround_37 = "%{\r}"
let g:surround_109 = "%{\r}"

" }

" use ; instead of : because it is quicker
nnoremap ; :

" Use ;w!! to sudo save a file
cnoremap w!! w !sudo tee % >/dev/null

" Don't lose highlight after indenting it
vnoremap < <gv
vnoremap > >gv

" Disable commands I never want to use, in case I hit them accidentally {
nnoremap <F1> <Esc>
inoremap <F1> <Esc>a
nnoremap K <nop>
" }

" M-a switches between alternative files (.cpp <=> .hpp)
nnoremap <M-a> :A<CR>
inoremap <M-a> <ESC>:A<CR>

" Compilation and quickfix {
nnoremap co :copen<CR>
nnoremap cc :cclose<CR>
nnoremap c] :cnext<CR>
nnoremap c[ :cprev<CR>
" }

" Allow %/ to be put in :e lines and be expanded to the currently open file's
" directory.
cnoremap %/ <C-R>=expand("%:p:h")."/"<CR>
nnoremap ,e :e
  \ <C-R>=
  \ substitute(expand("%:p:h"), ' ', '\\ ', 'g')
  \ .'/'<CR><BS>/

" Alt-Backspace is delete word back, like bash/emacs
cnoremap <M-BS> <C-W>

" :bd does not disturb the split layout
cabbrev bd silent Kwbd

" :q quits reliably
cabbrev q qall

" :wq writes and quits reliably
cabbrev wq wqall

" Spacemacs like keybinding for switching between two files
nnoremap <SPACE><TAB> :execute 'edit ' . (ctrlp#mrufiles#list()[1])<CR>

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

" Projectionist {
let g:projectionist_heuristics = {
\  "web/router.ex": {
\    "web/controllers/*_controller.ex": {
\      "type": "controller",
\      "alternate": "test/controllers/{}_controller_test.exs",
\    },
\    "web/models/*.ex": {
\      "type": "model",
\      "alternate": "test/models/{}_test.exs",
\    },
\    "web/views/*_view.ex": {
\      "type": "view",
\      "alternate": "test/views/{}_view_test.exs",
\    },
\    "web/templates/*.html.eex": {
\      "type": "template",
\      "alternate": "web/views/{dirname|basename}_view.ex"
\    },
\    "test/*_test.exs": {
\      "type": "test",
\      "alternate": "web/{}.ex",
\    }
\  },
\  "mix.exs": {
\    "lib/*.ex": { "alternate": "test/{}_test.exs" },
\    "test/*_test.exs": { "alternate": "lib/{}.ex" }
\  }
\}
noremap <leader>ec :Econtroller<Space>
noremap <leader>em :Emodel<Space>
noremap <leader>et :Etemplate<Space>
noremap <leader>eT :Etest<Space>
noremap <leader>ev :Eview<Space>
noremap <leader>a  :A<CR>
" }

" Ale {
"
let g:ale_sign_column_always = 1

" " Be strict please Credo
" call ale#linter#Define('elixir', {
" \   'name': 'credo',
" \   'executable': 'mix',
" \   'command': 'mix credo suggest --strict --format=flycheck --read-from-stdin %s',
" \   'callback': 'ale_linters#elixir#credo#Handle',
" \})

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Set specific linters
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'ruby': ['rubocop'],
      \ }

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

" }

" Haskell {

let g:haskell_conceal = 0

" }

" AsyncRun {
let g:asyncrun_open = 20 " height of quickfix window
" }

" Rust {
let g:rustfmt_autosave = 1
" }

" rooter {
let g:rooter_silent_chdir = 1
" }
"

" vim-mix-format {
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1
" }
