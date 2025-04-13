local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

Hydra({ -- *hunk operations only work when gitsigns attaches to buffer
	name = "Git",
	hint = [[
_{_: first hunk _l_: log for file _c_: status 
_}_: last hunk  _L_: log          _p_: inline diff 
_[_: prev hunk  _d_: diff         _o_: open on github 
_]_: next hunk  _D_: diff head    _y_: copy github link

                      _<Enter>_: Lazygit  _<Esc>_: exit
]],
	config = {
		color = "blue",
		invoke_on_body = true,
		hint = {
			float_opts = {
				border = "rounded",
			},
		},
	},
	mode = { "n", "x" },
	body = "<leader>g",
	heads = {
		{ "{", "[H", { desc = "goto first hunk" } },
		{ "}", "]H", { desc = "goto last hunk" } },
		{ "[", "[h", { desc = "goto prev hunk" } },
		{ "]", "]h", { desc = "goto next hunk" } },
		{
			"b",
			function()
				Snacks.gitbrowse()
			end,
			{ desc = "Git Browse" },
		},
		{
			"y",
			function()
				Snacks.gitbrowse({
					open = function(url)
						vim.fn.setreg("+", url)
					end,
					notify = false,
				})
			end,
			{ desc = "Git Browse (copy)" },
		},
		{ "b", cmd("BlameToggle"), { desc = "blame" } },
		{
			"B",
			function()
				-- gitsigns.blame_line({ full = true })
			end,
			{ desc = "blame show full" },
		},
		{
			"l",
			function()
				Snacks.lazygit.log_file()
			end,
			{ desc = "file git history" },
		},
		{
			"L",
			function()
				Snacks.lazygit.log()
			end,
			{ desc = "Lazygit Log (cwd)" },
		},
		-- { "d", gitsigns.diffthis, { desc = "Lazygit Log (cwd)" } },
		{
			"D",
			function()
				-- gitsigns.diffthis("~")
			end,
			{ desc = "Lazygit Log (cwd)" },
		},
		{
			"c",
			function()
				Snacks.picker.git_status()
			end,
			{ desc = "Git Status" },
		},
		{
			"c",
			function()
				MiniDiff.toggle_overlay()
			end,
			{ desc = "Git Status" },
		},
		{
			"<Enter>",
			function()
				Snacks.lazygit()
			end,
			{ desc = "Lazygit" },
		},
		{
			"<Esc>",
			nil,
			{ nowait = true, desc = "exit" },
		},
	},
})
