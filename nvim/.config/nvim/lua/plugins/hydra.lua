return {
  "cathyprime/hydra.nvim",
  event = "VeryLazy",
  dependencies = {
    "mrjones2014/smart-splits.nvim",
    {
      "sindrets/winshift.nvim",
      opts = {
        keymaps = {
          disable_defaults = true,
        },
      },
    },
  },
  priority = 1000,
  config = function(_, opts)
    require("hydra").setup(opts)

    require("hydras.diagnostic")
    require("hydras.git")
    require("hydras.options")
    require("hydras.picker")
    require("hydras.todo")
    require("hydras.window")
  end,
}
