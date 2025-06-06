-- Configure diagnostics with virtual text
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",  -- Show source if multiple sources
    spacing = 4,         -- Spacing between text and virtual text
    prefix = "●",        -- Prefix for virtual text
    format = function(diagnostic)
      -- Limit virtual text length to avoid clutter
      local message = diagnostic.message
      if #message > 50 then
        return string.sub(message, 1, 47) .. "..."
      end
      return message
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,  -- Don't show diagnostics while typing
  severity_sort = true,      -- Sort by severity
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Optional: Configure diagnostic highlight colors (add this if you want custom colors)
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff6c6b", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ECBE7B", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#51afef", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#98be65", italic = true })
