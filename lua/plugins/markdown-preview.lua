-- Live markdown preview in the browser, with built-in mermaid.js rendering.
--   :MarkdownPreviewToggle opens a browser tab that updates as you type.
-- Build runs `npm install` in the plugin's app/ dir (uses your node from mise).
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  ft = { 'markdown' },
  build = 'cd app && npm install',
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = '[M]arkdown [P]review toggle' },
  },
  init = function()
    vim.g.mkdp_filetype = { 'markdown' }
    vim.g.mkdp_auto_close = 0 -- keep the preview tab open when switching buffers
    vim.g.mkdp_theme = 'dark'
  end,
}
