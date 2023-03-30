autocmd VimEnter * :call Init()
function Init()
	echo ""
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

" enforcing swap directory
set directory=~/.vim/swap//

" tabs or spaces?
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set autoindent

syntax on
set termguicolors

" colorscheme stuff.  colorscheme specific settings should come before 'colorscheme XXX'
" everforest colorscheme
let g:everforest_background = 'hard'
" hybrid_material colorscheme
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
let schemes = ["badwolf", "everforest", "gruvbox-material", "hybrid_material", "badwolf", "monokai", "gruvbox-material", "tender", "anderson", "deus", "gruvbox", "molokai"]
for name in schemes
	if filereadable($HOME.'/.vim/colors/'.name.'.vim')
		execute "colorscheme " . name
		break
	endif
endfor
set background=dark

" Shortcuts
noremap H 0
noremap L $
" noremap J <C-d>zz
" noremap K <C-u>zz

" Avoiding ESC key. o for out
" disabling for now in favor of using C-[
" inoremap <C-o> <Esc>
" vnoremap <C-o> <Esc>
" nnoremap <C-o> <Esc>

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
vnoremap <leader>d "_d
vnoremap <leader>p "_dP
nnoremap <leader>r "_diwP
vnoremap <leader>r "_diwP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
" filename completion
inoremap <C-F> <C-X><C-F>

" Autocomplete brackets
inoremap {<CR> {<CR>}<Esc>O<TAB>

" Resize splits
noremap <C-n> <C-w><
noremap <C-m> <C-w>>
" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Resizing and moving in terminal mode
if has("terminal")
	" TODO: not working - ENTER causes resize
	" tnoremap <C-n> <C-w><
	" tnoremap <C-m> <C-w>>
	tnoremap <C-h> <C-w>h
	tnoremap <C-j> <C-w>j
	tnoremap <C-k> <C-w>k
	tnoremap <C-l> <C-w>l
endif

filetype plugin on
filetype plugin indent on
" Disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" .aliases syntax set
autocmd BufEnter *.aliases set syntax=bash
autocmd BufEnter *.work_aliases set syntax=bash
" in case colorscheme doesn't recognize dockerfiles
autocmd BufEnter *.dockerfile set filetype=dockerfile
" Enforce italicized comments
highlight Comment cterm=italic gui=italic

autocmd FileType python setlocal ts=4 sts=4 sw=4 et
autocmd FileType solidity setlocal ts=4 sts=4 sw=4 et
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 et
autocmd FileType tf setlocal ts=2 sts=2 sw=2 et
autocmd FileType java setlocal ts=4 sts=4 sw=4 et
autocmd FileType rust setlocal ts=4 sts=4 sw=4 et


autocmd FileType html nnoremap <Space><Space> /\[!!\]<Enter>"_d4l
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
autocmd FileType java inoremap <C-s> System.out.println("");<left><left><left>

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

" ==============
" syntax plugins
" ==============

" https://github.com/fatih/vim-go.git
" TODO (2022.10.07): remove those which are defaults
let g:go_fmt_command = "goimports"
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
" vim-python/python-syntax
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0
let g:python_highlight_func_calls = 0

" https://github.com/vim-python/python-syntax.git
highlight link pythonBuiltinFunc Yellow
highlight link javaIdentifier NONE
highlight link javaDelimiter NONE

" autocmd BufWritePre *.py Black
let g:black_preview = "true"

" https://github.com/prettier/vim-prettier
" --quote-props consistent; --use-tabs true (although this seems to be fine already); --arrow-parens avoid
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#quote_props = 'consistent' " had to manually add this to ~/.vim/pack/plugins/start/vim-prettier/autoload/prettier/resolver/config.vim
let g:prettier#config#arrow_parens = 'avoid'

" https://github.com/rust-lang/rust.vim
let g:rustfmt_autosave = 1


" HERE BE DRAGONS

" Shortcuts again because vim-go messes this up
" TODO (2022.10.03): find a better solution
nnoremap H 0
nnoremap L $
" nnoremap J <C-d>zz
" nnoremap K <C-u>zz

" (2022.10.21) testing out vimplug, esp for neovim
" may still need to run :UpdateRemotePlugins after installation!
call plug#begin()
	" pip install pynvim
	Plug 'neovim/nvim-lspconfig'
	" pip install black
	Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
	" pip install isort
	Plug 'stsewd/isort.nvim', {'do': ':UpdateRemotePlugins'}
	Plug 'prettier/vim-prettier'
	Plug 'Glench/Vim-Jinja2-Syntax'
	" Plug 'fatih/vim-go'
	" Plug 'vim-python/python-syntax'
	" Plug 'uiiaoo/java-syntax.vim'
	" Plug 'rust-lang/rust'
	Plug 'hashivim/vim-terraform'
	Plug 'TovarishFin/vim-solidity'
	Plug 'pangloss/vim-javascript'

	Plug 'ellisonleao/gruvbox.nvim'
	Plug 'sjl/badwolf'
	Plug 'nvim-lua/plenary.nvim' " dependency of telescope
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'

	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
call plug#end()

