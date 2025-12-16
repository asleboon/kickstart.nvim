return {
  {
    -- Fuzzy Finder (files, LSP, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',

      { -- optional native FZF sorter
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },

    config = function()
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'

      -- -------------------------
      -- Telescope setup
      -- -------------------------
      telescope.setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Load extensions safely
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      -- -------------------------
      -- Keymap helper
      -- -------------------------
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { desc = desc })
      end

      -- =========================
      -- FIND / SEARCH
      -- =========================

      map('<leader>ff', function()
        local ok = pcall(builtin.git_files, { show_untracked = true })
        if not ok then
          builtin.find_files()
        end
      end, 'Find files (git-aware)')

      map('<leader>fg', builtin.live_grep, 'Live grep (project)')
      map('<leader>fw', builtin.grep_string, 'Grep word under cursor')
      map('<leader>fb', builtin.buffers, 'Find buffers')
      map('<leader>fr', builtin.resume, 'Resume last picker')
      map('<leader>f.', builtin.oldfiles, 'Recent files')
      map('<leader>fd', builtin.diagnostics, 'Diagnostics')
      map('<leader>fh', builtin.help_tags, 'Help tags')
      map('<leader>fk', builtin.keymaps, 'Keymaps')

      map('<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, 'Neovim config files')

      -- In-buffer search
      map('<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, 'Search in current buffer')

      map('<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, 'Live grep (open files)')

      -- =========================
      -- LSP / CODE NAVIGATION
      -- =========================

      -- Goto
      map('<leader>ld', builtin.lsp_definitions, 'Goto Definition')
      map('<leader>li', builtin.lsp_implementations, 'Goto Implementation')
      map('<leader>lr', builtin.lsp_references, 'Goto References')
      map('<leader>lt', builtin.lsp_type_definitions, 'Goto Type Definition')

      -- Symbols
      map('<leader>ls', builtin.lsp_document_symbols, 'Document Symbols')
      map('<leader>lS', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

      -- LSP actions
      map('<leader>ln', vim.lsp.buf.rename, 'Rename Symbol')
      map('<leader>la', vim.lsp.buf.code_action, 'Code Action')

      -- Diagnostics
      map('<leader>le', vim.diagnostic.open_float, 'Line Diagnostics')
      map('<leader>lq', vim.diagnostic.setloclist, 'Diagnostics List')

      -- Optional: direct motions (muscle memory)
      map('gd', vim.lsp.buf.definition, 'Goto Definition (direct)')
      map('gr', vim.lsp.buf.references, 'Goto References (direct)')
    end,
  },
}
