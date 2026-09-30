return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('nvim-treesitter').install({
        'bash', 'c', 'cpp', 'css', 'go', 'html', 'javascript', 'json',
        'latex', 'lua', 'python', 'regex', 'rust', 'scss', 'svelte',
        'tsx', 'typescript', 'typst', 'vim', 'vimdoc', 'vue',
      })

      require('treesitter-context').setup({
        max_lines = 1,
        separator = '-',
      })

      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      -- On the main branch, textobject keymaps must be set manually
      local select = require('nvim-treesitter-textobjects.select')
      for keys, query in pairs({
        aa = '@parameter.outer',
        ia = '@parameter.inner',
        af = '@function.outer',
        ['if'] = '@function.inner',
        ac = '@class.outer',
        ic = '@class.inner',
      }) do
        vim.keymap.set({ 'x', 'o' }, keys, function()
          select.select_textobject(query, 'textobjects')
        end, { desc = 'Select ' .. query })
      end

      local move = require('nvim-treesitter-textobjects.move')
      for keys, m in pairs({
        [']m'] = { 'goto_next_start', '@function.outer' },
        [']]'] = { 'goto_next_start', '@class.outer' },
        [']M'] = { 'goto_next_end', '@function.outer' },
        [']['] = { 'goto_next_end', '@class.outer' },
        ['[m'] = { 'goto_previous_start', '@function.outer' },
        ['[['] = { 'goto_previous_start', '@class.outer' },
        ['[M'] = { 'goto_previous_end', '@function.outer' },
        ['[]'] = { 'goto_previous_end', '@class.outer' },
      }) do
        vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
          move[m[1]](m[2], 'textobjects')
        end, { desc = m[1]:gsub('_', ' ') .. ' ' .. m[2] })
      end

      local swap = require('nvim-treesitter-textobjects.swap')
      vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end, { desc = 'Swap with next parameter' })
      vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end, { desc = 'Swap with previous parameter' })
    end,
  },
}
