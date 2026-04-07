return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    vim.diagnostic.config({ virtual_text = false, update_in_insert = false })
    require("tiny-inline-diagnostic").setup()
  end,
}
