local Hydra = require("hydra")

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
