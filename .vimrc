" vim: set foldmethod=marker foldmarker={,} foldlevel=0 spell:

" Basics {
set nocompatible " no vi-compatible mode
set noexrc " don't use local .vimrc files
set cpoptions+=a " :read updates alternative file name
set cpoptions+=A " :write updates alternative file name
set cpoptions+=c " continue searching after the current match
set cpoptions+=F " :write updates current buffer file name
set cpoptions+=m " show match parens after .5s
set cpoptions+=q " when joining lines, leave the cursor between lines
set history=100  " keep this many lines of command line history
set mousemodel=popup " right mouse button pops up a menu
helptags ~/.vim/doc " add help searching for user installed packages
" }

" Folding {
set foldenable " turn on folding
"set foldmarker={,} " fold C style code (only use this as default if you use a high foldlevel)
"set foldmethod=marker " fold on the marker
set foldmethod=syntax " fold on syntax constructs
set foldlevel=100 " don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag,search,undo " what movements open folds
function! SimpleFoldText()
    return getline(v:foldstart).' '
endfunction
set foldtext=SimpleFoldText() " custom fold text function (cleaner than default)
" }

" Files and buffers {
set backup " make backup files
set backupdir=~/.vim/backup " where to put backup files
set fileformats=unix,dos,mac " support all three, in this order
set directory=~/.vim/tmp
set hidden " let me open multiple unsaved buffers
set autowrite " autowrite, save the file when calling external commands
" }

" Appearance {
syntax on " syntax highlighting
if has("gui_running")
    colorscheme candycode " syntax highlighting colour scheme
else
    colorscheme desert " syntax highlighting colour scheme
    set background=light " use light foreground colours
end
set clipboard+=unnamed " share windows clipboard
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set noerrorbells " no error bells
set visualbell " flash the screen instead of beeping
set t_vb= " terminal code for flashing the screen
set incsearch " highlight search matches as I type the search query
set nohlsearch " don't highlight the last search, I find it distracting
set showmatch " parens matching (like Emacs paren blink)
set scrolloff=10 " always show 10 lines above and below cursor
set sidescrolloff=10 " always show 10 lines side of cursor
set guioptions-=m " hide menu bar
set guioptions-=T " hide tool bar
set guioptions+=l " left scroll bar always
set guioptions-=r " don't always display right scroll bar
set guioptions+=R " display right scroll when vertical split
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
endif
" }

" Text and code editing {
set backspace=indent,eol,start " allow backspacing over everything
set nojoinspaces " only insert one space when joining sentences
set expandtab " no actual tabs by default
set tabstop=8  " tab size (how many characters wide tabs are)
set shiftwidth=4 " general purpose indent/unindent size
set softtabstop=4 " number of spaces to insert instead of a tab
set shiftround " round up to the next indentation column
set completeopt= " don't use a pop up menu for completions
set ignorecase " ignore case in patterns
set infercase " infer case in patterns
set smartcase " infer case in searches
set formatoptions+=r " auto-insert comment leader when pressing enter
set formatoptions+=q " format comments with gq
set iskeyword+=_,$,@,%,#,? " these are not word dividers
" }

" File types {
filetype plugin indent on
augroup filetypedetect
    au BufNewFile,BufRead *.rb,*.rjs,*.rbw,*.gem,*.gemspec setl filetype=ruby
    au BufNewFile,BufRead *.as setl filetype=actionscript efm=%f(%l):\ col:\ %c\ Error:\ %m
    au BufNewFile,BufRead *.tex setl spell
    au BufNewFile,BufRead *.mxml setl filetype=xml number
    au BufNewFile,BufRead *.wiki setl filetype=Wikipedia
    au BufNewFile,BufRead *.json setl nowrap sw=2 ts=2 sts=0 noet smartindent
    au BufNewFile,BufRead *.txt setl filetype=text

    au FileType c setl et sw=4 sts=4 makeprg=make
    au FileType ruby setl et sw=2 sts=2 makeprg=rake
    au FileType eruby setl et sw=2 sts=2 makeprg=rake
    au FileType css setl et ts=2 sw=2 sts=2 makeprg=rake
    au FileType actionscript setl nowrap sw=2 ts=2 sts=0 noet smartindent
    au FileType text setl textwidth=78
    au FileType aspvbs setl ts=4
augroup END
" }

" Ex commands {

" HTMLize - TOhtml then strip the cruft
let html_use_css = 1
function! HTMLize(line1, line2) range
    exec (a:line1. ',' . a:line2) . 'TOhtml'
    exec '0,/<body/d'
    exec '$-1,$d'
endfunction
command! -range=% HTMLize :call HTMLize(<line1>, <line2>)

" }

" Shortcuts {

if has("gui_macvim")
  set macmeta " allow alt/option to act as meta key
endif

" M-t transposes comma separated arguments
map <M-t> "qdiwdwep"qp

" M-a switches between alternative files (.cpp <=> .hpp)
nmap <M-a> :A<CR>
imap <M-a> <ESC>:A<CR>

" M-r opens the most recently used file list
nmap <M-r> :MRU<CR>
imap <M-r> <ESC>:MRU<CR>
let MRU_Max_Entries = 100

" Compilation and quickfix
nmap <F9> :make<CR><CR><CR>:copen<CR><C-W><C-W>k
nmap <F10> :cnext<CR>
nmap <F11> :cprev<CR>

" Tag list
nmap <F12> :TlistToggle<CR>

" Allow %/ to be put in :e lines and be expanded to the currently open file's
" directory.
cmap %/ <C-R>=expand("%:p:h")."/"<CR>
nmap ,e :e <C-R>=expand("%:p:h").'/'<CR><BS>/

" Alt-Backspace is delete word back, like bash/emacs
cmap <M-Backspace> <C-W>

    " Tab through open buffers {
        map <C-Tab> <ESC>:bn<RETURN>
        map <C-S-Tab> <ESC>:bp<RETURN>
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
" }

" TagList Settings {
    let Tlist_Auto_Open=0 " let the tag list open automagically
    let Tlist_Compact_Format = 1 " show small menu
    let Tlist_Ctags_Cmd = 'ctags' " location of ctags
    let Tlist_Enable_Fold_Column = 0 " do show folding tree
    let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
    let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
    let Tlist_Sort_Type = "name" " order by
    let Tlist_Use_Right_Window = 1 " split to the right side of the screen
    let Tlist_WinWidth = 40 " 40 cols wide

    " Language Specifics {
        " just functions and classes please
        let tlist_aspjscript_settings = 'asp;f:function;c:class'
        " just functions and subs please
        let tlist_aspvbs_settings = 'asp;f:function;s:sub'
        " don't show variables in freaking php
        let tlist_php_settings = 'php;c:class;d:constant;f:function'
        " just functions and classes please
        let tlist_vb_settings = 'asp;f:function;c:class'
    " }
" }

set runtimepath+=~/.vim/ultisnips
