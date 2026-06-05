set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua require("main")
lua require("pack")
lua require("remap")
lua require("plugins.mason")
lua require("plugins.devicons")
lua require("plugins.telescope")
lua require("plugins.completion")
lua require("plugins.treesitter")
" Load LSP last so nvim-lspconfig's lsp/<server>.lua files are on the
" runtimepath when vim.lsp.enable() runs.
lua require("lsp")
