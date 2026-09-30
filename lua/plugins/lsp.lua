return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      local has = function(cmd)
        return vim.fn.executable(cmd) == 1
      end

      -- Vue LS v3 requires ts_ls to load @vue/typescript-plugin and attach to .vue files
      local vue_language_server_path = vim.fn.stdpath('data')
        .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

      -- Single source of truth for language servers:
      --   bin    executable that must be on PATH for the server to be enabled
      --   needs  runtimes required before Mason tries to install it
      --   config passed to vim.lsp.config (merged over nvim-lspconfig defaults)
      local node = { 'node', 'npm' }
      local servers = {
        lua_ls = {
          bin = 'lua-language-server',
          config = {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = {
                  disable = { 'missing-fields' },
                  globals = { 'vim' },
                },
              },
            },
          },
        },
        eslint = {
          bin = 'vscode-eslint-language-server',
          needs = node,
          config = {
            filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro', 'htmlangular' },
            settings = { workingDirectories = { mode = 'auto' } },
          },
        },
        jsonls = { bin = 'vscode-json-language-server', needs = node },
        jedi_language_server = { bin = 'jedi-language-server', needs = { 'python3' } },
        ts_ls = {
          bin = 'typescript-language-server',
          needs = node,
          config = {
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_language_server_path,
                  languages = { 'vue' },
                },
              },
            },
            filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
          },
        },
        tailwindcss = {
          bin = 'tailwindcss-language-server',
          needs = node,
          config = {
            filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
          },
        },
        vue_ls = { bin = 'vue-language-server', needs = node },
      }

      -- Mason must be set up first: it adds its bin directory to PATH
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })

      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

      local ensure_installed, enabled = {}, {}
      for name, server in pairs(servers) do
        if vim.iter(server.needs or {}):all(has) then
          table.insert(ensure_installed, name)
        end
        if server.config then
          vim.lsp.config(name, server.config)
        end
        if has(server.bin) then
          table.insert(enabled, name)
        end
      end

      require('mason-lspconfig').setup({
        automatic_enable = false,
        ensure_installed = ensure_installed,
      })
      vim.lsp.enable(enabled)

      -- Remove Neovim's global gr* defaults so `gr` (references) doesn't wait for timeoutlen
      for _, key in ipairs({ 'gra', 'grn', 'grr', 'gri', 'grx', 'grt' }) do
        pcall(vim.keymap.del, { 'n', 'x' }, key)
      end

      -- Setup keymaps on LSP attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')
          map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
          map('gI', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
          map('<leader>D', function() Snacks.picker.lsp_type_definitions() end, 'Type [D]efinition')
          map('<leader>ds', function() Snacks.picker.lsp_symbols() end, '[D]ocument [S]ymbols')
          map('<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, '[W]orkspace [S]ymbols')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          map('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')
        end,
      })
    end,
  },

  -- Lua type definitions for editing this config (also a blink.cmp source)
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
