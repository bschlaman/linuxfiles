autocmd VimEnter * :call Init()
function Init()
	echo ""
	echon "Welcome! >^.^< | "
	echon "using colorscheme: "
	echon g:colors_name
endfunction

" avoid 'Hit ENTER' message upon startup
" set cmdheight=2

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
let schemes = ["badwolf", "monokai", "tender", "anderson", "deus", "gruvbox", "molokai"]
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
inoremap <C-@> <Esc>
vnoremap <C-@> <Esc>
nnoremap <C-@> <Esc>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Toggle numbers
nnoremap <leader>n :set number! relativenumber!<CR>
" Toggle paste
nnoremap <leader>p :set paste!<CR>
" Surround visual in quotes
vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>`>2l
nnoremap <C-s> :%s//g<Left><Left>
nnoremap vr :so ~/.vimrc<CR>
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>r "_diwP
xnoremap <leader>r "_diwP

" Autocomplete brackets
inoremap {<CR> {<CR>}<C-o>O<TAB>
"inoremap ( ()<C-o>i
"inoremap [ []<C-o>i

nnoremap <Space><Space> /\[!!\]<Enter>"_d4l

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
" in case colorscheme doesn't recognize dockerfiles
autocmd BufEnter *.dockerfile set filetype=dockerfile

autocmd FileType python setlocal tabstop=4 softtabstop=4 expandtab
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 expandtab
autocmd FileType tf setlocal tabstop=2 softtabstop=2 expandtab
autocmd FileType java inoremap <C-@> System.out.println("");<left><left><left>

autocmd FileType html nnoremap <leader>ac F<wwi<Space>class=""<Esc>i
autocmd FileType html inoremap ;h1 <h1></h1>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;h2 <h2></h2>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;h3 <h3></h3>[!!]<Esc>FhT>i
autocmd FileType html inoremap ;em <em></em>[!!]<Esc>FeT>i
autocmd FileType html inoremap ;b <strong></strong>[!!]<Esc>FsT>i
autocmd FileType html inoremap ;d <div>[!!]<CR></div><Esc>kTv
autocmd FileType html inoremap ;cd <div class="">[!!]<CR></div><Esc>kci"
autocmd FileType html inoremap ;p <p></p>[!!]<Esc>FpT>i
autocmd FileType html inoremap ;ul <ul><CR><CR></ul><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;ol <ol><CR><CR></ol><CR>[!!]<Esc>2ki
autocmd FileType html inoremap ;a <a<Space>href="" target="_blank">[!!]</a>[!!]<Esc>29hi
autocmd FileType html inoremap ;sup <sup></sup>[!!]<Esc>FsT>i
autocmd FileType html inoremap ;sub <sub></sub>[!!]<Esc>FsT>i

function! MakeListItem()
	normal! mm^i<li>A</li>`m
endfunction
nnoremap <leader>l :call MakeListItem()<CR>

autocmd FileType html let Comment="<!--" | let EndComment="-->"
autocmd FileType css let Comment="/*" | let EndComment="*/"

function CommentLines()
	exe ":s#\\%V\\(.*\\)\\%V\\(.\\)#".g:Comment."\\1\\2".g:EndComment."#g"
endfunction
" not working right now
" function UnCommentLines()
" 	exe ":s#\\%V".g:Comment."\\<Bar>".g:EndComment."\\%V##g"
" endfunction
" map visual mode keycombo 'co' to this function
vnoremap co :call CommentLines()<CR>
" vnoremap cz :call UnCommentLines()<CR>
" vnoremap cx :s#\%V\(.*\)\%V\(.\)#\/*\1\2*\/#g <CR> :nohlsearch <CR>
vnoremap cu :s#\%V/\*\<Bar>\*/\%V##g <CR> :nohlsearch <CR>

" make a word a tag, in any filetype
nnoremap mt yiwi<<Esc>ea></<Esc>pa><Esc>F<

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 0
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 0
let g:go_highlight_generate_tags = 0
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
" Shortcuts again because vim-go messes this up
nnoremap H 0
nnoremap L $
nnoremap J <C-F>
nnoremap K <C-B>
