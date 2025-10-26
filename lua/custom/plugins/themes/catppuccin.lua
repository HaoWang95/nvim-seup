return {
  'catppuccin/nvim',
  name = 'catppuccin',
  -- transparent_background = true,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      -- NOTE: Flavour can be `latte, frappe, macchiato, mocha`
      flavour = 'macchiato',
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
