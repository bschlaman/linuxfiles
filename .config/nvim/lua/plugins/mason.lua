require("mason").setup{}

-- mason-lspconfig no longer really required due to vim.lsp.config in Neovim 0.11
-- require("mason-lspconfig").setup {
-- 	automatic_enable = true,
-- 	ensure_installed = {
-- 		"lua_ls",
-- 		"rust_analyzer",
-- 		-- The installs below will fail if certain dependencies
-- 		-- (e.g. `npm`, `go`) are not present
-- 		-- TODO (2023.10.23): create a command to install these
-- 		-- "pyright",
-- 		-- "gopls",
-- 		-- "ts_ls",
-- 	},
-- }

