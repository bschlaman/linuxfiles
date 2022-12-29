set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua require('main')
nnoremap <buffer><silent> <leader>f <cmd>call Black()<cr>
nnoremap <buffer><silent> <leader>i <cmd>Isort<cr>
" let g:black#settings = {
"     \ 'line_length': 100
" \}
