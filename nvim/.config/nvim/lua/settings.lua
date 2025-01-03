-----------------------------------------------------------------------------------------------------------------------
-- Options
-----------------------------------------------------------------------------------------------------------------------

vim.keymap.set('n', '<space>', '<nop>', {})
vim.g.mapleader = ' '

vim.opt.cc = '120' -- column border

vim.opt.wildmode = 'longest,list'

vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.number = true

vim.opt.mouse = 'a'

vim.opt.clipboard = 'unnamedplus'

vim.opt.undofile = true

vim.opt.foldlevel = 99
vim.opt.foldcolumn = '0'
vim.wo.foldnestmax = 99
vim.wo.foldminlines = 1
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99

-- line numbers
vim.api.nvim_command([[
  augroup numbertoggle
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])

-- theme
vim.opt.termguicolors = true
vim.opt.background = "dark" 
vim.opt.signcolumn = "yes"

vim.api.nvim_command([[
  augroup usercolors
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  augroup END
]])

-----------------------------------------------------------------------------------------------------------------------
-- Key Bindings
-----------------------------------------------------------------------------------------------------------------------

vim.keymap.set('i', 'jk', '<ESC>', {})
vim.keymap.set("n", "<ESC>", function()
	vim.cmd.nohlsearch() -- clear highlights
	vim.cmd.echo() -- clear short-message
end)

vim.keymap.set('n', '<C-d>', '<C-d>zz', {})
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

