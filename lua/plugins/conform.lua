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
      -- This luacheck can be ignored
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
      biome = {
        require_cwd = true,
      },
    },

    formatters_by_ft = {
      javascript = { 'prettierd', 'biome' },
      typescript = { 'prettierd', 'biome' },
      javascriptreact = { 'prettierd', 'biome' },
      typescriptreact = { 'prettierd', 'biome' },

      json = { 'prettierd', 'biome' },
      jsonc = { 'prettierd', 'biome' },

      css = { 'prettierd', 'biome' },
      html = { 'prettierd', 'biome' },
      markdown = { 'prettierd', 'biome' },
      yaml = { 'prettierd' },

      lua = { 'stylua' },
      sh = { 'shfmt' },

      cs = { 'csharpier' },
      csharp = { 'csharpier' },
    },
  },
}
