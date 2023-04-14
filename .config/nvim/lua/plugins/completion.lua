local cmp = require("cmp")

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
	sources = cmp.config.sources({
		-- { name = "nvim_lua" },
		-- { name = "nvim_lsp" },
		{ name = "path" },
		-- { name = "cmdline" },
		-- { name = "emoji" },
		-- { name = "tmux", option = { all_panes = false } },
		-- { name = "buffer", keyword_length = 4, option = {
		-- 	get_bufnrs = function()
		-- 		return vim.api.nvim_list_bufs()
		-- 	end
		-- }},
	}),
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- { select = true }: automatically select first item
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = require("lspkind").cmp_format({
			menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			})
		}),
	},
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	}
})
