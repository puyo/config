if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

" helper functions
function! EventConstant(s)
return split(a:s,'\.')[0]
endfunction

exec "Snippet priv private function ".st."function".et."(".st.et."):".st."void".et."{<CR>".st.et."<CR>}"
exec "Snippet pub public function ".st."function".et."(".st.et."):".st."void".et."{<CR>".st.et."<CR>}"

" loops
exec "Snippet fe for each(var ".st.et.":".st.et." in ".st.et."){<CR>".st.et."<CR>}"
exec "Snippet fi for(var ".st."key".et.":".st."String".et." in ".st.et."){<CR>".st.et."<CR>}"

" events
exec "Snippet al addEventListener(".st."event".et.", function(e:".st."event:EventConstant(@z)".et."):void{<CR>".st.et."<CR>});"

" Logging
exec "Snippet d Log.debug(".st.et.");"
exec "Snippet err Log.error(".st.et.");"
exec "Snippet o2 Log.object2String(".st.et.")"

" tilefile
exec "Snippet req var req:".st."request".et." = Service.instance.new".st."request".et."();<CR>req.addEventListener(ServiceEvent.SUCCESS, success);<CR>req.addEventListener(ServiceEvent.ERROR, failure);<CR>function success(event:ServiceEvent):void{<CR>".st.et."<CR>}<CR>function failure(event:ServiceEvent):void{<CR><CR>}<CR>"
exec "Snippet class // Copyright (C) 2007 TILEFILE Ltd. All rights reserved.<CR><CR>package tf.".st."\"enclosing_package\"".et."{<CR><CR>import tf.common.logging.Log;<CR><CR>public class ".st."\"enclosing_type\"".et."{<CR><CR>//==================================================================<CR>// PUBLIC PROPERTIES<CR><CR><CR>//==================================================================<CR>// PROTECTED PROPERTIES<CR><CR><CR>//==================================================================<CR>// PRIVATE PROPERTIES<CR><CR><CR>//==================================================================<CR>// CONSTRUCTOR<CR><CR>public function ".st."\"enclosing_type\"".et."(){<CR>".st.et."<CR>}<CR><CR>//================================================================== <CR>// PUBLIC METHODS<CR><CR><CR>//==================================================================<CR>// PROTECED METHODS<CR><CR><CR>//==================================================================<CR>// PRIVATE METHODS<CR><CR><CR>//==================================================================<CR>// EVENT HANDLERS<CR><CR><CR>//==================================================================<CR>// SET METHODS<CR><CR><CR>//==================================================================<CR>// GET METHODS<CR><CR>}<CR>}<CR>"


" ----------------------------------------------------------------------------
" PRETTY up snippetsEmu

function! HighlightSnips()
exec "hi snippetEmuJump guibg=grey30"
exec "syn region snippetEmuJump start=/".g:snip_start_tag."/ end=/".g:snip_end_tag."/"
endfunction

au BufNewFile,BufRead * call HighlightSnips() 
