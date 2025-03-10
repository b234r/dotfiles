local util = require("util")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        "gitattributes",
        "gitcommit",
        "git_config",
        "gitignore",
        "git_rebase",
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "actionlint", "commitlint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        gh_actions_ls = {},
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.commitlint,
      })
    end,
  },
}
