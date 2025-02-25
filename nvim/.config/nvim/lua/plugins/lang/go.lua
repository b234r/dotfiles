local util = require("util")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gotmpl" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git" },
							semanticTokens = true,
						},
					},
				},
			},
			setup = {
				gopls = function(_, opts)
					vim.api.nvim_create_autocmd("LspAttach", {
						group = vim.api.nvim_create_augroup("UserLspConfig", {}),
						callback = function(ev)
							local client = vim.lsp.get_client_by_id(ev.data.client_id)
							if client == nil or client.name ~= "gopls" then
								return
							end
  
							-- https://go.googlesource.com/tools/+/refs/heads/master/gopls/doc/vim.md#imports-and-formatting
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = ev.buffer,
								callback = function()
									local params = vim.lsp.util.make_range_params()
									params.context = { only = { "source.organizeImports" } }
									local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
									for cid, res in pairs(result or {}) do
										for _, r in pairs(res.result or {}) do
											if r.edit then
												local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
												vim.lsp.util.apply_workspace_edit(r.edit, enc)
											end
										end
									end
									vim.lsp.buf.format({ async = false })
								end,
							})

							-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
							if not client.server_capabilities.semanticTokensProvider then
								local semantic = client.config.capabilities.textDocument.semanticTokens
								client.server_capabilities.semanticTokensProvider = {
									full = true,
									legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
									range = true,
								}
							end
						end,
					})
				end,
			},
		},
	},
}
