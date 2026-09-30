return {
  -- Colorscheme
  {
    'fenetikm/falcon',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('falcon')
    end,
  },

  -- Statusline. See `:help lualine.txt`
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- Icons
  {
    'nvim-mini/mini.icons',
    version = false,
    lazy = true,
    opts = {},
    -- Serve plugins that require nvim-web-devicons from mini.icons instead
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
