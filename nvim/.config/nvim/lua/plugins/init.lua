return {
	{ "christoomey/vim-tmux-navigator" }, -- tmux & split window navigation
	{
		"axkirillov/hbac.nvim",
		opts = {},
	},
	{
		"itchyny/vim-highlighturl",
		event = "VeryLazy",
	},
	{
		"svermeulen/vim-cutlass",
		event = "VeryLazy",
		init = function(_, opts)
			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set({ "n", "x" }, "x", "d", { desc = "cut" })
			keymap.set("n", "xx", "dd", { desc = "cut" })
			keymap.set("n", "X", "D", { desc = "cut" })
		end,
	},
}
