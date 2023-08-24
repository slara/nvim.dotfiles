
-- set git files search to C-p
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = '[?] Find files in current git repository' })
vim.keymap.set('n', '<C-g>', require('telescope').extensions.repo.list, { desc = '[?] Find files in repository' })
vim.keymap.set('n', '<F20>', '<C-w>=')
vim.keymap.set('n', 'Y', 'yy')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')


-- Auto change dir
vim.o.autochdir = true

-- split order
vim.o.splitright = true
vim.o.splitbelow = true

-- Relative Number
vim.o.relativenumber = true

-- Open Tagbar
vim.keymap.set('n', '<C-t>', ':TagbarToggle<cr>')
