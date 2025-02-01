return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("snacks").setup({
      bigfile = {
        enabled = true,
        size = 0.5 * 1024 * 1024, -- .5MB
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      -- scroll = { enabled = true },
    })

    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#737aa2" })

    -- keymaps
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map({ "o", "x" }, "<leader>n", function()
      Snacks.notifier.show_history()
    end, { desc = "Notification history" })

    map({ "o", "x" }, "<leader>un", function()
      Snacks.notifier.hide()
    end, { desc = "Dismiss all notifications" })
  end,
}
