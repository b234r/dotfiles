-----------------------------------------------------------------------------------------------------------------------
--- Snacks
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})

require('snacks').setup({
  picker = { enabled = true },
})

-----------------------------------------------------------------------------------------------------------------------
--- Which Key
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})

require('which-key').setup({
  icons = { mappings = false },
})

-----------------------------------------------------------------------------------------------------------------------
--- Tmux Navigation
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

-----------------------------------------------------------------------------------------------------------------------
--- Blade Nav
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/RicardoRamirezR/blade-nav.nvim" },
})

-----------------------------------------------------------------------------------------------------------------------
--- Laravel
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/adalessa/laravel.nvim" },
})

require('laravel').setup({
  lsp_server = "intelephense",
  features = {
    pickers = {
      provider = "snacks",
    },
  },
})

-----------------------------------------------------------------------------------------------------------------------
--- Neotest
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/nvim-neotest/neotest" },
  { src = "https://github.com/olimorris/neotest-phpunit" },
})

require('neotest').setup({
  adapters = {
    require('neotest-phpunit'),
  },
})

-----------------------------------------------------------------------------------------------------------------------
--- Conform (Formatting)
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
  formatters_by_ft = {
    blade = { "blade-formatter" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-----------------------------------------------------------------------------------------------------------------------
--- Blink CMP (Autocomplete)
-----------------------------------------------------------------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  completion = {
    documentation = { auto_show = true },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  snippets = { preset = 'default' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  signature = { enabled = true },
})
