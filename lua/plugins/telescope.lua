return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules/",
						"dist/",
						"build/",
						"yarn.lock",
						"package%-lock%.json",
						"%.min%.js",
						"%.min%.css",
						"coverage/",
						"tmp/",
						"log/",
						"%.log",
						"vendor/",
						"bin/",
						"%.sqlite3",
						"db/schema%.rb",
						"%.gem",
						"public/assets/",
						".git/",
					},
				},
			})

			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
