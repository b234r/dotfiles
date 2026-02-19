vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local langs = {
  "blade",
  "css",
  "html",
  "javascript",
  "latex",
  "lua",
  "php",
  "php_only",
  "scss",
  "svelte",
  "tsx",
  "typst",
  "vue",
  "yaml",
}

local installed = require('nvim-treesitter').get_installed()
local missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(installed, lang)
end, langs)

if #missing > 0 then
  require('nvim-treesitter').install(missing)
end

vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end
})
