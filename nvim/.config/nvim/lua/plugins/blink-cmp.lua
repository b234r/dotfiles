return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'Kaiser-Yang/blink-cmp-dictionary',
    'echasnovski/mini.icons',
    'rafamadriz/friendly-snippets',
  },
  event = "InsertEnter",
  -- use a release tag to download pre-built binaries
  version = '*',
  opts = {
    keymap = {
      preset = 'none',

      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      ['<C-e>'] = { 'show', 'hide', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Right>'] = { 'accept', 'fallback' },

      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    },

    cmdline = {
      keymap = {
        ['<Tab>'] = { 'show', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },

        ['<C-e>'] = { 'hide', 'fallback' },
        ['<Right>'] = { 'accept', 'fallback' },
      },

      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = true
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        window = {
          scrollbar = false,
        },
      },

      list = {
        selection = {
          auto_insert = function(ctx) return ctx.mode == 'cmdline' end,
          preselect = function(ctx)
            return ctx.mode == 'default'
          end,
        },
      },

      menu = {
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
        scrollbar = false,
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kind = {
              text = function(ctx) return '<<' .. (ctx.kind == 'Text' and ctx.source_name or ctx.kind) .. '>>' end,
            },
          },
          treesitter = {
            'lsp'
          },
        },
      },
    },

    signature = {
      enabled = true,
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'markdown', 'dictionary' },
      providers = {
        markdown = {
          name = 'Markdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
        dictionary = {
          module = 'blink-cmp-dictionary',
          name = 'Dict',
          enabled = true,
          -- Make sure this is at least 2.
          -- 3 is recommended
          min_keyword_length = 3,
          max_items = 5,
          score_offset = -3,
          opts = {
            dictionary_directories = { vim.fn.expand("~/Repos/b234r/Dotfiles/dictionary") },
            dictionary_files = {
              vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
              vim.fn.expand("~/.config/nvim/spell/es.utf-8.add"),
            },
            documentation = {
              enable = true, -- enable documentation to show the definition of the word
            },
          },
        },
      },
    },
  },
  opts_extend = {
    "sources.default"
  },
}
