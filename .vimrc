autocmd VimEnter * echo "Welcome! >^.^<"
set number relativenumber      " Line numbers, relative
set scrolloff=3                " Scroll begins from offset
set showcmd                    " Show latest command

set hlsearch                   " Highlight search
"set incsearch                 " Search as characters enter

syntax on                      " Enable syntax highlighting
colorscheme deus               " Color scheme in /usr/share/vim/vim81/colors/*.vim

set showmatch                  " Highlight matching [{()}]

set tabstop=4                  " <TAB> visual cols
set softtabstop=4              " <TAB> cols in insert mode 
set expandtab                  " <TAB> set to softtabstop val
set autoindent                 " <TAB> after <CR>
"set paste                      " Indentation preserved in paste
set ignorecase                 " Auto \c on searches.  Use \C for case-sensitive

set wildmenu                   " Autocomplete commands
set splitright splitbelow      " Splits appear right, down

" Shortcuts
nnoremap H 0
nnoremap L $
nnoremap J <C-F>
nnoremap K <C-B>

" Avoiding ESC key. o for out
inoremap <C-o> <Esc>
vnoremap <C-o> <Esc>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Toggle numbers
nnoremap <leader>n :set number! relativenumber!<CR>
" Surround visual in quotes
vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>`>2l
nnoremap <C-s> :%s//g<Left><Left>

" Autocomplete brackets
inoremap {<CR> {<CR>}<C-o>O<TAB>
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
" Disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType java inoremap <C-@> System.out.println("");<left><left><left>
autocmd FileType java,css,javascript,c,h inoremap {<CR> {<CR>}<C-o>O<TAB>
autocmd FileType html inoremap ;h1 <h1></h1>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;h2 <h2></h2>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;h3 <h3></h3>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;em <em></em>[!!]<Esc>FeT>i
autocmd FileType html inoremap ;b <strong></strong>[!!]<Esc>FsT>i
autocmd FileType html inoremap ;d <div><CR><CR></div><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;p <p></p>[!!]<Esc>FpT>i
autocmd FileType html inoremap ;ul <ul><CR><CR></ul><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;ol <ol><CR><CR></ol><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;li <li></li>[!!]<Esc>FlT>i
autocmd FileType html inoremap ;a <a<Space>href="">[!!]</a>[!!]<Esc>13hi
autocmd FileType html inoremap ;sup <sup></sup>[!!]<Esc>FsT>i
autocmd FileType html inoremap ;sub <sub></sub>[!!]<Esc>FsT>i

autocmd FileType html let Comment="<!-- " | let EndComment=" -->"
autocmd FileType css let Comment="/* " | let EndComment=" */"

function! MakeListItem()
    normal! mm0i<li>A</li>`m
endfunction
nnoremap <leader>l :call MakeListItem()<CR>

function CommentLines()
  exe ":s@^@".g:Comment."@g"
  exe ":s@$@".g:EndComment."@g"
endfunction
" map visual mode keycombo 'co' to this function
vmap co :call CommentLines()<CR>
