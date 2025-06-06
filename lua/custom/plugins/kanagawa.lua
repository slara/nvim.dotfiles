return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  name = 'kanagawa',
  priority = 1000,
  config = function()
		require('kanagawa').setup({
			compile_path = vim.fn.stdpath('cache') .. '/kanagawa',
			compile_file_suffix = '_compiled',
			transparent = true,
			dimInactive = false,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
				variables = { italic = true },
				sidebars = { dark = 'dragon' },
			},
		})
		-- vim.cmd.colorscheme('kanagawa')
	end,
}
