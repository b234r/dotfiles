return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()

    require("mini.icons").setup()

    require("mini.move").setup()

    require("mini.operators").setup({
      replace = {
        prefix = "s",
      },
    })

    require("mini.pairs").setup()

    require("mini.splitjoin").setup()

    require("mini.statusline").setup()

    require("mini.surround").setup({
      mappings = {
        add = 'Sa',            -- Add surrounding in Normal and Visul modes
        delete = 'Sd',         -- Delete surrounding
        find = 'Sf',           -- Find surrounding (to the right)
        find_left = 'SF',      -- Find surrounding (to the left)
        highlight = 'Sh',      -- Highlight surrounding
        replace = 'Sr',        -- Replace surrounding
        update_n_lines = 'Sn', -- Update `n_lines`

        suffix_last = 'l',     -- Suffix to search with "prev" method
        suffix_next = 'n',     -- Suffix to search with "next" method
      },
    })
  end,
}
