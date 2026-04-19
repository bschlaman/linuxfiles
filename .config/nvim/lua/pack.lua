vim.pack.add({
	-- formatting
	"https://github.com/tpope/vim-surround",

	-- colorschemes
	"https://github.com/Mofiqul/dracula.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/aktersnurra/no-clown-fiesta.nvim",

	-- language/lsp
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason.nvim",
	-- TODO: understand how these work before enabling
	-- "https://github.com/crispgm/nvim-go",
	-- "https://github.com/Saecki/crates.nvim",

	-- telescope
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope.nvim",

	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- completion (nvim-cmp)
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-nvim-lua",
	"https://github.com/andersevenrud/cmp-tmux",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-emoji",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/cmp-vsnip",
	"https://github.com/hrsh7th/nvim-cmp",
})
