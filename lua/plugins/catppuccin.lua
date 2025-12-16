return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- load before everything else
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha

      transparent_background = false,

      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },
        which_key = true,
        gitsigns = true,
        neotree = true,
        telescope = true,
      },

      -- IMPORTANT PART 👇
      -- JSX / TSX tags are using Vim syntax groups (htmlTag),
      -- not Tree-sitter @tag captures.
      custom_highlights = function(colors)
        return {
          -- HTML / JSX tag names
          -- htmlTag = { fg = colors.none },
          -- htmlEndTag = { fg = colors.none },
          htmlTagName = { fg = colors.maroon },

          -- HTML / JSX attributes
          htmlArg = { fg = colors.teal },

          -- Attribute values / strings
          String = { fg = colors.green },
          htmlString = { fg = colors.green },

          -- Optional: make JSX delimiters slightly muted
          htmlTagN = { fg = colors.overlay1 },
        }
      end,
    }

    -- Apply the colorscheme
    vim.cmd.colorscheme 'catppuccin'
  end,
}
