return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        window = {
          position = "vertical"
        },
        git = {
          use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
        },
      })
    end,
  }
}
