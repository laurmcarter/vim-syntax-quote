
source $HOME/.vim/after/syntax/haskell/functions.vim

" insert LANGUAGE pragma
nnoremap <leader>l i{-# LANGUAGE  #-}<esc>3hi

" insert pragma
nnoremap <leader>P i{-#  #-}<esc>3hi

" copy function name from type sig onto next line
nnoremap <leader>u :call FillDef("= undefined")<cr>
" :call NearbyDefLine()<cr>^yawo<esc>PA= undefined<esc>o<cr>

" copy function name from type sig onto next line
nnoremap <leader>f ^yawo<esc>PA

" comment out a paragraph
nnoremap <leader>c {o{-<esc>}O-}<esc>
" uncomment a paragraph
nnoremap <leader>C {jdd}kdd

" import directive
nnoremap <leader>i Oimport 

" import qualified directive
nnoremap <leader>q Oimport qualified 

" std deriving
" nnoremap <leader>d A deriving (Eq,Show)<esc>j

" comment block top
nnoremap <leader>bC O{-<esc>

" comment block bottom
nnoremap <leader>bc o-}<esc>

" toggle char under cursor between '.' and '$'
nnoremap <leader>. :call SwitchApp()<cr>

" flip two expressions in a comma separated group
"   closed in braces, brackets, or parens
nnoremap <leader>p :call FlipInGroup("{[(", "}])", ",")<cr>

" add fold section
nnoremap <leader>s i-- }}}<esc>O<cr><cr><cr><esc>3ki--  {{{<esc>3hi

nnoremap <leader>d :call ImportQualData()<cr>

