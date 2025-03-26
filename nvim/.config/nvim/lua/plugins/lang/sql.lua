local util = require("util")
return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = { ensure_installed = { "sql" } },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "sqlfluff" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters = {
				sqlfluff = {
					args = { "format", "--dialect=ansi", "-" },
				},
				formatters_by_ft = {
					sql = { "sqlfluff" },
					mysql = { "sqlfluff" },
					plsql = { "sqlfluff" },
				},
			},
		},
	},
}
