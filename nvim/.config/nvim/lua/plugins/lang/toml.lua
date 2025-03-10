local util = require("util")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "toml" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "taplo" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      -- make sure mason installs the server
      servers = {
        taplo = {},
      },
    },
  },
}
