-- -- Customize None-ls sources
--
-- ---@type LazySpec
-- return {
--   "nvimtools/none-ls.nvim",
--   opts = function(_, opts)
--     -- opts variable is the default configuration table for the setup function call
--     local null_ls = require "null-ls"
--
--     -- Check supported formatters and linters
--     -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
--     -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--
--     -- Only insert new sources, do not replace the existing ones
--     -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
--     opts.sources = require("astrocore").list_insert_unique(opts.sources, {
--       -- Set a formatter
--       null_ls.builtins.formatting.stylua,
--       null_ls.builtins.formatting.prettier,
--     })
--   end,
-- }

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "json",
          "jsonc",
          "css",
          "scss",
          "less",
          "html",
          "yaml",
          "markdown",
          "markdown.mdx",
        },
      },
      null_ls.builtins.formatting.stylua,
    })

    opts.on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format {
              bufnr = bufnr,
              filter = function(c) return c.name == "null-ls" end, -- force Prettier over tsserver
            }
          end,
        })
      end
    end
  end,
}
