return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>nf',
      function()
        require('conform').format { async = true }
      end,
      mode = 'n',
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = true,

    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'never',
    },

    formatters_by_ft = {
      -- JS / TS
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },

      -- Web
      html = { 'prettierd' },
      css = { 'prettierd' },
      json = { 'prettierd' },
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },

      -- Others
      lua = { 'stylua' },
      sh = { 'shfmt' },
      -- go = { 'gofumpt', 'goimports' },
      cs = { 'csharpier' },
    },
  },
}
