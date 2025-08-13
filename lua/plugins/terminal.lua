return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			direction = "float", -- options: "horizontal", "vertical", "tab"
			float_opts = { border = "rounded" },
		})
	end,
}
