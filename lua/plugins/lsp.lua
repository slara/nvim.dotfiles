-- Mason for LSP server management
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      -- Completely suppress lspconfig deprecation by overriding vim.deprecate
      local original_deprecate = vim.deprecate
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.deprecate = function(name, alternative, version, plugin, backtrace)
        -- Skip lspconfig framework deprecation warning
        if name and name:find('lspconfig', 1, true) then
          return
        end
        return original_deprecate(name, alternative, version, plugin, backtrace)
      end
      
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      })

      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "jsonls",
          "jedi_language_server",
          "ts_ls",
        },
      })

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
        },
      })

      -- Define diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Get capabilities for LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Setup keymaps on LSP attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          map('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')
          
          -- Diagnostic keymaps
          map('[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
          map(']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
          map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
          map('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
      })

      -- Get lspconfig (deprecation suppressed above, don't restore vim.deprecate)
      local lspconfig = require('lspconfig')

      -- Configure LSP servers
      local servers = {
        lua_ls = {
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
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" }
          }
        },
        jsonls = {},
        jedi_language_server = {},
        ts_ls = {},
      }

      -- Setup each server
      for server_name, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server_name].setup(config)
      end

      -- Setup which-key groups
      local wk = require('which-key')
      wk.add({
        {'<leader>c', group = '[C]ode'},
        {'<leader>c_', hidden = true},
        {'<leader>d', group = '[D]ocument'},
        {'<leader>d_', hidden = true},
        {'<leader>g', group = '[G]it'},
        {'<leader>g_', hidden = true},
        {'<leader>h', group = 'More git'},
        {'<leader>h_', hidden = true},
        {'<leader>r', group = '[R]ename'},
        {'<leader>r_', hidden = true},
        {'<leader>s', group = '[S]earch'},
        {'<leader>s_', hidden = true},
        {'<leader>w', group = '[W]orkspace'},
        {'<leader>w_', hidden = true},
      })
    end,
  },
}
