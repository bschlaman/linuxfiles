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
set expandtab                  " <TAB> set to softtabstop val
set autoindent                 " <TAB> after <CR>

set wildmenu                   " Autocomplete commands
set splitright splitbelow      " Splits appear right, down
set mouse-=a

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Highlight last inserted text
nnoremap gI `[v`]
nnoremap <C-s> :%s//g<Left><Left>

" Autocomplete brackets
"inoremap {<CR> {<CR>}<C-o>O
"inoremap ( ()<C-o>i
"inoremap [ []<C-o>i

nnoremap <Space><Space> <Esc>/\[!!\]<Enter>"_c4l

" Resize splits
map <C-n> <C-w><
map <C-m> <C-w>>
" Move between splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

filetype plugin on

autocmd FileType java inoremap <C-@> System.out.println("");<left><left><left>
autocmd FileType html inoremap ;h1 <h1></h1>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;h2 <h2></h2>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;h3 <h3></h3>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;i <em></em>[!!]<Esc>FeT>i
autocmd FileType html inoremap ;b <strong></strong>[!!]<Esc>FsT>i
autocmd FileType html inoremap ;d <div><CR><CR></div><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;p <p></p>[!!]<Esc>FpT>i
autocmd FileType html inoremap ;ul <ul><CR><CR></ul><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;li <li></li>[!!]<Esc>FlT>i
autocmd FileType html inoremap ;a <a<Space>href="">[!!]</a><Space>[!!]<Esc>14hi
autocmd FileType html inoremap ;sup <sup></sup>[!!]<Esc>FsT>i
