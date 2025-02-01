local get_intelephense_license = function()
	local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))

	local content = f:read("*a")

	f:close()

	return string.gsub(content, "%s+", "")
end

return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					opts.desc = "Show references"
					vim.keymap.set("n", "<leader>lr", "<cmd>FzfLua lsp_references<CR>", opts)

					opts.desc = "Show implementations"
					vim.keymap.set("n", "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", opts)

					opts.desc = "Toggle definitions, declarations, ..."
					vim.keymap.set(
						"n",
						"<leader>ll",
						"<cmd>Trouble lsp toggle pinned=true focus=true win.position=right<cr>",
						opts
					)

					opts.desc = "Toggle symbols"
					vim.keymap.set(
						"n",
						"<leader>ls",
						"<cmd>Trouble symbols toggle focus=true win.position=left<cr>",
						opts
					)

					opts.desc = "Restart LSP"
					vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts)
				end,
			})

			local servers = {
				intelephense = {
					init_options = {
						licenceKey = get_intelephense_license(),
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"php-cs-fixer",
				"pint",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.blade_formatter,
					null_ls.builtins.diagnostics.ansiblelint,
          null_ls.builtins.diagnostics.commitlint,
          null_ls.builtins.diagnostics.phpstan,
          null_ls.builtins.diagnostics.sqlfluff.with({extra_args = { "--dialect", "postgres" }}),
					null_ls.builtins.formatting.phpcsfixer,
					null_ls.builtins.formatting.pint,
					null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.sqlfluff.with({extra_args = { "--dialect", "postgres" }}),
          null_ls.builtins.formatting.just,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.code_actions.refactoring,
				},
			})
		end,
	},
}
