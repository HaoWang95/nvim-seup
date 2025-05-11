-- File: lua/custom/plugins/float-term.lua

local M = {}

function M.open()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:bd!<CR>', { buffer = buf })

  vim.fn.termopen(os.getenv 'SHELL')
  vim.cmd 'startinsert'
end

function M.setup()
  vim.api.nvim_create_user_command('FloatTerm', function()
    M.open()
  end, {})
end

return M
