return {
	"cathyprime/hydra.nvim",
	dependencies = {
		"mrjones2014/smart-splits.nvim",
		{
			"sindrets/winshift.nvim",
			opts = {
				keymaps = {
					disable_defaults = true,
				},
			},
		},
	},
	priority = 1000,
	config = function()
		local splits = require("smart-splits")
		local Hydra = require("hydra")
		local cmd = require("hydra.keymap-util").cmd
		local pcmd = require("hydra.keymap-util").pcmd

		-------------------------------------------------------------------------------------
		-- WINDOW
		-------------------------------------------------------------------------------------
		Hydra({
			name = "Windows",
			hint = [[
^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
_h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
focus^^^^^^  window^^^^^^

               _<Esc>_: exit
]],
			config = {
				color = "red",
				invoke_on_body = true,
				hint = {
					float_opts = {
						border = "rounded",
					},
				},
			},
			mode = "n",
			body = "<leader>w",
			heads = {
				{ "h", "<C-w>h" },
				{ "j", "<C-w>j" },
				{ "k", pcmd("wincmd k", "E11", "close") },
				{ "l", "<C-w>l" },

				{ "H", cmd("WinShift left") },
				{ "J", cmd("WinShift down") },
				{ "K", cmd("WinShift up") },
				{ "L", cmd("WinShift right") },

				{
					"<C-h>",
					function()
						splits.resize_left(2)
					end,
				},
				{
					"<C-j>",
					function()
						splits.resize_down(2)
					end,
				},
				{
					"<C-k>",
					function()
						splits.resize_up(2)
					end,
				},
				{
					"<C-l>",
					function()
						splits.resize_right(2)
					end,
				},

				{ "s", pcmd("split", "E36") },
				{ "<C-s>", pcmd("split", "E36"), { desc = false } },
				{ "v", pcmd("vsplit", "E36") },
				{ "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

				{ "w", "<C-w>w", { exit = true, desc = false } },
				{ "<C-w>", "<C-w>w", { exit = true, desc = false } },

				{ "c", pcmd("close", "E444"), { desc = "close window" } },

				{ "<Esc>", nil, { exit = true, desc = false } },
			},
		})
	end,
}
