if vim.g.vscode then
  return
end

-- =============================================================================
-- Diagnostics (global)
-- =============================================================================
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true, -- replaces the deprecated string 'always'
  },
})

-- Auto-open the diagnostic float on CursorHold.
-- Trigger speed is controlled by `:set updatetime` (default 4000ms).
vim.api.nvim_create_autocmd('CursorHold', {
  group = vim.api.nvim_create_augroup('UserDiagnosticHover', {}),
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('*', {
	root_markers = { '.git' },
	capabilities = {
		textDocument = {
	  		semanticTokens = {
				multilineTokenSupport = true,
	  		}
		}
	}
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.remap', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.cmp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Document highlight requirements
--   server:      `textDocument/documentHighlight`
--   colorscheme: LspReferenceText / LspReferenceRead / LspReferenceWrite
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.document_highlight', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not client:supports_method('textDocument/documentHighlight') then
      return
    end

    local hl_group = vim.api.nvim_create_augroup('my.lsp.document_highlight.buf', { clear = false })
    -- Clear any prior autocmds for this buffer in case multiple clients attach.
    vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = hl_group })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = hl_group,
      buffer = ev.buf,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = hl_group,
      buffer = ev.buf,
      callback = vim.lsp.buf.clear_references,
    })
  end,
})


-- =============================================================================
-- Enable language servers
-- =============================================================================
vim.lsp.enable({
  'lua_ls',
  'pyright',
  'ts_ls',
})
