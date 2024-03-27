vim.opt.mouse = nil

-- vscode
if vim.g.vscode then
	vim.cmd("syntax off")
	vim.g.clipboard = vim.g.vscode_clipboard
else
	-- vscode-neovim recommends not overriding these
	-- 0: globally
	-- (Is this even working?  "Identifier" doesn't seem to match anything, at least for python)
	vim.api.nvim_set_hl(0, "Identifier", { fg = "LightGray" })
end

local on_attach = function(client, bufnr)
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
end

require("mason").setup{}
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		-- The installs below will fail if certain dependencies
		-- (e.g. `npm`, `go`) are not present
		-- TODO (2023.10.23): create a command to install these
		-- "pyright",
		-- "gopls",
		-- "tsserver",
	},
}

-- TODO: currently not working
require("lsp-inlayhints").setup {
	on_attach = on_attach,
}

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

require("lspconfig").gopls.setup{ on_attach = on_attach }

require("lspconfig").tsserver.setup{ on_attach = on_attach }

require("lspconfig").pyright.setup{
	on_attach = on_attach,
}

require("lspconfig").lua_ls.setup{
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

require("lspconfig").rust_analyzer.setup{
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
		},
	},
	cmd = {
		"rustup", "run", "stable", "rust-analyzer",
	}
}

require("crates").setup{}

require("nvim-web-devicons").setup{}
