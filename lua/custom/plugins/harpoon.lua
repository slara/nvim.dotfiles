return {
  'ThePrimeagen/harpoon',
  lazy= true,
  dependencies= { 'nvim-lua/plenary.nvim' },
  keys ={
    {"<leader><leader>", function()	end },
    {"<leader>a", function() require('harpoon.mark').add_file() end},
    --	{"<C-e>", function() require('harpoon.ui').toggle_quick_menu() end},

    {"<leader>fe", function() require('harpoon.ui').toggle_quick_menu() end},
  },
  config = function ()require("harpoon").setup({

    menu = {
      width = vim.api.nvim_win_get_width(0)-4,
    }
    })
  end
}
