return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
	javascript = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	javascriptreact = { "prettier" },
	css = { "prettier" },
	vue = { "prettier" },
	html = { "prettier" },
	json = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
	lua = { "stylua" },
	python = { "isort", "black" }
      }
    })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format(
	{
	  lsp_fallback = true,
	  async = false,
	  timeout_ms = 1000,
	})
    end, {desc = "Format current buffer"})
  end
}
