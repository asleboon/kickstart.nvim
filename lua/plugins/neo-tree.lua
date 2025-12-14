-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- optional but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    -- Toggle Neo-tree
    { '<leader>tt', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
    -- Reveal current file in Neo-tree
    { '<leader>tr', ':Neotree filesystem reveal<CR>', desc = 'NeoTree reveal current file', silent = true },
    -- Increase Neo-tree width
    {
      '<leader>w>',
      function()
        require('neo-tree.ui.renderer').resize_right(5)
      end,
      desc = 'Increase Neo-tree width',
    },
    -- Decrease Neo-tree width
    {
      '<leader>w<',
      function()
        require('neo-tree.ui.renderer').resize_right(-5)
      end,
      desc = 'Decrease Neo-tree width',
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- show hidden files
        hide_gitignored = false,
      },
      follow_current_file = true, -- optional, highlight current file
      use_libuv_file_watcher = true, -- Automatically updates the Neo-tree view when files change on disk, using Neovim's built-in libuv file watcher (like inotify on Linux).
      window = {
        width = 30,
        mappings = {
          ['<leader>tt'] = 'close_window', -- optional, can also leave default
        },
      },
    },
  },
}
