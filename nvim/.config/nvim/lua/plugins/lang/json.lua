local util = require("util")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "json5" })
		end,
	},
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "json-lsp" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			servers = {
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
					},
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				php = { "jq" },
			},
		},
	},
}
