return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',

  keys = {
    {
      '<leader>nf',
      function()
        require('conform').format { async = true }
      end,
      desc = 'Format buffer',
    },
  },

  opts = {
    notify_on_error = true,

    -- turn off format on save for c#
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == 'cs' then
        return
      end

      return {
        timeout_ms = 300,
        lsp_format = 'never',
      }
    end,

    formatters = {
      csharpier = {
        command = 'csharpier',
        stdin = false,
        args = { 'format', '$FILENAME' },
      },
    },

    formatters_by_ft = {
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },

      html = { 'prettierd' },
      css = { 'prettierd' },
      json = { 'prettierd' },

      yaml = { 'prettierd', 'prettier' },
      yml = { 'prettierd', 'prettier' },

      markdown = { 'prettierd' },

      lua = { 'stylua' },
      sh = { 'shfmt' },

      cs = { 'csharpier' },
      csharp = { 'csharpier' },
    },
  },
}
