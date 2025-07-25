return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'zbirenbaum/copilot-cmp',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert'
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            if entry.source.name == "copilot" then
              vim_item.kind = ""
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            else
              local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              vim_item.kind = " " .. (strings[1] or "") .. " "
              vim_item.abbr = kind.abbr
            end
            
            vim_item.menu = ({
              copilot = "[Copilot]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-Y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }
        },
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'path'},
          { name = 'buffer'},
          { name = 'luasnip' },
        },
      }
    end,
  },
}
