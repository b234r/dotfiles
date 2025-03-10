local util = require("util")

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "ansible-language-server", "ansible-lint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },
}
