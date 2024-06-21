return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    conceal = {
      enabled = false, -- can be toggled by commands
      min_length = 70, -- only conceal classes exceeding the provided length
      symbol = "+", -- only a single character is allowed
      highlight = { -- extmark highlight options, see :h 'highlight'
        fg = "#38BDF8",
      },
    },
  }
}
