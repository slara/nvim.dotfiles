return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Colorscheme
  {
    'fenetikm/falcon',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'falcon'
    end,
    lazy = false,
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
}
