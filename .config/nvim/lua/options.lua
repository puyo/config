require("nvchad.options")

local o = vim.o
o.compatible = false
o.showtabline = 0
o.spelllang = "en_au"
o.expandtab = true
o.linespace = 2
o.shiftwidth = 2
o.wildmode = "list:longest"
o.foldenable = false

vim.cmd([[
" no really, no tabline please
" autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=0

augroup filetypedetect
au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru} setlocal filetype=ruby
au BufNewFile,BufRead {Gemfile,Guardfile} setlocal filetype=ruby
au BufNewFile,BufRead *.txt setlocal filetype=text
au BufNewFile,BufRead *.ejs setlocal filetype=html
au BufNewFile,BufRead *.hamlc setlocal filetype=haml
au BufNewFile,BufRead *.{md,md.erb,markdown.liquid} setlocal filetype=markdown conceallevel=2 | hi mkdCode guibg=NONE
au BufNewFile,BufRead *.as setlocal filetype=javascript
au BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
augroup END

augroup filetypes
au FileType c setlocal sw=4 sts=4 makeprg=make
au FileType ruby setlocal makeprg=rake path+=lib tw=78 ts=2 et sw=2 sts=2
au FileType ruby let b:surround_114 = "do\n\r\nend"
au FileType eruby setlocal makeprg=rake
au FileType css setlocal makeprg=rake
au FileType text setlocal wrap linebreak nolist tw=0 wm=0 spell
au FileType python setlocal et ts=4 sw=4 sts=4
au FileType plaintex setlocal spell
au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist sw=2 tw=0 wm=0 spell
au FileType slim setlocal comments+=b:'
au FileType coffee setlocal ts=2 sw=2 sts=2
au FileType javascript setlocal ts=2 sw=2 sts=2
au FileType typescript setlocal ts=2 sw=2 sts=2
au FileType typescriptreact setlocal ts=2 sw=2 sts=2
au FileType json setlocal nowrap smartindent
augroup END
]])
