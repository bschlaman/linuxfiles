
vim.opt.mouse = nil

vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

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

require'lspconfig'.pyright.setup{
	on_attach = on_attach,
}
