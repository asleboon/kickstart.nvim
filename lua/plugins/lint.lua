return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        -- Docs
        markdown = { 'markdownlint' },

        -- Lua
        lua = { 'luacheck' },

        -- Shell
        sh = { 'shellcheck' },

        -- JS / TS
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },

        -- YAML
        yaml = { 'yamllint' },
        yml = { 'yamllint' },
      }

      -- MD013 Ignore warning for lines with more than 80 chars
      local markdownlint = lint.linters.markdownlint
      markdownlint.args = {
        '--disable',
        'MD013',
        '--',
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function(args)
          if not vim.bo[args.buf].modifiable then
            return
          end

          local bufname = vim.api.nvim_buf_get_name(args.buf)

          -- 👇 THIS IS THE FIX
          if bufname:match '/.github/workflows/.*%.ya?ml$' then
            return
          end

          lint.try_lint()
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname:match '/.github/workflows/.*%.ya?ml$' then
            lint.try_lint 'actionlint'
          end
        end,
      })
    end,
  },
}
