set number relativenumber      " Line numbers, relative
set scrolloff=3                " Scroll begins from offset

set showcmd                    " Show latest command

set hlsearch                   " Highlight search
"set incsearch                 " Search as characters enter

syntax on                      " Enable syntax highlighting
colorscheme ron                " Color scheme in /usr/share/vim/vim81/colors/*.vim

set showmatch                  " Highlight matching [{()}]

set tabstop=4                  " <TAB> visual cols
set softtabstop=4              " <TAB> cols in insert mode 
"set expandtab                 " <TAB> set to softtabstop val
set autoindent                 " <TAB> after <CR>

set wildmenu                   " Autocomplete commands
set splitright splitbelow      " Splits appear right, down
set mouse-=a

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Highlight last inserted text
nnoremap gI `[v`]

" Autocomplete brackets
"inoremap {<CR> {<CR>}<C-o>O
"inoremap ( ()<C-o>i
"inoremap [ []<C-o>i

" Quick java shortcut (make file specific)
inoremap <C-@> System.out.println("");<left><left><left>

" Resize splits
map <C-n> <C-w><
map <C-m> <C-w>>
" Move between splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

