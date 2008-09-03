" The code below is to mark-up our Word documents to LaTeX, after they've been
" saved as plain text.
"
" Generally press <F1><F2>...<F11><F11>...<F6> to move down the file
" marking up text.
"
"function codeexample() range
" 	 exec a:firstline . 's/^\(.*\)[ ]*$/\r\\codelabel{\1}\r\\begin{code}'
"	 exec (a:lastline + 2) . 's/$/\r\\end{code}'
"endfunction
"
" For marking up parameter tables
" Use F1, F2 for each parameter and then F3 to finish off
"nmap <F1> dWI\apicall{<ESC>A}<ESC>/^Description\><CR>D/^Parameters\><CR>DjVjjjjjdO\begin{parameters}<ESC>j
"nmap <F2> A &<ESC>JA &<ESC>JA &<ESC>JA &<ESC>JA \\<ESC>j
"nmap <F3> O\end{parameters}<ESC>j 
"nmap <F4> O<CR>\begin{examples}<ESC>
"nmap <F5> ddO\end{examples}<CR><CR>\begin{errors}<ESC>j
"nmap <F6> cc\end{errors}<ESC>j

" For marking up code examples with our LaTeX
"nmap <F11> I\codelabel{<ESC>A}<ESC>o\begin{code}<ESC>/^}<CR>o\end{code}<ESC>j
"vmap <F11> :call CodeExample()<CR>
