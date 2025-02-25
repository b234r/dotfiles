local util = require("util")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "lua" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			},
			setup = {
				lua_ls = function(_, opts)
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(ev)
							local client = vim.lsp.get_client_by_id(ev.data.client_id)
							if client == nil or client.name ~= "lua_ls" then
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
}
