return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = {
			enabled = true,
			size = 0.5 * 1024 * 1024, -- .5MB
		},
		dashboard = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
	},
	init = function()
		-- keymaps
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map({ "n", "x" }, "<leader>n", function()
			Snacks.notifier.show_history()
		end, { desc = "Notification history" })

		map({ "n", "x" }, "<leader>un", function()
			Snacks.notifier.hide()
		end, { desc = "Dismiss all notifications" })

	end,
}
