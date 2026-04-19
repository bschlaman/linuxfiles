set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua require("main")
lua require("pack")
lua require("remap")
lua require("lsp")
lua require("lsp-langspecific") -- consider importing from within lsp.lua
lua require("plugins.mason")
lua require("plugins.telescope")
lua require("plugins.completion")
lua require("plugins.treesitter")
