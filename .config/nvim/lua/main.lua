
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
	ensure_installed = { "lua_ls", "pyright", },
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
