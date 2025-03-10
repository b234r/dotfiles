local util = require("util")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, { "dockerfile" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed,
        { "docker-compose-language-service", "dockerfile-language-server", "hadolint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
      setup = {
        dockerls = function(_, opts)
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              if client == nil or client.name ~= "dockerls" then
                return
              end

              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function() vim.lsp.buf.format({ bufnr = ev.buf, id = client.id }) end
              })
            end,
          })
        end,
        docker_compose_language_service = function(_, opts)
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              if client == nil or client.name ~= "docker_compose_language_service" then
                return
              end

              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function() vim.lsp.buf.format({ bufnr = ev.buf, id = client.id }) end
              })
            end,
          })
        end,
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.hadolint,
      })
    end,
  },
}
