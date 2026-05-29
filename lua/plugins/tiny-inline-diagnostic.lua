return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup()
    -- Apply AFTER setup(): tiny-inline reconfigures vim.diagnostic on setup, so
    -- the float caps must be set last or max_width gets clobbered.
    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = false,
      float = {
        max_width = 80,
        border = "rounded",
        source = true,
      },
    })
  end,
}
