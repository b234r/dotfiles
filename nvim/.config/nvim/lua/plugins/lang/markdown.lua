local util = require("util")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed,
        { "marksman", "markdownlint-cli2", "prettier" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        marksman = {},
      },
    }
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ft = "markdown",
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources,
        { nls.builtins.diagnostics.markdownlint_cli2, nls.builtins.formatting.prettier })
    end,
  },
}
