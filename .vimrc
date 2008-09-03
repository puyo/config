" Greg McIntyre

" Use Vim settings, rather then Vi settings. This must be first, because it
" changes other options as a side effect.
set nocompatible

set backspace=indent,eol,start " allow backspacing over everything
set wildmode=list:longest      " bash-like tab completion
set hidden                     " let me open multiple unsaved buffers
set incsearch                  " highlight search matches as I type the search query
set nohlsearch                 " don't highlight the last sesarh, I find it distracting
set showmatch                  " parens matching (like Emacs paren blink)
set nojoinspaces               " only insert one space when joining sentences
set history=100                " keep this many lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set noerrorbells               " no error bells
set visualbell t_vb=           " no beeps or blinks
set tabstop=4                  " tab size (how many characters wide tabs are)
set shiftwidth=4               " general purpose indent/unindent size
set autowrite                  " autowrite, save the file when calling external commands
set scrolloff=1                " number of lines to show above and below the cursor
set guifont=Monospace\ 9       " gvim font
set guioptions-=T              " turn off useless toolbar
set guioptions+=c              " use console rather than GUI dialog boxes
set guioptions-=m              " turn off the menu
set directory=~/.vim/tmp       " where temporary files will go
set backupdir=~/.vim/backups   " where backup files will go to die
set nobackup                   " turn off backups, they only ever get in my way
set noswapfile                 " turn off swapfiles, they're annoying
set number                     " show line numbers on the left
set nowrap                     " don't wrap the display of lines

let g:rubycomplete_rails=1
let g:closetag_html_style=1

" Enable file type detection with settings for each mode and auto-indenting
" rules.
filetype plugin indent on

augroup filetypedetect
    " Set some modes based on file extension
    au BufNewFile,BufRead *.rb,*.rjs,*.rbw,*.gem,*.gemspec setlocal filetype=ruby
    au BufNewFile,BufRead *.as setlocal filetype=actionscript
    au BufNewFile,BufRead *.mxml setlocal filetype=xml
    au BufNewFile,BufRead *.wiki setlocal filetype=Wikipedia
    au BufNewFile,BufRead *.json setlocal nowrap sw=4 ts=4 sts=0 noet smartindent number

    " Mode specific settings.
    au FileType ruby setlocal et ts=2 sw=2 softtabstop=2 omnifunc=rubycomplete#Complete
    au FileType eruby setlocal et ts=2 sw=2 softtabstop=2
    au FileType css setlocal et ts=2 sw=2 softtabstop=2
    au FileType actionscript setlocal nowrap sw=4 ts=4 sts=0 noet smartindent efm=%f(%l):\ col:\ %c\ Error:\ %m
    au FileType text setlocal textwidth=78 nonumber
    au FileType html,xml setlocal spell nonumber
    au FileType html,xml source ~/.vim/scripts/closetag.vim
    au FileType cpp,c setlocal makeprg=make ts=4 sw=4 sts=4 et
    au FileType plaintex setlocal spell
    au FileType python setlocal ts=4 sw=4 sts=4 et

    " TextMate style snippets for Actionscript.
    au FileType actionscript exec "Snippet for for(var <{i}>:<{uint}> = <{0}>; <{i}> <= <{array}>.length; <{i}>++){\n<{}>\n}"
    au FileType actionscript exec "Snippet foreach for each(var <{name}>:<{String}> in <{collection}>){\n<{}>\n}"
    au FileType actionscript exec "Snippet if if(<{}>){\n<{}>\n}"
    au FileType actionscript exec "Snippet else else{\n<{}>\n}"
    au FileType actionscript exec "Snippet new var <{name}>:<{Class}> = new <{Class}>(<{}>);"
    au FileType actionscript exec "Snippet var var <{name}>:<{Class}>;\n<{}>"
    au FileType actionscript exec "Snippet class var <{name}>:<{Class}>;\n<{}>"
    au FileType actionscript exec "Snippet listener <{x}>.addEventListener(<{EventClass}>.<{eventConst}>, handle<{eventType}>, false, 0, true);\n\nfunction handle<{eventType}>(event:<{EventClass}>):void{\n<{}>\n}"
    au FileType actionscript exec "Snippet package package <{name}>{\n<{}>\n}"
    au FileType actionscript exec "Snippet class public class <{name}>{\npublic function <{name}>(){\n<{}>\n}\n}"
    au FileType actionscript exec "Snippet function <{public}> function <{name}>():<{void}>{\n<{}>\n}"
augroup END

" Colour, syntax highlighting.
colorscheme slate2
syntax enable

" Add help searching for user installed packages.
helptags ~/.vim/doc

" Most recently used file list. Alt-R
noremap <M-r> :MRU<CR>
inoremap <M-r> <C-O>:MRU<CR>

" Show diff of current buffer. Alt-M
noremap <M-d> :!tkdiff %<CR>

" Compilation.
nmap <F9> :make<CR><CR><CR>:copen<CR><C-W><C-W>k
nmap <F10> :cnext<CR>
nmap <F11> :cprev<CR>

" Navigation. F12 opens a sidebar with hotlinks to code definitions.
nmap <F12> :TlistToggle<CR>

" I use rake more often than make.
set makeprg=rake

" Allow %/ to be put in :e lines and be expanded to the currently open file's
" directory.
cmap %/ <C-R>=expand("%:p:h")."/"<CR>

" ,e is like :e except it starts with the directory of the file currently
" being edited. Works like Emacs <C-x C-f>.
nmap ,e :e <C-R>=expand("%:p:h")."/"<CR>

" Eclipse style moving of lines - e.g. Vjjj<M-j>
imap <M-j> <Esc>:m+<CR>gi
imap <M-k> <Esc>:m-2<CR>gi
vmap <M-j> :m'>+<CR>gv
vmap <M-k> :m'<-2<CR>gv
vmap <M-h> :<<CR>gv
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-l> :><CR>gv

" Emacs flavoured command line editing.
cnoremap <M-BS> <C-W>
cnoremap <C-A> <Home>

" Rebuild tags file
nmap <M-C> :!ctags -R .

