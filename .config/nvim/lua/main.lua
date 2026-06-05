vim.opt.mouse = ""

-- vscode
if vim.g.vscode then
	vim.cmd("syntax off")
	vim.g.clipboard = vim.g.vscode_clipboard
	vim.o.cmdheight = 100 -- required for neovim-0.11+
end
