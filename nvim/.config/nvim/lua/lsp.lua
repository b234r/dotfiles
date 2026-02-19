vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable({
  "ansiblels",
  "intelephense",
  "lua_ls",
  "vue_ls",
})
vim.diagnostic.config({ virtual_text = true })
