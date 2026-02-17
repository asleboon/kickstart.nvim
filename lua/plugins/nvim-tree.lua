return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      disable_netrw = true,
      hijack_netrw = true,

      -- sorting is top-level
      sort = {
        sorter = 'case_sensitive',
      },

      update_focused_file = {
        enable = true,
        update_root = false,
      },

      filters = {
        dotfiles = false,
      },

      actions = {
        open_file = {
          quit_on_open = false,
        },
      },

      view = {
        width = 30,
      },

      renderer = {
        group_empty = true,
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
      },

      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- load default mappings first
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
          }
        end

        -- Force proper split behavior (override any system open mapping)
        vim.keymap.set('n', 's', api.node.open.vertical, opts 'Open: Vertical Split')
        vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')

        -- Preview without leaving tree
        vim.keymap.set('n', 'w', function()
          local node = api.tree.get_node_under_cursor()
          if node and node.type == 'file' then
            api.node.open.preview()
          end
        end, opts 'Preview File')
      end,
    }
  end,

  keys = {
    { '<leader>tt', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle tree' },
    {
      '<leader>tr',
      function()
        require('nvim-tree.api').tree.find_file {
          open = true,
          focus = true,
          update_root = true,
        }
      end,
      desc = 'Reveal file + update root',
    },
  },
}
