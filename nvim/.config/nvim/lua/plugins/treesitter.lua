return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "csv",
        "dockerfile",
        "git_config",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "helm",
        "graphql",
        "html",
        "javascript",
        "json",
        "just",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "php",
        "phpdoc",
        "psv",
        "python",
        "rust",
        "sql",
        "typescript",
        "terraform",
        "toml",
        "tsv",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "gni",
          node_decremental = "gnd",
        },
      },
    })

    vim.filetype.add({
      extension = {
        gotmpl = 'gotmpl',
      },
      pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
      },
    })

    -- treesitter for folding
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    -- enable context
    require 'treesitter-context'.setup {
      max_lines = 10,          -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 40,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      multiline_threshold = 1, -- Maximum number of lines to show for a single context
    }

    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = "None" })
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = "#3b4261" })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = "#3b4261" })
  end,
}
