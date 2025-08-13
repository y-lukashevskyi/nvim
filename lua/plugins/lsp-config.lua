return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "html" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			for _, server in ipairs({ "tsserver", "lua_ls", "html" }) do
				lspconfig[server].setup({ capabilities = capabilities })
			end
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lspsaga").setup({ ui = { border = "rounded" } })

			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
			vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
			vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>")
			vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
			vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
			vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
			vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
			vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
		end,
	},
}
