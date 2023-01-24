
-- set git files search to C-p
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = '[?] Find files in current git repository' })
vim.keymap.set('n', '<C-g>', require('telescope').extensions.repo.cached_list, { desc = '[?] Find files in repository' })
vim.keymap.set('n', 'Y', 'yy')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')


-- Auto change dir
vim.o.autochdir = true

-- Relative Number
vim.o.relativenumber = true


-- Python
require('lspconfig').pyright.setup{
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
}
