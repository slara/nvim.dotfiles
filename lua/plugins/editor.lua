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

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '▏'},
      scope = {
        show_start = false,
        show_end = false
      }
    },
  },
}
