local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>gg', function()
	builtin.grep_string({ search = vim.fn.input("grep > ") });
end)

local function close_buffer(prompt_bufnr)
	local curr_picker = actions_state.get_current_picker(prompt_bufnr)
	local entry = actions_state.get_selected_entry()
	vim.cmd('bdelete ' .. entry.bufnr)
	curr_picker:delete_selection(function(selection) return selection.bufnr == entry.bufnr end)
end

require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				["<C-s>"] = actions.select_horizontal,
				["<C-d>"] = close_buffer,
			},
			n = {
				["<C-s>"] = actions.select_horizontal,
				["<C-d>"] = close_buffer,
			},
		},
	},
}
