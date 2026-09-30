return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      local function set_hl()
        vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = '#6a6a6a' })
      end
      set_hl()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('SnacksIndentScopeHl', { clear = true }),
        callback = set_hl,
      })
    end,
    opts = {
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
      image = { enabled = false },
    },
    config = function(_, opts)
      require('snacks').setup(opts)
      -- Needed for ui_select: without it vim.ui.select stays the builtin
      require('snacks.picker').setup()
    end,
    keys = {
      -- File pickers
      { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
      { '<leader>sG', function() Snacks.picker.grep({ dirs = { Snacks.git.get_root() or vim.fn.getcwd() } }) end, desc = '[S]earch by [G]rep on Git Root' },
      { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
      { '<leader>?', function() Snacks.picker.recent() end, desc = '[?] Find recently opened files' },
      { '<leader><space>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
      { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Search in current buffer' },
      { '<C-p>', function() Snacks.picker.git_files() end, desc = 'Find files in git repo' },
      { '<C-g>', function() Snacks.picker.projects() end, desc = 'Find project repositories' },
    },
  },
}
