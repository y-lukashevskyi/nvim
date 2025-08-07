return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "javascript", "typescript", "lua" },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    })
  end,
}
