-- Auto-change local window directory to current file's directory
local lcd_group = vim.api.nvim_create_augroup('AutoLcd', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = lcd_group,
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end
    local dir = vim.fn.expand('%:p:h')
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd.lcd(vim.fn.fnameescape(dir))
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

-- [[ Treesitter highlighting ]]
-- nvim-treesitter's main branch no longer enables highlighting; start it for any filetype with a parser
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterStart', { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
