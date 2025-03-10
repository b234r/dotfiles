return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
      size = 0.5 * 1024 * 1024, -- .5MB
    },
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/Pictures/mandarinfish.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
          height = 17,
          padding = 1,
        },
        {
          pane = 2,
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      enabled = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
  },
  init = function()
    -- keymaps
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map({ "n", "x" }, "<leader>n", function()
      Snacks.notifier.show_history()
    end, { desc = "Notification history" })

    map({ "n", "x" }, "<leader>un", function()
      Snacks.notifier.hide()
    end, { desc = "Dismiss all notifications" })

    map({ "n", "x" }, "z=", function()
      Snacks.picker.spelling()
    end, { desc = "Dismiss all notifications" })
  end,
}
