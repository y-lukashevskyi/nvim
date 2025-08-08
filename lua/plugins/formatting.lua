return {
	"stevearc/conform.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local conform = require("conform")

		SAVE_OPTS = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		}

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
			},
			format_on_save = SAVE_OPTS,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format(SAVE_OPTS)
		end)
	end,
}
