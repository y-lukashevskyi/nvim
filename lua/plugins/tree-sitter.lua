return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "ruby", "html", "css", "json", "yaml" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
