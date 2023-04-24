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
	},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

-- 0: globally
vim.api.nvim_set_hl(0, "Identifier", { fg = "LightGray" })
