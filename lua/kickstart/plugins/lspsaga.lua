return {
  'glepnir/lspsaga.nvim',
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup {}
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'LSPSaga Hover Doc' })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
