return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'query',
        'c_sharp',
        'javascript',
        'typescript',
        'tsx',
        'html',
        'css',
        'json',
        'yaml',
        'markdown',
        'markdown_inline',
        'lua',
        'vim',
        'javascript',
        'html',
        'css',
        'python',
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
