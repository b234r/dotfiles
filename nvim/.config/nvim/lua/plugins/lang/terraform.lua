local util = require("util")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "terraform", "hcl" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "terraform-ls", "tflint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        terraformls = {},
      },
      setup = {
        terraformls = function(_, opts)
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              if client == nil or client.name ~= "terraformls" then
                return
              end

              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function() vim.lsp.buf.format({ bufnr = ev.buf, id = client.id }) end
              })
            end,
          })
        end
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.packer,
        nls.builtins.formatting.terraform_fmt,
        nls.builtins.diagnostics.terraform_validate,
      })
    end,
  },
}
