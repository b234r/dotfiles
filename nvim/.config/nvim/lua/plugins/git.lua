local date_author_fn = function(line_porcelain, config, idx)
  local hash = string.sub(line_porcelain.hash, 0, 7)
  local line_with_hl = {}
  local is_commited = hash ~= "0000000"
  if is_commited then
    line_with_hl = {
      idx = idx,
      values = {
        {
          textValue = os.date(
            config.date_format,
            line_porcelain.committer_time
          ),
          hl = hash,
        },
        {
          textValue = line_porcelain.author,
          hl = hash,
        },
      },
      format = "%s  %s",
    }
  else
    line_with_hl = {
      idx = idx,
      values = {
        {
          textValue = "Not commited",
          hl = "Comment",
        },
      },
      format = "%s",
    }
  end
  return line_with_hl
end

return {
  {
    "FabijanZulj/blame.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-context",
    },
    lazy = false,
    config = function()
      require("blame").setup({
        focus_blame = false,
        format_fn = date_author_fn,
        max_summary_width = 20,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlameViewOpened",
        callback = function(event)
          local blame_type = event.data
          if blame_type == "window" then
            require("treesitter-context").disable()
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlameViewClosed",
        callback = function(event)
          local blame_type = event.data
          if blame_type == "window" then
            require("treesitter-context").enable()
          end
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        signcolumn = false,
        numhl = true,
        attach_to_untracked = true,
      })

      local map = vim.keymap.set

      map("n", "]g", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)

      map("n", "[g", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)

      map({ "o", "x" }, "gh", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
}
