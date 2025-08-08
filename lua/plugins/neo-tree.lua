return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	opts = {
		visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
		hide_dotfiles = false,
		hide_gitignored = true,
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("nvim-web-devicons").setup({ default = true })
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>")
	end,
}
