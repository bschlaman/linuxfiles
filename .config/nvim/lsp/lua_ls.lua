-- User overrides for lua_ls. Merged on top of nvim-lspconfig's lsp/lua_ls.lua.

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        preloadFileSize = 10000,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
