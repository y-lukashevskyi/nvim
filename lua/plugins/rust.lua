return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = true,
              check = { command = "clippy" },
              procMacro = { enable = true },
              inlayHints = {
                bindingModeHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = { enable = "skip_trivial" },
              },
            },
          },
          on_attach = function(_, bufnr)
            local map = function(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
            end
            map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust runnables")
            map("<leader>rt", function() vim.cmd.RustLsp("testables") end, "Rust testables")
            map("<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, "Rust expand macro")
            map("<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Rust open Cargo.toml")
            map("<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Rust parent module")
            map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover actions")
            map("<leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Code action")
          end,
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = { enabled = true },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
}
