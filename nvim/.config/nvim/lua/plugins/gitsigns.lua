return {
  "lewis6991/gitsigns.nvim",
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

    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd

    local git_stage = function()
      local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
      if mode == "V" then                  -- visual-line mode
        local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
        vim.api.nvim_feedkeys(esc, "x", false) -- exit visual mode
        vim.cmd("'<,'>Gitsigns stage_hunk")
      else
        vim.cmd("Gitsigns stage_hunk")
      end
    end

    Hydra({ -- *hunk operations only work when gitsigns attaches to buffer
      name = "Git",
      hint = [[
_]_: next hunk    _u_: undo stage     _O_: open browser        _l_: log for file _c_: status
_[_: prev hunk    _r_: reset hunk     _Y_: copy url            _L_: log
_S_: stage buffer _p_: preview hunk   _b_: toggle inline blame _d_: diff
_s_: stage hunk   _x_: toggle deleted _B_: show blame          _D_ diff head

                 _<Enter>_: Neogit  _<Esc>_: exit
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
      mode = { "n", "x" },
      body = "<leader>g",
      heads = {
        {
          "]",
          function()
            gitsigns.nav_hunk("next")
            return "<Ignore>"
          end,
          { desc = "next hunk" },
        },
        {
          "[",
          function()
            gitsigns.nav_hunk("prev")
            return "<Ignore>"
          end,
          { desc = "prev hunk" },
        },
        { "S", gitsigns.stage_buffer,        { exit = true, desc = "stage buffer" } },
        { "s", git_stage,                    { exit = true, desc = "stage hunk" } },
        { "u", gitsigns.undo_stage_hunk,     { exit = true, desc = "undo last stage" } },
        { "r", gitsigns.reset_hunk,          { exit = true, desc = "reset hunk" } },
        { "x", gitsigns.toggle_deleted,      { exit = true, desc = "toggle deleted" } },
        { "p", gitsigns.preview_hunk_inline, { exit = true, desc = "preview hunk" } },
        {
          "O",
          function()
            Snacks.gitbrowse()
          end,
          { exit = true, desc = "Git Browse" },
        },
        {
          "Y",
          function()
            Snacks.gitbrowse({
              open = function(url)
                vim.fn.setreg("+", url)
              end,
              notify = false,
            })
          end,
          { exit = true, desc = "Git Browse (copy)" },
        },
        { "b", gitsigns.toggle_current_line_blame, { exit = true, desc = "blame" } },
        {
          "B",
          function()
            gitsigns.blame_line({ full = true })
          end,
          { desc = "blame show full" },
        },
        {
          "l",
          function()
            Snacks.lazygit.log_file()
          end,
          { exit = true, desc = "file git history" },
        },
        {
          "L",
          function()
            Snacks.lazygit.log()
          end,
          { exit = true, desc = "Lazygit Log (cwd)" },
        },
        { "d", gitsigns.diffthis,                  { exit = true, desc = "Lazygit Log (cwd)" } },
        {
          "D",
          function()
            gitsigns.diffthis("~")
          end,
          { exit = true, desc = "Lazygit Log (cwd)" },
        },
        { "c", cmd("FzfLua git_status"), { exit = true, desc = "blame" } },
        {
          "<Enter>",
          function()
            Snacks.lazygit()
          end,
          { exit = true, desc = "Lazygit" },
        },
        {
          "<Esc>",
          nil,
          { exit = true, nowait = true, desc = "exit" },
        },
      },
    })
  end,
}
