return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      picker = { enabled = true },
      indent = {
        enabled = true,
        char = '▏',
        scope = { enabled = true },
      },
      notifier = { enabled = true },
      lazygit = { enabled = true },
      explorer = { enabled = true },
    },
    keys = {
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

      -- Git
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },

      -- Explorer
      { '<leader>fe', function() Snacks.explorer() end, desc = '[F]ile [E]xplorer' },
    },
  },
}
