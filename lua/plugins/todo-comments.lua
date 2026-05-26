return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {},
	keys = {
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
		{ "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
		{ "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
	},
}
