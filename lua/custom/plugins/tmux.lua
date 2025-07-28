return {
  {
    'aserowy/tmux.nvim',
    config = function()
      require('tmux').setup({
        copy_sync = {
          enable = false,
        },
        navigation = {
          enable_default_keybindings = true,
          persist_zoom = false,
          cycle_navigation = true,
        },
        resize = {
          enable_default_keybindings = true,
          resize_step_x = 1,
          resize_step_y = 1,
        },
      })
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'roxma/vim-tmux-clipboard',
    lazy = false,
  },
}
