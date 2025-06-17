return {
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = function()
      local jdtls = require 'jdtls'
      local home = vim.fn.expand '~'
      local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
      local root_dir = require('jdtls.setup').find_root(root_markers)

      if not root_dir then
        print '[jdtls] Not a Java project'
        return
      end

      local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
      local workspace_dir = home .. '/.local/share/eclipse/' .. project_name

      local config = {
        cmd = { 'jdtls', '-data', workspace_dir },
        root_dir = root_dir,
        settings = {
          java = {
            configuration = {
              updateBuildConfiguration = 'interactive',
            },
            format = {
              settings = {
                url = home .. '/.config/nvim/java-style.xml',
                profile = 'GoogleStyle',
              },
            },
            imports = {
              gradle = {
                enabled = true,
                wrapper = {
                  enabled = true,
                  checksums = {
                    {
                      sha256 = '*',
                      allowed = true,
                    },
                  },
                },
              },
            },
          },
        },
        init_options = {
          bundles = {},
        },
      }

      jdtls.start_or_attach(config)
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap',
    },
  },
}
