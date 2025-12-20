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
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono',
    },
    signature = { enabled = true },
    completion = { documentation = { auto_show = true } },
  },
}
