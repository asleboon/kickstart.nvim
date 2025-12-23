return {
  version = '1.*',
  'saghen/blink.cmp',
  dependencies = {
    'folke/lazydev.nvim',
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',
  },
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',

      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<CR>'] = { 'accept', 'fallback' }, -- ENTER confirms completion
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      ['<C-n>'] = { 'select_next' },
      ['<C-p>'] = { 'select_prev' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    signature = { enabled = true },
    completion = { documentation = { auto_show = true } },
  },
}
