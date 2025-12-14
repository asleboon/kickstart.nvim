-- lua/plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        -- Editor / config
        'lua',
        'luadoc',
        'vim',
        'vimdoc',
        'query',

        -- C#
        'c_sharp',

        -- JS / TS / React / Next
        'javascript',
        'typescript',
        'tsx',

        -- Web
        'html',
        'css',

        -- Data / config
        'json',
        'yaml',

        -- Docs
        'markdown',
        'markdown_inline',
      },

      auto_install = true,

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
        -- Known-problematic
        disable = { 'yaml', 'markdown' },
      },
    }
  end,
}
