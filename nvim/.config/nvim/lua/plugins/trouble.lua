return {
  "folke/trouble.nvim",
  dependencies = { "mbbill/undotree" },
  cmd = "Trouble",
  opts = {},
  init = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = "󰠠 ",
          [vim.diagnostic.severity.HINT] = " ",
        },
      },
    })

    vim.g.undotree_WindowLayout = 2;

    -- keymaps
    vim.keymap.set("n", "<leader>x", vim.diagnostic.open_float, {})
  end,
}
