return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		local prettier = { "prettierd", "prettier", stop_after_first = true }

		require("conform").setup({
			formatters_by_ft = {
				javascript = prettier,
				typescript = prettier,
				typescriptreact = prettier,
				javascriptreact = prettier,
				json = prettier,
				css = prettier,
				html = prettier,
				yaml = prettier,
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
