-- Auto-change local window directory to current file's directory
local lcd_group = vim.api.nvim_create_augroup('AutoLcd', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = lcd_group,
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end

    local name = vim.api.nvim_buf_get_name(0)
    if name == '' or name:match('^%w[%w+.-]*://') then
      return
    end

    local dir = vim.fn.isdirectory(name) == 1 and name or vim.fn.fnamemodify(name, ':p:h')
    if dir ~= '' and vim.fn.isdirectory(dir) == 1 then
      vim.cmd('lcd ' .. vim.fn.fnameescape(dir))
    end
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
