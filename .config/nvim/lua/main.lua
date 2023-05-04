
vim.opt.mouse = nil

vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = 'rounded',
				source = 'always',
				prefix = ' ',
				-- want to trigger if cursor is anywhere on the line
				-- scope = 'cursor',
			}
			vim.diagnostic.open_float(nil, opts)
		end
	})

	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'T', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "pyright", "gopls", },
}

require("lspconfig").lua_ls.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			diagnostics = { globals = { "vim" } },
			telemetry = {
				enable = false,
			},
		},
	},
}

require("go").setup({
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

})

require("lspconfig").gopls.setup {}

require("lspconfig").pyright.setup {
	on_attach = on_attach,
}

require("lspconfig").rust_analyzer.setup{
	on_attach = on_attach,
	cmd = {
			"rustup", "run", "stable", "rust-analyzer",
	}
}
