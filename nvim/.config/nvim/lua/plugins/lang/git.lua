local util = require("util")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "git_config", "gitcommit", "gitignore" })
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
