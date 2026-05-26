return {
  'nvim-treesitter/nvim-treesitter',
  -- Pin to master: this config uses the classic `nvim-treesitter.configs` API.
  -- The repo's default branch is now `main` (a rewrite that removed that API),
  -- so without this an update would silently break the config.
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "ruby", "html", "css", "json", "yaml", "rust", "toml" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
