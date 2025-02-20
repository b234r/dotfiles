local date_author_fn = function(line_porcelain, config, idx)
  local hash = string.sub(line_porcelain.hash, 0, 7)
  local line_with_hl = {}
  local is_commited = hash ~= "0000000"
  if is_commited then
    line_with_hl = {
      idx = idx,
      values = {
        {
          textValue = os.date(
            config.date_format,
            line_porcelain.committer_time
          ),
          hl = hash,
        },
        {
          textValue = line_porcelain.author,
          hl = hash,
        },
      },
      format = "%s  %s",
    }
  else
    line_with_hl = {
      idx = idx,
      values = {
        {
          textValue = "Not commited",
          hl = "Comment",
        },
      },
      format = "%s",
    }
  end
  return line_with_hl
end

return {
  {
    "FabijanZulj/blame.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-context",
    },
    lazy = false,
    config = function()
      require("blame").setup({
        focus_blame = false,
        format_fn = date_author_fn,
        max_summary_width = 20,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlameViewOpened",
        callback = function(event)
          local blame_type = event.data
          if blame_type == "window" then
            require("treesitter-context").disable()
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlameViewClosed",
        callback = function(event)
          local blame_type = event.data
          if blame_type == "window" then
            require("treesitter-context").enable()
          end
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
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
        if mode == "V" then                      -- visual-line mode
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
_O_: open browser        _l_: log for file _c_: status          _u_: undo stage
_Y_: copy url            _L_: log          _S_: stage buffer    _r_: reset hunk
_b_: toggle inline blame _d_: diff         _s_: stage hunk      _p_: preview hunk
_B_: show blame          _D_: diff head    _x_: toggle deleted

                 _<Enter>_: Lazygit  _<Esc>_: exit
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
        mode = { "n", "x" },
        body = "<leader>g",
        heads = {
          { "S", gitsigns.stage_buffer,             { desc = "stage buffer" } },
          { "s", git_stage,                         { desc = "stage hunk" } },
          { "u", gitsigns.undo_stage_hunk,          { desc = "undo last stage" } },
          { "r", gitsigns.reset_hunk,               { desc = "reset hunk" } },
          { "x", gitsigns.toggle_deleted,           { desc = "toggle deleted" } },
          { "p", gitsigns.preview_hunk_inline,      { desc = "preview hunk" } },
          { "O", function() Snacks.gitbrowse() end, { desc = "Git Browse" }, },
          {
            "Y",
            function()
              Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false, })
            end,
            { desc = "Git Browse (copy)" },
          },
          { "b",       cmd("BlameToggle"),                                  { desc = "blame" } },
          { "B",       function() gitsigns.blame_line({ full = true }) end, { desc = "blame show full" }, },
          { "l",       function() Snacks.lazygit.log_file() end,            { desc = "file git history" }, },
          { "L",       function() Snacks.lazygit.log() end,                 { desc = "Lazygit Log (cwd)" }, },
          { "d",       gitsigns.diffthis,                                   { desc = "Lazygit Log (cwd)" } },
          { "D",       function() gitsigns.diffthis("~") end,               { desc = "Lazygit Log (cwd)" } },
          { "c",       function() Snacks.picker.git_status() end,           { desc = "blame" } },
          { "<Enter>", function() Snacks.lazygit() end,                     { desc = "Lazygit" }, },
          { "<Esc>",   nil,                                                 { nowait = true, desc = "exit" }, },
        },
      })
    end,
  },
}
