return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				typescript = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				typescriptreact = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				javascriptreact = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				json = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				css = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				html = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				yaml = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				ruby = { "rubocop" },
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_format = "fallback",
			},
			formatters = {
				prettierd = {
					require_cwd = true,
				},
				prettier = {
					require_cwd = true,
				},
				rubocop = {
					require_cwd = true,
				},
			},
		})
	end,
}
