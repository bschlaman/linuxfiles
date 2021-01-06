autocmd VimEnter * :call Init()
function Init()
	echo ""
	echon "Welcome! >^.^< | "
	echon "using colorscheme: "
	echon g:colors_name
endfunction

" the basics
set number relativenumber
set scrolloff=3
set showcmd
set hlsearch
set showmatch
set ignorecase
set wildmenu
set splitright splitbelow

" tabs or spaces?
set tabstop=2
set softtabstop=2
set noexpandtab
set autoindent

syntax on
let schemes = ["deus", "gruvbox", "molokai"]
for name in schemes
	if filereadable($HOME.'/.vim/colors/'.name.'.vim')
		execute "colorscheme " . name
		break
	endif
endfor
set background=dark

" Shortcuts
nnoremap H 0
nnoremap L $
nnoremap J <C-F>
nnoremap K <C-B>

" Avoiding ESC key. o for out
inoremap <C-o> <Esc>
vnoremap <C-o> <Esc>
nnoremap <C-o> <Esc>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Toggle numbers
nnoremap <leader>n :set number! relativenumber!<CR>
" Toggle paste
nnoremap <leader>p :set paste!<CR>
" Surround visual in quotes
vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>`>2l
nnoremap <C-s> :%s//g<Left><Left>
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>r "_diwP
xnoremap <leader>r "_diwP

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
" .aliases syntax set
autocmd BufNewFile,BufRead *.aliases set syntax=bash

autocmd FileType python setlocal tabstop=4 softtabstop=4 expandtab
autocmd FileType java inoremap <C-@> System.out.println("");<left><left><left>

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
