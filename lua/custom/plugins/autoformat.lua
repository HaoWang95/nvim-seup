return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = 'n',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,

    -- Format on save
    format_on_save = function(bufnr)
      -- skip special buffers
      if vim.bo[bufnr].buftype ~= '' then
        return
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = {
        -- c = true,
        -- cpp = true
      }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 1500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters = {
      markdownlint = {
        command = 'markdownlint-cli2',
        args = {
          '$FILENAME',
          '--fix',
        },
        stdin = false,
      },
      prettier_html = {
        command = 'prettier',
        args = { '--parser', 'html', '--stdin-filepath', '$FILENAME' },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua', stop_after_first = true },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black', stop_after_first = true },
      html = { 'prettier' },
      htmldjango = { 'djlint' },
      javascript = { 'prettier' },
      jsx = { 'prettier' },
      tsx = { 'prettier' },
      json = { 'prettier' },
      typescript = { 'prettier' },
      -- markdown = { 'prettier' },
      markdown = { 'markdownlint' },
      gotmpl = { 'prettier_html' },
      tmpl = { 'prettier_html' },
      template = { 'prettier_html' },
      ruby = { 'rufo' },
      eruby = { 'erb_format' },
      go = { 'gofmt' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      -- java = { 'google-java-format' },
    },
  },
}
