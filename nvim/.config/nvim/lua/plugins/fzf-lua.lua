return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "echasnovski/mini.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "folke/todo-comments.nvim",
  },
  config = function()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
      "hide",
      actions = {
        files = {
          ["enter"] = fzf_lua.actions.file_edit_or_qf,
          ["ctrl-t"] = require("trouble.sources.fzf").actions.open,
          ["ctrl-s"] = fzf_lua.actions.file_split,
          ["ctrl-v"] = fzf_lua.actions.file_vsplit,
          ["alt-i"] = fzf_lua.actions.toggle_ignore,
          ["alt-h"] = fzf_lua.actions.toggle_hidden,
          ["alt-f"] = fzf_lua.actions.toggle_follow,
        },
      },
      keymap = {
        -- Below are the default binds, setting any value in these tables will override
        -- the defaults, to inherit from the defaults change [1] from `false` to `true`
        builtin = {
          true, -- uncomment to inherit all the below in your custom config
          ["<C-b>"] = "preview-down",
          ["<C-f>"] = "preview-up",
        },
        fzf = {
          true, -- uncomment to inherit all the below in your custom config
        },
      },
    })

    vim.api.nvim_create_autocmd("VimResized", {
      pattern = "*",
      command = 'lua require("fzf-lua").redraw()',
    })

    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd

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
        { "f",       cmd("FzfLua files") },
        { "b",       cmd("FzfLua buffers") },
        { "o",       cmd("FzfLua oldfiles") },
        { "s",       cmd("FzfLua live_grep_glob") },
        { "*",       cmd("FzfLua grep_cword") },
        { '"',       cmd("FzfLua registers") },
        { "r",       cmd("FzfLua resume") },
        { ";",       cmd("FzfLua command_history") },
        { "?",       cmd("FzfLua manpages") },
        { "<Enter>", cmd("FzfLua") },
        { "<Esc>",   nil,                          { nowait = true } },
      },
    })
  end,
}
