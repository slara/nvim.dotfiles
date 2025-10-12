-- Mason for LSP server management
return {
  {
    'mason-org/mason.nvim',
    dependencies = {
      'neovim/nvim-lspconfig', -- Provides server definitions
      'mason-org/mason-lspconfig.nvim',
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
          "vue_ls"
        },
      })

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

          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
      })

      -- Configure LSP servers
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' } },
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
        ts_ls = {
          filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
        },
      }

      -- Setup each server
      for server_name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
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
