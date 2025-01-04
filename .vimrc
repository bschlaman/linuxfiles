autocmd VimEnter * :call Init()
function Init()
	if exists("g:colors_name")
		echom "using colorscheme: " g:colors_name
	else
		echom "no colorscheme found"
	endif
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
set tabstop=2 " whitespace cols for \t
set softtabstop=2 " whitespace cols for <TAB> or backspace
set shiftwidth=2 " whitespace cols for indentation
set noexpandtab
" Show tabs and special characters in insert mode
" Wanted this to be visual mode, but there is no VisualEnter/Exit event
autocmd InsertEnter * set list
autocmd InsertLeave * set nolist

syntax on
set termguicolors

" Shortcuts
noremap H 0
noremap L $
nnoremap n nzz
nnoremap N Nzz

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Toggle numbers
nnoremap <leader>n :set number! relativenumber!<CR>
" Toggle paste
nnoremap <leader>p :set paste!<CR>
" Toggle color column
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
" Surround visual in quotes (redundant to vim-surround)
vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>`>2l
" split long bash commands into multiple lines
vnoremap <leader>f :s/\s\+-/ \\\r\t-/g<CR>:noh<CR>
" TODO: figure out what this does
nnoremap <leader>f :s/{\zs\([^}]*\)\ze}/\="\r".repeat(" ", &shiftwidth).submatch(1)."\r"/<CR>
nnoremap <C-s> :%s//g<Left><Left>
nnoremap <leader>vr :so ~/.vimrc<CR>

" perform operations without writing to copy register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP
nnoremap <leader>r "_diwP
vnoremap <leader>r "_diwP
" yank to clipboard provider (:h clipboard)
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" code folding (candidate config)
nnoremap zff zf%

" filename completion
inoremap <C-F> <C-X><C-F>
" vim-surround mapping
vmap s S

" TODO: currently not working well; after opening {, cursor indents twice
" this only happens for some filetypes, like .vim and .py
" Autocomplete brackets
inoremap {<CR> {<CR>}<Esc>O

" make a word a tag, in any filetype
nnoremap mt yiwi<<Esc>ea></<Esc>pa><Esc>F<

" Resize splits
noremap <C-m> <C-w><
" noremap <C-n> <C-w>>
" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" terminal-like navigation in insert mode
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

vnoremap < <gv
vnoremap > >gv

" quickfix shortcuts
noremap <C-n> :cn<CR>
noremap <C-p> :cp<CR>

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
" I lose json syntax hl, but vscode will properly indent things
autocmd BufEnter *.ipynb set filetype=jupyter
" Enforce italicized comments (not working - neovim altering this behavior?)
highlight Comment cterm=italic gui=italic

" latex remaps
vnoremap <leader>bf c\textbf{<C-R>"}<ESC>
vnoremap <leader>it c\textit{<C-R>"}<ESC>
vnoremap <leader>tt c\texttt{<C-R>"}<ESC>
vnoremap <leader>bb c\mathbf{<C-R>"}<ESC>
vnoremap <leader>bs c\boldsymbol{<C-R>"}<ESC>
vnoremap <leader>) c\left(<C-R>"\right)<ESC>
" 'q' for quadratic.
" Note that this may conflict with some software for which this shortcut is 'quit program'
nnoremap <C-q> wgea^2<ESC>

autocmd FileType python setlocal ts=4 sts=4 sw=4 et
autocmd FileType jupyter setlocal ts=4 sts=4 sw=4 et " custom FileType
autocmd FileType toml setlocal ts=4 sts=4 sw=4 et
autocmd FileType solidity setlocal ts=4 sts=4 sw=4 et
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 et
autocmd FileType tf setlocal ts=2 sts=2 sw=2 et
autocmd FileType java setlocal ts=4 sts=4 sw=4 et
autocmd FileType rust setlocal ts=4 sts=4 sw=4 et
autocmd FileType tex setlocal ts=4 sts=4 sw=4 et


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
" vnoremap co :call CommentLines()<CR>
" vnoremap cz :call UnCommentLines()<CR>
" vnoremap cx :s#\%V\(.*\)\%V\(.\)#\/*\1\2*\/#g <CR> :nohlsearch <CR>
" vnoremap cu :s#\%V/\*\<Bar>\*/\%V##g <CR> :nohlsearch <CR>

" autocmd BufWritePre *.py Black
let g:black_preview = "true"

" g:python3_host_prog configures the python executable
" that loads and runs plugins written in python (like Black and Isort).
" This only really matters to import pynvim;
" it has nothing to do with pyright via Mason.
" It's useful to set as absolute path '/usr/bin/python' if I am in a virtualenv
" so that I can just use my global installation of pynvim.
let g:python3_host_prog = '/usr/bin/python'
" allow for overriding this value (useful when /usr/bin/python is python2)
if !empty(getenv('PYTHON3_HOST_PROG_OVERRIDE'))
  let g:python3_host_prog = getenv('PYTHON3_HOST_PROG_OVERRIDE')
endif

" https://github.com/prettier/vim-prettier
" --quote-props consistent; --use-tabs true (although this seems to be fine already); --arrow-parens avoid
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#quote_props = 'consistent' " had to manually add this to ~/.vim/pack/plugins/start/vim-prettier/autoload/prettier/resolver/config.vim
let g:prettier#config#arrow_parens = 'avoid'

" https://github.com/rust-lang/rust.vim
let g:rustfmt_autosave = 1


" HERE BE DRAGONS

" (2022.10.21) testing out vimplug, esp for neovim
" may still need to run :UpdateRemotePlugins after installation!
call plug#begin()
	" pip install pynvim
	Plug 'neovim/nvim-lspconfig'
	" pip install black
	Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
	" pip install isort
	Plug 'stsewd/isort.nvim', {'do': ':UpdateRemotePlugins'}

	" various
	Plug 'prettier/vim-prettier'
	Plug 'crispgm/nvim-go'
	Plug 'Saecki/crates.nvim'
	Plug 'tpope/vim-surround'

	" colorschemes
	Plug 'sainnhe/gruvbox-material'
	Plug 'ellisonleao/gruvbox.nvim'
	Plug 'sainnhe/everforest'
	Plug 'sjl/badwolf'
	Plug 'aktersnurra/no-clown-fiesta.nvim'

	" neovim lsp stuff
	Plug 'nvim-lua/plenary.nvim' " dependency of telescope
	Plug 'nvim-tree/nvim-web-devicons' " optional dependency of telescope; requires a nerd font
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'onsails/lspkind.nvim'
	Plug 'lvimuser/lsp-inlayhints.nvim'

	" nvim-cmp
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-nvim-lua'
	Plug 'andersevenrud/cmp-tmux'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-emoji'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/nvim-cmp'
call plug#end()

" Some colorschemes are loaded via plugin, so must be set after call plug#end()
" Colorscheme specific settings should come before 'colorscheme XXX'
" Below variables are settings for gruvbox, everforest, gruvbox_material, and hybrid_material
let g:gruvbox_italic = 1 " gruvbox
set bg=dark " gruvbox
let g:everforest_background = 'hard'
let g:gruvbox_material_background = 'hard'
let g:hybrid_transparent_background = 1
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let schemes = [
	\ "gruvbox-material",
	\ "everforest",
	\ "anderson",
	\ "badwolf",
	\ "gruvbox",
	\ "hybrid_material",
	\ "monokai",
	\ "tender",
	\ "deus",
	\ ]

" 1) if there is an override, set it
" note that running colorscheme more than once can cause weird behavior
if !empty(getenv('VIM_COLORSCHEME_OVERRIDE'))
	execute 'colorscheme ' getenv('VIM_COLORSCHEME_OVERRIDE')
else
	" 2) else, look for some common color schemes I like
	for name in schemes
		try
			execute 'colorscheme ' name
			break
		catch
		endtry
	endfor
end

" Enforce italicized comments (must come after colorscheme is loaded)
highlight Comment cterm=italic gui=italic

" DEPRECATED

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

" not needed with nvim lsp / treesitter
" Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'fatih/vim-go'
" Plug 'vim-python/python-syntax'
" Plug 'uiiaoo/java-syntax.vim'
" Plug 'rust-lang/rust'
" Plug 'hashivim/vim-terraform'
" Plug 'TovarishFin/vim-solidity'
" Plug 'pangloss/vim-javascript'

" ==============
" syntax plugins
" ==============

" https://github.com/fatih/vim-go.git
" TODO (2022.10.07): remove those which are defaults
" let g:go_fmt_command = "goimports"
" let g:go_highlight_array_whitespace_error = 1
" let g:go_highlight_chan_whitespace_error = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_space_tab_error = 0
" let g:go_highlight_trailing_whitespace_error = 0
" let g:go_highlight_operators = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_string_spellcheck = 1
" let g:go_highlight_format_strings = 1
" let g:go_highlight_diagnostic_errors = 1
" let g:go_highlight_diagnostic_warnings = 1
" vim-python/python-syntax
" let g:python_highlight_all = 1
" let g:python_highlight_space_errors = 0
" let g:python_highlight_func_calls = 0

" https://github.com/vim-python/python-syntax.git
" I don't think these are working
" highlight link pythonBuiltinFunc Yellow
" highlight link javaIdentifier NONE
" highlight link javaDelimiter NONE
