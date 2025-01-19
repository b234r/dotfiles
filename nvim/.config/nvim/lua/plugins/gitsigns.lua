return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- import lspconfig plugin
    local gs = require("gitsigns")
    gs.setup{
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal({']g', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end, {desc="Goto next git hunk"})

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal({'[g', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end, {desc="Goto previous git hunk"})

        -- Actions
        map('n', '<leader>gs', gitsigns.stage_hunk, {desc="Stage hunk"})
        map('n', '<leader>gr', gitsigns.reset_hunk, {desc="Reset hunk"})
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, {desc="Undo stage hunk"})
        map('n', '<leader>gp', gitsigns.preview_hunk, {desc="Show hunk changes"})
        map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc="Stage hunk"})
        map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc="Reset hunk"})
        map('n', '<leader>gS', gitsigns.stage_buffer, {desc="Stage buffer"})
        map('n', '<leader>gR', gitsigns.reset_buffer, {desc="Reset buffer"})
        map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, {desc="Show git blame"})
        map('n', '<leader>gB', gitsigns.toggle_current_line_blame, {desc="Toggle git blame line"})
        map('n', '<leader>gd', gitsigns.diffthis)
        map('n', '<leader>gD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>gd', gitsigns.toggle_deleted)

        -- Text object
        map({'o', 'x'}, 'gh', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  end,
}
