-- lua/plugins/ufo.lua
return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})

		vim.keymap.set("n", "zc", "zc", { noremap = true, silent = true }) -- close fold at cursor
		vim.keymap.set("n", "zo", "zo", { noremap = true, silent = true }) -- open fold at cursor
	end,
}
