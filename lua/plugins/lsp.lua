return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
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
        automatic_enable = false,
        ensure_installed = {
          "lua_ls",
          "eslint",
          "jsonls",
          "jedi_language_server",
          "ts_ls",
        },
      })

      -- Get capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Configure LSP servers using native vim.lsp.config
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
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
      })

      vim.lsp.config('eslint', {
        capabilities = capabilities,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro', 'htmlangular' },
        settings = {
          workingDirectories = { mode = "auto" }
        },
      })

      vim.lsp.config('jsonls', { capabilities = capabilities })
      vim.lsp.config('jedi_language_server', { capabilities = capabilities })

      -- Vue LS v3 requires ts_ls to load @vue/typescript-plugin and attach to .vue files
      local vue_language_server_path = vim.fn.stdpath('data')
        .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
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
      })

      vim.lsp.config('tailwindcss', {
        capabilities = capabilities,
        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
      })

      vim.lsp.config('vue_ls', {
        capabilities = capabilities,
      })

      -- Enable all configured servers
      vim.lsp.enable({ 'lua_ls', 'eslint', 'jsonls', 'jedi_language_server', 'ts_ls', 'tailwindcss', 'vue_ls' })

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

          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
      })

      -- Setup which-key groups
      local wk = require('which-key')
      wk.add({
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>g', group = '[G]it' },
        { '<leader>g_', hidden = true },
        { '<leader>h', group = 'More git' },
        { '<leader>h_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
      })
    end,
  },
}
