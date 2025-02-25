local keymap = function(ev)
	local opts = { buffer = ev.buf, silent = true }

	opts.desc = "Show references"
	vim.keymap.set("n", "grr", function()
		Snacks.picker.lsp_references()
	end, opts)

	opts.desc = "Show implementations"
	vim.keymap.set("n", "gri", function()
		Snacks.picker.lsp_implementations()
	end, opts)

	opts.desc = "Show symbols"
	vim.keymap.set("n", "grs", "<CMD>Trouble lsp toggle pinned=true focus=true win.position=right<CR>", opts)

	opts.desc = "Show lsp info"
	vim.keymap.set("n", "grl", "<CMD>Trouble symbols toggle focus=true win.position=left<CR>", opts)

	opts.desc = "Restart lsp"
	vim.keymap.set("n", "gr=", "<CMD>LspRestart<CR>", opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {},
			setup = {},
		},
		config = function(_, opts)
			for server, server_opts in pairs(opts.servers) do
				if opts.setup[server] then
					opts.setup[server](server, server_opts)
				end
				require("lspconfig")[server].setup(server_opts)
			end
		end,
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					keymap(ev)

					local buffer = ev.buf
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client == nil then
						return
					end

					if client:supports_method("textDocument/inlayHint") then
						if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
							vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
						end
					end

					if client:supports_method("textDocument/documentHighlight") then
						local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})

						vim.opt.updatetime = 300

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = buffer,
							group = group,
							callback = function()
								vim.lsp.buf.document_highlight()
							end,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved" }, {
							buffer = buffer,
							group = group,
							callback = function()
								vim.lsp.buf.clear_references()
							end,
						})
					end

					if client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = buffer,
							callback = vim.lsp.codelens.refresh,
						})
					end
				end,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			sources = {},
		},
	},
}
