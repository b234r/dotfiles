return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "html",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "vimdoc",
        "go",
        "rust",
        "php",
        "javascript",
        "typescript",
        "c",
        "cpp"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>y",
          node_incremental = "<leader>y",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
