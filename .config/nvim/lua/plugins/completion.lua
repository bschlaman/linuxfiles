local cmp = require("cmp")

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "emoji" },
		{ name = "tmux", keyword_length = 4, option = { all_panes = true } },
		{ name = "buffer", keyword_length = 4, option = {
			get_bufnrs = function()
				return vim.api.nvim_list_bufs()
			end
		}},
		{ name = "crates" }, -- crates.nvim
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
				nvim_lua = "[Lua]",
				nvim_lsp = "[LSP]",
				vsnip = "[vsnip]",
				path = "[path]",
				cmdline = "[cmdline]",
				emoji = "[emoji]",
				tmux = "[tmux]",
				buffer = "[Buffer]",
				-- luasnip = "[LuaSnip]",
				-- latex_symbols = "[Latex]",
			})
		}),
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	}
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" }
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" }
			}
		}
	})
})
