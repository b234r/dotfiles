return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
          d = { "%f[%d]%d+" },                                                          -- digits
          e = {                                                                         -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = function() -- buffer
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line '$',
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.operators",
    event = "VeryLazy",
    opts = {
      replace = {
        prefix = "s",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = 'Sa',            -- Add surrounding in Normal and Visual modes
        delete = 'Sd',         -- Delete surrounding
        find = 'Sf',           -- Find surrounding (to the right)
        find_left = 'SF',      -- Find surrounding (to the left)
        highlight = 'Sh',      -- Highlight surrounding
        replace = 'Sr',        -- Replace surrounding
        update_n_lines = 'Sn', -- Update `n_lines`

        suffix_last = 'l',     -- Suffix to search with "prev" method
        suffix_next = 'n',     -- Suffix to search with "next" method
      },
    }
  },
}
