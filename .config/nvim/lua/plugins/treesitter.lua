require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"vim",
		"vimdoc",
		"lua",
		"query",
		"bash",
		"c",
		"python",
		"html",
		"css",
		"go",
		"gomod",
		"gosum",
		"javascript",
		"java",
		"jq",
		"json",
		"json5",
		"ini",
		"terraform",
		"typescript",
		"yaml",
		"rust",
	},
	auto_install = false,
	highlight = {
		-- workaround for vscode-neovim highlighting getting weird
		-- when treesitter highlight is enabled
		enable = vim.g.vscode and false or true,
		additional_vim_regex_highlighting = false,
	},
}

-- 0: globally
vim.api.nvim_set_hl(0, "Identifier", { fg = "LightGray" })
