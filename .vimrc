set number relativenumber      " Line numbers, relative
set scrolloff=3                " Scroll begins from offset

set showcmd                    " Show latest command
"set cursorline                " Underline current line

set incsearch                  " Search as characters enter
set hlsearch                   " Highlight search

syntax on                      " Enable syntax highlighting
"colorscheme                   " Color scheme in /usr/share/vim/vim81/colors/*.vim

set showmatch                  " Highlight matching [{()}]

set tabstop=4                  " <TAB> visual cols
set softtabstop=4              " <TAB> cols in insert mode 
"set expandtab                 " <TAB> set to softtabstop val
"set autoindent                " <TAB> after <CR>

set wildmenu                   " Autocomplete commands

set mouse-=a

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Highlight last inserted text
nnoremap gI `[v`] 
