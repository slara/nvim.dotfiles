return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = '#6a6a6a' })
        end,
      })
      vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = '#6a6a6a' })
    end,
    opts = function()
      local has_fd = vim.fn.executable('fd') == 1 or vim.fn.executable('fdfind') == 1
      local has_lazygit = vim.fn.executable('lazygit') == 1

      return {
        picker = {
          enabled = true,
          ui_select = true,
        },
        indent = {
          enabled = true,
          char = '▏',
          hl = 'Comment',
          animate = { enabled = false },
          scope = {
            enabled = true,
            only_current = true,
            hl = 'SnacksIndentScope',
          },
        },
        notifier = { enabled = true },
        image = { enabled = false },
        lazygit = { enabled = has_lazygit },
        explorer = { enabled = has_fd },
      }
    end,
    config = function(_, opts)
      require('snacks').setup(opts)
      require('snacks.picker').setup()
    end,
    keys = function()
      local keys = {
        -- File pickers
        { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
        { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
        { '<leader>sG', function() Snacks.picker.grep({ dirs = { vim.fn.systemlist('git rev-parse --show-toplevel')[1] or vim.fn.getcwd() } }) end, desc = '[S]earch by [G]rep on Git Root' },
        { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
        { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
        { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
        { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
        { '<leader>?', function() Snacks.picker.recent() end, desc = '[?] Find recently opened files' },
        { '<leader><space>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
        { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Search in current buffer' },
        { '<C-p>', function() Snacks.picker.git_files() end, desc = 'Find files in git repo' },
        { '<C-g>', function() Snacks.picker.projects() end, desc = 'Find project repositories' },
      }

      if vim.fn.executable('lazygit') == 1 then
        table.insert(keys, { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' })
      end

      if vim.fn.executable('fd') == 1 or vim.fn.executable('fdfind') == 1 then
        table.insert(keys, { '<leader>fe', function() Snacks.explorer() end, desc = '[F]ile [E]xplorer' })
      end

      return keys
    end,
  },
}
