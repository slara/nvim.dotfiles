local function repo()
  local f = io.popen("basename `git rev-parse --show-toplevel` 2>&1")
  local s = assert(f:read('*a'))
  f:close()
  return s:match"^%s*(.*)":match"(.-)%s*$"
end

return { -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'filename'},
      lualine_c = {'branch', 'diff', 'diagnostics'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  },
}
