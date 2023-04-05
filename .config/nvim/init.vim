set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua require("main")
lua require("remap")
lua require("lsp")
lua require("plugins.telescope")
lua require("plugins.completion")
lua require("plugins.treesitter")
nnoremap <buffer><silent> <leader>b <cmd>call Black()<cr>
nnoremap <buffer><silent> <leader>i <cmd>Isort<cr>
" let g:black#settings = {
"     \ 'line_length': 100
" \}
