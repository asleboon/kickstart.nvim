-- Tip: You have to save the menu in order for changes to happen.
-- I.e if you delete something hit :w after

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2', -- use the new harpoon version
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    -- KEYMAPS (use whatever you like)
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap('n', '<leader>ha', function()
      harpoon:list():add()
    end, opts) -- Add file
    keymap('n', '<leader>ho', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, opts) -- Menu

    -- Jump to files
    keymap('n', '<leader>1', function()
      harpoon:list():select(1)
    end, opts)
    keymap('n', '<leader>2', function()
      harpoon:list():select(2)
    end, opts)
    keymap('n', '<leader>3', function()
      harpoon:list():select(3)
    end, opts)
    keymap('n', '<leader>4', function()
      harpoon:list():select(4)
    end, opts)
  end,
}
