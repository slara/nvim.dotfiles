-- [[ Diagnostics ]]
-- Virtual text, signs and floats. See `:help vim.diagnostic.config()`
vim.diagnostic.config({
  virtual_text = {
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
    source = true,
    header = "",
    prefix = "",
  },
})

-- Diagnostic virtual text colors, reapplied when the colorscheme changes
local function set_diagnostic_hl()
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff6c6b", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ECBE7B", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#51afef", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#98be65", italic = true })
end
set_diagnostic_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("DiagnosticHighlights", { clear = true }),
  callback = set_diagnostic_hl,
})
