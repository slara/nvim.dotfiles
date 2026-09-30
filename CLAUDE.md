# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modular Neovim (0.12+) configuration built with Lua and managed by Lazy.nvim. It uses the native `vim.lsp.config` API, blink.cmp for completion, Snacks for pickers, and Treesitter on its `main` branch.

## Architecture

### Directory Structure
- `init.lua` - Entry point that loads core modules in sequence
- `lua/config/` - Core Neovim configuration
  - `options.lua` - Basic editor settings
  - `keymaps.lua` - Core key mappings (Space as leader and local leader)
  - `autocmds.lua` - Automatic commands (auto-lcd, yank highlight, Treesitter highlighting)
  - `diagnostics.lua` - `vim.diagnostic.config` and diagnostic colors
  - `lazy.lua` - Package manager setup
- `lua/plugins/` - Plugin specifications, one file per concern
  - `lsp.lua` - Language servers (single `servers` table) with Mason, plus lazydev
  - `completion.lua` - blink.cmp + LuaSnip
  - `treesitter.lua` - Parsers, context, and textobject keymaps
  - `snacks.lua` - Pickers and indent guides
  - `git.lua` - Fugitive, rhubarb, gitsigns
  - `formatting.lua` - conform (formatting) and nvim-lint (linting)
  - `editor.lua` - sleuth, which-key (and its group labels), autopairs, flash, oil, outline, tmux-navigator
  - `ui.lua` - Colorscheme, lualine, mini.icons
- `snippets/` - Custom VS Code-format snippets loaded by LuaSnip

### Plugin Management

Lazy.nvim imports every file in `lua/plugins/`:
```lua
{ import = 'plugins' }
```

Plugin files return Lua tables following Lazy.nvim's specification format. Prefer `opts`/`keys`/`event` over `config` functions, and lazy-load with `event`, `cmd`, `keys` or `ft` where possible.

## Key Configuration Patterns

### Adding a New Plugin
Add the spec to the `lua/plugins/` file for its concern, or create a new file there if none fits:
```lua
return {
  'plugin/repo',
  event = 'VeryLazy',
  opts = {
    -- configuration
  },
}
```

### LSP Server Configuration
Add an entry to the `servers` table in `lua/plugins/lsp.lua`:
- `bin` - executable that must be on PATH for the server to be enabled
- `needs` - runtimes required before Mason installs it (e.g. `{ 'node', 'npm' }`)
- `config` - passed to `vim.lsp.config` (capabilities are set globally via `'*'`)

### Keymap Convention
All keymaps include descriptions for which-key integration:
```lua
vim.keymap.set('n', '<leader>key', function() ... end, { desc = 'Description' })
```

## Important Technical Details

- **Leader Key**: Space
- **Local Leader**: Space
- **Package Manager**: Lazy.nvim (auto-installs)
- **LSP Management**: Mason + mason-lspconfig, native `vim.lsp.config` / `vim.lsp.enable`
- **Completion**: blink.cmp (sources: lazydev, lsp, path, snippets, buffer)
- **File Navigation**: Snacks picker; oil.nvim for directories
- **Formatting / Linting**: conform.nvim (`<leader>cf`), nvim-lint (ruff)
- **Syntax**: Treesitter `main` branch — highlighting is started by a `FileType` autocmd and textobject keymaps are set manually
- **Icons**: mini.icons, which also stands in for nvim-web-devicons

## Common Development Tasks

### Reloading Configuration
After making changes, restart Neovim or source the modified file:
```vim
:source %
```

### Managing Plugins
- `:Lazy` - Open Lazy.nvim interface
- `:Lazy sync` - Update all plugins
- `:Mason` - Manage LSP servers

### Picker Commands
- `<leader>sf` - Search files
- `<leader>sg` - Search by grep
- `<leader>sG` - Grep from git root
- `<leader>sh` - Search help
- `<C-p>` - Git files
- `<C-g>` - Projects

## Configuration Philosophy

1. **Modular**: Each concern in its own file
2. **Descriptive**: All mappings have descriptions
3. **Performance**: Lazy loading where appropriate
4. **Git-aware**: Many features respect git repository boundaries
5. **Convention**: Follows modern Neovim Lua patterns
