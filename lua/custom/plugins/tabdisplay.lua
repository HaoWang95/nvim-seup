return {
  'akinsho/bufferline.nvim',
  version = '*',
  config = function()
    require('bufferline').setup {
      options = {
        numbers = 'ordinal', -- Shows the tab numbers
        separator_style = 'slant',
        show_buffer_close_icons = true,
        show_close_icon = true,
      },
    }
  end,
}
