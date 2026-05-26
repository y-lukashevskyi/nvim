return {
	"akinsho/git-conflict.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		default_mappings = true, -- co/ct/cb/c0 to choose ours/theirs/both/none, [x/]x to jump
	},
}
