return {
  polish = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.json", "*.css", "*.scss", "*.html", "*.md" },
      callback = function() vim.lsp.buf.format() end,
    })
  end,
}
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
