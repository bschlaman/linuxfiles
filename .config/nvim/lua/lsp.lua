if vim.g.vscode then
	return
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end
})


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
	automatic_enable = true,
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		-- The installs below will fail if certain dependencies
		-- (e.g. `npm`, `go`) are not present
		-- TODO (2023.10.23): create a command to install these
		-- "pyright",
		-- "gopls",
		-- "ts_ls",
	},
}

require("lspconfig").gopls.setup{ on_attach = on_attach }

require("lspconfig").ts_ls.setup{ on_attach = on_attach }

require("lspconfig").pyright.setup{
	on_attach = on_attach,
}

require("lspconfig").lua_ls.setup{
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				-- library = { vim.env.VIMRUNTIME }, -- this is in the docs, but vim.api.nvim_get_runtime_file returns more
				checkThirdParty = false,
			},
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
