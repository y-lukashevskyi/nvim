return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "typescript",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
