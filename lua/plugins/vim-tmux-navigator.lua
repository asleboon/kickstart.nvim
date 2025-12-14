return {
  'christoomey/vim-tmux-navigator',
  config = function()
    -- Do not auto-create key mappings; we will set them manually
    vim.g.tmux_navigator_no_mappings = 1

    -- Now map keys manually
    vim.keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { silent = true })
    vim.keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { silent = true })
    vim.keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { silent = true })
    vim.keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { silent = true })
  end,
}
