local get_intelephense_license = function()
	local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))

	local content = f:read("*a")

	f:close()

	return string.gsub(content, "%s+", "")
end

local util = require("util")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			util.list_insert_unique(opts.ensure_installed, { "php" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			servers = {
				intelephense = {
					init_options = {
						licenceKey = get_intelephense_license(),
					},
				},
			},
			setup = {
				intelephense = function(_, opts)
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(ev)
							local client = vim.lsp.get_client_by_id(ev.data.client_id)
							if client == nil or client.name ~= "intelephense" then
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
