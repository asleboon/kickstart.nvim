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
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- show hidden files
        hide_gitignored = false,
        hide_dotfiles = false,
      },
      follow_current_file = {
        leave_dirs_open = true,
        enabled = true,
      },
      hijack_netrw_behavior = 'open_current',
      use_libuv_file_watcher = true, -- Automatically updates the Neo-tree view when files change on disk, using Neovim's built-in libuv file watcher (like inotify on Linux).
    },
  },
}
