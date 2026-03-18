# Neovim Config

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Structure

```
init.lua              -- Entry point: options, diagnostics, theme persistence
lua/config/lazy.lua   -- Plugin manager bootstrap
lua/config/mappings.lua -- All keybindings
lua/plugins/          -- Plugin specs (one per file)
```

## LSP & Formatting

**Language servers** (auto-installed via Mason): `ts_ls`, `ruby_lsp`, `lua_ls`, `eslint`

**Formatting** (conform.nvim, format-on-save):
- JS/TS/JSX/TSX/JSON/CSS/HTML/YAML — prettierd / prettier
- Ruby — rubocop
- Lua — stylua

**Linting**: nvim-lint

## Plugins

| Category | Plugin |
|---|---|
| File explorer | neo-tree |
| Fuzzy finder | telescope |
| Navigation | harpoon, flash |
| Completion | nvim-cmp + LuaSnip |
| Treesitter | nvim-treesitter |
| Git | gitsigns, codediff |
| Diagnostics | trouble |
| Search & replace | spectre |
| UI | noice, lualine, indent-blankline, which-key |
| Editing | autopairs, ts-autotag, Comment.nvim |
| Themes | nord (default), persisted via `.theme` file |

## Key Bindings

Leader key: `\` (default)

| Key | Action |
|---|---|
| `<C-s>` | Save |
| `<leader>e` | Focus file explorer |
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>th` | Theme picker (persistent) |
| `<leader>l*` | LSP actions (d=definition, r=references, n=rename, a=code action, etc.) |
| `<leader>xx` | Toggle diagnostics (Trouble) |
| `<leader>ha` / `<leader>hh` | Harpoon add / menu |
| `<leader>1-4` | Harpoon slots |
| `s` / `S` | Flash jump / treesitter |
| `<leader>sr` | Find & replace (Spectre) |
| `<leader>g*` | Git actions (p=preview, s=stage, r=reset, b=blame) |
| `]h` / `[h` | Next / prev git hunk |
| `]d` / `[d` | Next / prev diagnostic |

## Setup

```sh
# Requires Neovim >= 0.10
# Plugins install automatically on first launch
nvim
```
