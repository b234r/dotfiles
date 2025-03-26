local util = require("util")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "helm" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "helm-ls" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			servers = {
				helm_ls = {},
			},
			setup = {
				yamlls = function()
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(ev)
							local client = vim.lsp.get_client_by_id(ev.data.client_id)
							if client == nil or client.name ~= "helm_ls" then
								return
							end

							vim.schedule(function()
								vim.cmd("LspStop ++force yamlls")
							end)

							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = ev.buf,
								callback = function()
									vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
								end,
							})
						end,
					})
				end,
			},
		},
	},
	{
		"towolf/vim-helm",
	},
}
