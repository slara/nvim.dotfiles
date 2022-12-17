
-- set git files search to C-p
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = '[?] Find files in current git repository' })

-- Auto change dir
vim.o.autochdir = true

