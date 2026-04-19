vim.opt.mouse = ""

-- vscode
if vim.g.vscode then
	vim.cmd("syntax off")
	vim.g.clipboard = vim.g.vscode_clipboard
	vim.o.cmdheight = 4 -- required for neovim-0.11+
else
	-- vscode-neovim recommends not overriding these
	-- 0: globally
	-- (Is this even working?  "Identifier" doesn't seem to match anything, at least for python)
	-- vim.api.nvim_set_hl(0, "Identifier", { fg = "LightGray" })
end
