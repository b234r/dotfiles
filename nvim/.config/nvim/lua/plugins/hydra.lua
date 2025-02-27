return {
  "cathyprime/hydra.nvim",
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
  init = function()
    local splits = require("smart-splits")
    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd
    local pcmd = require("hydra.keymap-util").pcmd

    -------------------------------------------------------------------------------------
    --- WINDOW
    -------------------------------------------------------------------------------------
    Hydra({
      name = "Windows",
      hint = [[
^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
_h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
focus^^^^^^  window^^^^^^

                 _<Esc>_: exit
]],
      config = {
        color = "red",
        invoke_on_body = true,
        hint = {
          float_opts = {
            border = "rounded",
          },
        },
      },
      mode = "n",
      body = "<leader>w",
      heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", pcmd("wincmd k", "E11", "close") },
        { "l", "<C-w>l" },

        { "H", cmd("WinShift left") },
        { "J", cmd("WinShift down") },
        { "K", cmd("WinShift up") },
        { "L", cmd("WinShift right") },

        {
          "<C-h>",
          function()
            splits.resize_left(2)
          end,
        },
        {
          "<C-j>",
          function()
            splits.resize_down(2)
          end,
        },
        {
          "<C-k>",
          function()
            splits.resize_up(2)
          end,
        },
        {
          "<C-l>",
          function()
            splits.resize_right(2)
          end,
        },

        { "s",     pcmd("split", "E36") },
        { "<C-s>", pcmd("split", "E36"),  { desc = false } },
        { "v",     pcmd("vsplit", "E36") },
        { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

        { "w",     "<C-w>w",              { exit = true, desc = false } },
        { "<C-w>", "<C-w>w",              { exit = true, desc = false } },

        { "c",     pcmd("close", "E444"), { desc = "close window" } },

        { "<Esc>", nil,                   { exit = true, desc = false } },
      },
    })

    -------------------------------------------------------------------------------------
    --- OPTIONS
    -------------------------------------------------------------------------------------
    Hydra({
      name = "Options",
      hint = [[
^ ^        Options
^
%{nu} [_n_]umber
%{ih} inlay [_h_]ints
%{ve} [_v_]irtual edit
%{list} [_i_]nvisible characters
%{spell} [_s_]pell
%{wrap} [_w_]rap
%{cul} [_c_]ursor line
^
          ^^^_<Esc>_
]],
      config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
          float_opts = {
            border = "rounded",
          },
          position = "middle",
          funcs = {
            nu = function()
              return vim.o.number and " " or " "
            end,
            ih = function()
              return vim.lsp.inlay_hint.is_enabled() and " " or " "
            end,
            ve = function()
              return vim.tbl_contains(vim.opt.virtualedit:get(), "all") and " " or " "
            end,
            list = function()
              return vim.o.list and " " or " "
            end,
            spell = function()
              return vim.o.spell and " " or " "
            end,
            wrap = function()
              return vim.o.wrap and " " or " "
            end,
            cul = function()
              return vim.o.cursorline and " " or " "
            end,
          },
        },
      },
      mode = { "n", "x" },
      body = "<leader>o",
      heads = {
        {
          "n",
          function()
            Snacks.toggle.line_number({ notify = false }):toggle()
          end,
          { desc = "number" },
        },
        {
          "h",
          function()
            if vim.lsp.inlay_hint.is_enabled() then
              vim.lsp.inlay_hint.enable(false)
            else
              vim.lsp.inlay_hint.enable(true)
            end
          end,
          { desc = "inlay hints" },
        },
        {
          "v",
          function()
            if vim.o.virtualedit == "all" then
              vim.o.virtualedit = "block"
            else
              vim.o.virtualedit = "all"
            end
          end,
          { desc = "virtualedit" },
        },
        {
          "i",
          function()
            if vim.o.list == true then
              vim.o.list = false
            else
              vim.o.list = true
            end
          end,
          { desc = "show invisible" },
        },
        {
          "s",
          function()
            if vim.o.spell == true then
              vim.o.spell = false
            else
              vim.o.spell = true
            end
          end,
          { desc = "spell" },
        },
        {
          "w",
          function()
            if vim.o.wrap ~= true then
              vim.o.wrap = true
              -- Dealing with word wrap:
              -- If cursor is inside very long line in the file than wraps
              -- around several rows on the screen, then 'j' key moves you to
              -- the next line in the file, but not to the next row on the
              -- screen under your previous position as in other editors. These
              -- bindings fixes this.
              vim.keymap.set("n", "k", function()
                return vim.v.count > 0 and "k" or "gk"
              end, { expr = true, desc = "k or gk" })
              vim.keymap.set("n", "j", function()
                return vim.v.count > 0 and "j" or "gj"
              end, { expr = true, desc = "j or gj" })
            else
              vim.o.wrap = false
              vim.keymap.del("n", "k")
              vim.keymap.del("n", "j")
            end
          end,
          { desc = "wrap" },
        },
        {
          "c",
          function()
            if vim.o.cursorline == true then
              vim.o.cursorline = false
            else
              vim.o.cursorline = true
            end
          end,
          { desc = "cursor line" },
        },
        { "<Esc>", nil, { exit = true } },
      },
    })
  end,
}
