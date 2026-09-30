-- [[ Setting options ]]
-- See `:help vim.o`

-- Line numbers (absolute on cursor line, relative elsewhere)
vim.o.number = true
vim.o.relativenumber = true

-- Mouse: enable everywhere, focus follows mouse for resizing, right-click extends selection
vim.o.mouse = 'a'
vim.o.mousefocus = true
vim.o.mousemodel = 'extend'

-- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.background = 'dark'

-- Falcon colorscheme settings (colorscheme will be set by plugin)
vim.g.falcon_background = 0
vim.g.falcon_inactive = 0

-- Split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Don't show mode in cmdline (lualine shows it)
vim.o.showmode = false

-- Keep lines visible above/below cursor
vim.o.scrolloff = 8
