" vim: set foldmethod=marker foldmarker={,} foldlevel=0 spell:

" Pathogen {
call pathogen#runtime_append_all_bundles() 
filetype off
filetype plugin indent on
" }

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
"helptags ~/.vim/doc " add help searching for user installed packages
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
set nobackup " don't backup files
set noswapfile " don't create swapfiles
set backupdir=~/.vim/backup " where to put backup files
set fileformats=unix,dos,mac " support all three, in this order
set directory=~/.vim/tmp
set hidden " let me open multiple unsaved buffers
set autowrite " autowrite, save the file when calling external commands
set autoread " reload file from disk if it changed before I modified it

" Strip trailing whitespace when I save source files.
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.{h,c,hpp,cpp,cc,hh,rb,sh,erb,feature,html,css,scss,sass,haml} :call <SID>StripTrailingWhitespaces()

" }

" Appearance {
syntax on " syntax highlighting
if has("gui_running")
    colorscheme molokai " syntax highlighting colour scheme
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
set iskeyword+=_,$,@,%,#,? " these are not word dividers
" }

" File types {
filetype plugin indent on
augroup filetypedetect
    au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru} setl filetype=ruby path+=lib
    au BufNewFile,BufRead *.json setl nowrap smartindent
    au BufNewFile,BufRead *.txt setl filetype=text

    au FileType c setl sw=4 sts=4 makeprg=make
    au FileType ruby setl makeprg=rake
    au FileType eruby setl makeprg=rake
    au FileType css setl makeprg=rake
    au FileType text setl textwidth=78
    au FileType aspvbs setl noet ts=4 sw=4 sts=4
    au FileType python setl et ts=4 sw=4 sts=4
    au FileType plaintex setl spell

    au User Rails		Rabbrev! AD
augroup END
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

" use ; instead of : because it is quicker
nnoremap ; :

" Use ;w!! to sudo save a file
cmap w!! w !sudo tee % >/dev/null

" Don't lose highlight
vnoremap < <gv
vnoremap > >gv

" Disable commands I never want to use, in case I hit them accidentally
nmap <F1> <Esc>
imap <F1> <Esc>a

" M-t transposes comma separated arguments using swap_parameters.vim
nmap <M-t> :call SwapParams("forwards")<CR>

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

" :bd does not disturb the split layout
cabbrev bd Kwbd

" :q quits reliably
cabbrev q qall

" :wq writes and quits reliably
cabbrev wq wqall

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne=0

" Textmate-like

imap <C-l> <space>=><space>

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

vmap <D-Bslash> :Align<Bar><CR>gv=gv
nmap <D-Bslash> vii:Align<Bar><CR>gv=

" Rspec (!s and !S) {
function! RunSpec(args)
    if filereadable("script/spec")
        let spec = "script/spec"
    else
        let spec = "spec"
    end 
    call Send_to_Screen(spec." ".expand("%:p").a:args."\n")
endfunction
map !s :call RunSpec(":".line('.'))<CR>
map !S :call RunSpec("")<CR>
" }

" }

" TagList Settings {
let Tlist_Auto_Open=0 " let the tag list open automagically
let Tlist_Compact_Format = 1 " show small menu
let Tlist_Ctags_Cmd = 'tags' " location of ctags
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

" JSLint {

au FileType javascript setl makeprg=jsl\ -nologo\ -nocontext\ -nosummary\ -process\ % errorformat=%f(%l):\ %m

" }
