
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

require("lspconfig").pyright.setup{
	on_attach = on_attach,
}

require("lspconfig").rust_analyzer.setup{
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
			"rustup", "run", "stable", "rust-analyzer",
	}
}
