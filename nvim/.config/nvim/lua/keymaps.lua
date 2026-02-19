-----------------------------------------------------------------------------------------------------------------------
-- Key Bindings
-----------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<ESC>", function()
  vim.cmd.nohlsearch() -- clear highlights
  vim.cmd.echo()       -- clear short-message
end)

vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })

-- Indent while remaining in visual mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "s", "<Nop>", {})
vim.keymap.set("n", "S", "<Nop>", {})

vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("x", "gp", '"+P', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
vim.keymap.set({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window right" })

vim.keymap.set("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>', { desc = "Sync packages" })

vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fw", function() Snacks.picker.grep_word() end, { desc = "Grep word under cursor" })
vim.keymap.set("x", "<leader>fw", function() Snacks.picker.grep_word() end, { desc = "Grep selection" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help pages" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>f/", function() Snacks.picker.lines() end, { desc = "Buffer lines" })
vim.keymap.set("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, { desc = "LSP symbols" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.command_history() end, { desc = "Command history" })
vim.keymap.set("n", "<leader>f.", function() Snacks.picker.resume() end, { desc = "Resume last picker" })

-----------------------------------------------------------------------------------------------------------------------
-- Neotest
-----------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>tt", function() require('neotest').run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = "Run test file" })
vim.keymap.set("n", "<leader>tl", function() require('neotest').run.run_last() end, { desc = "Run last test" })
vim.keymap.set("n", "<leader>ts", function() require('neotest').summary.toggle() end, { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", function() require('neotest').output.open({ enter = true }) end, { desc = "Open test output" })
vim.keymap.set("n", "<leader>tO", function() require('neotest').output_panel.toggle() end, { desc = "Toggle output panel" })
vim.keymap.set("n", "<leader>tS", function() require('neotest').run.stop() end, { desc = "Stop test run" })

-----------------------------------------------------------------------------------------------------------------------
-- Which Key Groups
-----------------------------------------------------------------------------------------------------------------------
require('which-key').add({
  { "<leader>f", group = "Find" },
  { "<leader>p", group = "Packages" },
  { "<leader>t", group = "Test" },
})

