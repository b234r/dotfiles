local Hydra = require("hydra")

Hydra({
  name = "FzfLua",
  hint = [[
_f_: files     _s_: search    _r_: resume
_b_: buffers   _*_: search *  _;_: cmd history
_o_: old files _"_: registers _?_: vim help

     _<Enter>_: pickers  _<Esc>_: exit
]],
  config = {
    color = "blue",
    invoke_on_body = true,
    hint = {
      float_opts = {
        border = "rounded",
      },
    },
  },
  mode = "n",
  body = "<Leader>f",
  heads = {
    {
      "f",
      function()
        Snacks.picker.files()
      end,
    },
    {
      "b",
      function()
        Snacks.picker.buffers()
      end,
    },
    {
      "o",
      function()
        Snacks.picker.recent()
      end,
    },
    {
      "s",
      function()
        Snacks.picker.grep()
      end,
    },
    {
      "*",
      function()
        Snacks.picker.grep_word()
      end,
    },
    {
      '"',
      function()
        Snacks.picker.registers()
      end,
    },
    {
      "r",
      function()
        Snacks.picker.resume()
      end,
    },
    {
      ";",
      function()
        Snacks.picker.command_history()
      end,
    },
    {
      "?",
      function()
        Snacks.picker.help()
      end,
    },
    {
      "<Enter>",
      function()
        Snacks.picker()
      end,
    },
    { "<Esc>", nil, { nowait = true } },
  },
})
