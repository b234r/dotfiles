-----------------------------------------------------------------------------------------------------------------------
--- Options
-----------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<space>", "<nop>")
vim.g.mapleader = " "

vim.opt.cc = "120" -- Column border

vim.opt.cmdheight = 0

vim.opt.wildmode = "longest,list"

vim.opt.cursorline = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ruler = false          -- Don't show cursor position in command line
vim.opt.showmode = false       -- Don't show mode in command line

vim.opt.shortmess:append("sI") -- hide intro screen

vim.opt.wrap = false
vim.opt.whichwrap:append("<>[]hl") -- Goto previous/next line from start/end of line
vim.opt.fillchars = "eob: "        -- Don't show `~` outside of buffer

vim.opt.undofile = true

vim.opt.backup = false -- Don't store backup while overwriting the file
vim.opt.writebackup = false

-- Editing
vim.opt.ignorecase = true                         -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch = true                          -- Show search results while typing
vim.opt.infercase = true                          -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase = true                          -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent = true                        -- Make indenting smart

vim.opt.completeopt = "menuone,noinsert,noselect" -- Customize completions
vim.opt.virtualedit = "block"                     -- Allow going past the end of line in visual block mode
vim.opt.formatoptions = "qjl1"                    -- Don't autoformat comments

vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.mouse = "a"

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.smoothscroll = true

vim.opt.list = true
vim.opt.listchars = "tab:│ ,leadmultispace:│ "

-- folding
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "0"
vim.wo.foldnestmax = 99
vim.wo.foldminlines = 1
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99

-- theme
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- line numbers
vim.opt.number = true

-- non-relative numbers in insert mode
vim.api.nvim_command([[
  augroup numbertoggle
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])

-- use terminal background color
vim.api.nvim_command([[
  augroup usercolors
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  augroup END
]])

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
