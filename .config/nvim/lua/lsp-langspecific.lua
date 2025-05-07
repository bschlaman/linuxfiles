if vim.g.vscode then
	return
end

require("crates").setup{}

require("nvim-web-devicons").setup{}

require("go").setup{
	auto_format = true,
	auto_lint = true,
	linter = 'revive',
	-- formatter: goimports, gofmt, gofumpt, lsp
	-- lint_prompt_style: qf (quickfix), vt (virtual text)
	lint_prompt_style = 'vt',
	formatter = 'goimports',
	-- maintain cursor position after formatting loaded buffer
	maintain_cursor_pos = true,
	-- struct tags
	tags_name = 'json',
	tags_options = {'json=omitempty'},
	tags_transform = 'snakecase',
	tags_flags = {'-skip-unexported'},
	-- quick type
	quick_type_flags = {'--just-types'},
}

