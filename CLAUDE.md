# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modular Neovim configuration built with Lua and managed by Lazy.nvim. The configuration emphasizes modularity, performance, and developer experience with extensive LSP, Telescope, and Treesitter integration.

## Architecture

### Directory Structure
- `init.lua` - Entry point that loads core modules in sequence
- `lua/config/` - Core Neovim configuration
  - `options.lua` - Basic editor settings
  - `keymaps.lua` - Core key mappings (Space as leader)
  - `autocmds.lua` - Automatic commands
  - `lazy.lua` - Package manager setup
- `lua/plugins/` - Main plugin specifications
  - `lsp.lua` - Language server configuration with Mason
  - `completion.lua` - nvim-cmp completion setup
  - `telescope.lua` - Fuzzy finder configuration
  - `treesitter.lua` - Syntax highlighting and text objects
  - `git.lua` - Git integration plugins
  - `editor.lua` - Editor enhancement plugins
- `lua/custom/plugins/` - Additional custom plugins
- `after/plugin/` - Post-plugin load configuration

### Plugin Management

Uses Lazy.nvim with dual import paths:
```lua
{ import = 'plugins' }
{ import = 'custom.plugins' }
```

Plugin files return Lua tables following Lazy.nvim's specification format.

## Key Configuration Patterns

### Adding a New Plugin
Create a new file in `lua/custom/plugins/` returning a plugin specification:
```lua
return {
  {
    "plugin/repo",
    dependencies = { ... },
    config = function()
      require("plugin").setup({
        -- configuration
      })
    end,
  }
}
```

### LSP Server Configuration
LSP servers are managed by Mason and configured in `lua/plugins/lsp.lua`. The `servers` table defines which servers to install and their configurations.

### Keymap Convention
All keymaps include descriptions for which-key integration:
```lua
vim.keymap.set('n', '<leader>key', function() ... end, { desc = 'Description' })
```

## Important Technical Details

- **Leader Key**: Space
- **Local Leader**: \
- **Package Manager**: Lazy.nvim (auto-installs)
- **LSP Management**: Mason + mason-lspconfig
- **Completion**: nvim-cmp with multiple sources
- **File Navigation**: Telescope (heavily integrated)
- **Syntax**: Treesitter with incremental selection

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

### Telescope Commands
- `<leader>sf` - Search files
- `<leader>sg` - Search by grep
- `<leader>sh` - Search help
- `<C-p>` - Git files (custom mapping)

## Configuration Philosophy

1. **Modular**: Each concern in its own file
2. **Descriptive**: All mappings have descriptions
3. **Performance**: Lazy loading where appropriate
4. **Git-aware**: Many features respect git repository boundaries
5. **Convention**: Follows modern Neovim Lua patterns