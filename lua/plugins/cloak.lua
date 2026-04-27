return {
  'laytan/cloak.nvim',
  event = { 'BufReadPre .env*', 'BufReadPre *.env', 'BufNewFile .env*', 'BufNewFile *.env' },
  config = function()
    require('cloak').setup {
      enabled = true,
      cloak_character = '*',
      highlight_group = 'Comment',
      cloak_length = nil,
      try_all_patterns = true,
      patterns = {
        {
          file_pattern = { '.env*', 'wrangler.toml', '.dev.vars' },
          cloak_pattern = '=.+',
        },
      },
    }

    vim.keymap.set('n', '<leader>ct', '<cmd>CloakToggle<cr>', { desc = 'Cloak: toggle all' })
    vim.keymap.set('n', '<leader>cp', '<cmd>CloakPreviewLine<cr>', { desc = 'Cloak: peek line' })
  end,
}
