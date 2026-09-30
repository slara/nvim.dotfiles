return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>h', group = 'Git [H]unks' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
      },
    },
  },

  -- Auto-close brackets and quotes
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Jump anywhere on screen with `s`
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = { search = { enabled = false } },
    },
    -- stylua: ignore
    keys = {
      { 's', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end, desc = 'Flash' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },

  -- Edit directories like buffers
  {
    'stevearc/oil.nvim',
    -- Not lazy-loaded so it can take over `nvim <dir>`
    lazy = false,
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {},
  },

  -- Symbol outline sidebar
  {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<C-t>', '<cmd>Outline<cr>', desc = 'Toggle Outline' },
    },
    opts = {},
  },

  -- Seamless <C-hjkl> navigation between Neovim splits and tmux panes
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', desc = 'Navigate left' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>', desc = 'Navigate down' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>', desc = 'Navigate up' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>', desc = 'Navigate right' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Navigate to previous pane' },
    },
  },
}
