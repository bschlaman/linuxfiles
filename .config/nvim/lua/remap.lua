vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

local format = require("format")

vim.keymap.set("v", "<leader>l", function()
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  format.format_latex()
end, { desc = "Format LaTeX (substitutions)" })
