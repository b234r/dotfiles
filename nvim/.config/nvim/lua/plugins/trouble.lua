return {
  "folke/trouble.nvim",
  dependencies = { "mbbill/undotree" },
  config = function()
    require("trouble").setup()

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

    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd

    Hydra({
      name = "Diagnostics",
      hint = [[
       _{_: first error  _[_: prev error  _]_: next error  _}_: last error _x_: buffer diag
      _d{_: first diag  _d[_: prev diag  _d]_: next diag  _d}_: last diag  _X_: project diag
      _w{_: first warn  _w[_: prev warn  _w]_: next warn  _w}_: last warn  _u_: undotree

                   _q_: toggle quickfix  _l_: toggle loclist  _<Esc>_: exit
      ]],

      config = {
        on_enter = function()
          vim.diagnostic.config({ virtual_text = true })
        end,
        on_exit = function()
          vim.diagnostic.config({ virtual_text = false })
        end,
        color = "red",
        invoke_on_body = true,
        hint = {
          float_opts = {
            border = "rounded",
          },
        },
      },
      mode = "n",
      body = "<leader>d",
      heads = {
        {
          "{",
          function()
            return vim.diagnostic.jump({
              count = -100000,
              wrap = false,
              severity = vim.diagnostic.severity.ERROR,
            })
          end,
        },
        {
          "]",
          function()
            return vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
          end,
        },
        {
          "[",
          function()
            return vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end,
        },
        {
          "}",
          function()
            return vim.diagnostic.jump({
              count = 100000,
              wrap = false,
              severity = vim.diagnostic.severity.ERROR,
            })
          end,
        },
        {
          "d{",
          function()
            return vim.diagnostic.jump({ count = -100000, wrap = false })
          end,
        },
        {
          "d[",
          function()
            return vim.diagnostic.goto_next()
          end,
        },
        {
          "d]",
          function()
            return vim.diagnostic.goto_prev()
          end,
        },
        {
          "d}",
          function()
            return vim.diagnostic.jump({ count = 100000, wrap = false })
          end,
        },
        {
          "w{",
          function()
            return vim.diagnostic.jump({
              count = -100000,
              wrap = false,
              severity = vim.diagnostic.severity.WARN,
            })
          end,
        },
        {
          "w[",
          function()
            return vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
          end,
        },
        {
          "w]",
          function()
            return vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
          end,
        },
        {
          "w}",
          function()
            return vim.diagnostic.jump({
              count = 100000,
              wrap = false,
              severity = vim.diagnostic.severity.WARN,
            })
          end,
        },
        { "x",     cmd("Trouble diagnostics toggle"),              { exit = true } },
        { "X",     cmd("Trouble diagnostics toggle filter.buf=0"), { exit = true } },
        { "u",     cmd("silent! %foldopen! | UndotreeToggle"),     { exit = true } },
        { "q",     cmd("Trouble loclist toggle"),                  { exit = true } },
        { "l",     cmd("Trouble qflist toggle"),                   { exit = true } },
        { "<Esc>", nil,                                            { exit = true } },
      },
    })
  end,
}
