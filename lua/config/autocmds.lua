-- Auto-change local window directory to current file's directory
local lcd_group = vim.api.nvim_create_augroup('AutoLcd', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = lcd_group,
  callback = function()
    if vim.bo.buftype == '' then
      vim.cmd('lcd %:p:h')
    end
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})