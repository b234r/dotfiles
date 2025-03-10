return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "graphql",
        "html",
        "javascript",
        "just",
        "make",
        "python",
        "rust",
        "sql",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

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
          init_selection = "<CR>", -- set to `false` to disable one of the mappings
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      },

      textobjects = {
        enable = true,
        lsp_interop = {
          enable = false,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]c"] = "@class.outer"
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]C"] = "@class.outer"
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[c"] = "@class.outer"
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[C"] = "@class.outer"
          }
        },
        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ae"] = "@block.outer",
            ["ie"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["is"] = "@statement.inner",
            ["as"] = "@statement.outer",
            ["ad"] = "@comment.outer",
            ["am"] = "@call.outer",
            ["im"] = "@call.inner",
          }
        },
        swap = {
          enable = false,
        }
      }
    },
    init = function(_, opts)
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
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      max_lines = 10,          -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 40,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      multiline_threshold = 1, -- Maximum number of lines to show for a single context
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = "None" })
      vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = "#3b4261" })
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = "#3b4261" })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}
