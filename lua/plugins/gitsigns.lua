return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = function()
		require("gitsigns").setup({
			on_attach = require("config.mappings").gitsigns_on_attach,
		})
	end,
}
