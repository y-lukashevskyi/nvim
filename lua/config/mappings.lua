local function merge_ops(...)
	local result = {}
	for i = 1, select("#", ...) do
		local t = select(i, ...)
		if type(t) == "table" then
			for k, v in pairs(t) do
				result[k] = v
			end
		end
	end
	return result
end


local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts);
vim.keymap.set({ 'n', 'i', 'v' }, '\x1b[115;9u', '<cmd> w <CR>', opts);

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', merge_ops(opts, { desc = "Move to left window" }))
vim.keymap.set('n', '<C-j>', '<C-w>j', merge_ops(opts, { desc = "Move to lower window" }))
vim.keymap.set('n', '<C-k>', '<C-w>k', merge_ops(opts, { desc = "Move to upper window" }))
vim.keymap.set('n', '<C-l>', '<C-w>l', merge_ops(opts, { desc = "Move to right window" }))

--vim.keymap.set("n", "<Leader>er", "<cmd> e . <CR>", merge_ops( opts, { desc = "Open Oil at project root"}))
--vim.keymap.set("n", "<Leader>e", "<cmd>edit %:p:h<CR>", merge_ops(opts, {desc = "Open Oil in PWD"}))

vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<cr>", merge_ops(opts, { desc = "Focus Explorer on Current File" }))

vim.keymap.set("n", "<leader>th", function()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	require("telescope.builtin").colorscheme({
		enable_preview = true,
		layout_config = {
			width = 0.3,
			height = 0.4,
		},
		attach_mappings = function(bufnr, map)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(bufnr)
				if selection then
					vim.cmd("colorscheme " .. selection.value)
					local theme_file =
						vim.fn.stdpath("config") .. "/.theme"
					local f = io.open(theme_file, "w")
					if f then
						f:write(selection.value)
						f:close()
					end
				end
			end)
			return true
		end,
	})
end, merge_ops(opts, { desc = "Theme picker (persistent)" }))

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", merge_ops(opts, { desc = "Find files" }))
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", merge_ops(opts, { desc = "Live grep" }))
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", merge_ops(opts, { desc = "Recent files" }))

vim.keymap.set("n", "<leader>gd", "<cmd>CodeDiff<cr>", merge_ops(opts, { desc = "Code diff" }))

-- LSP (buffer-local, set on attach)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local o = { buffer = ev.buf, noremap = true, silent = true }
		vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, vim.tbl_extend("force", o, { desc = "Go to definition" }))
		vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, vim.tbl_extend("force", o, { desc = "Go to declaration" }))
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, vim.tbl_extend("force", o, { desc = "Find references" }))
		vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, vim.tbl_extend("force", o, { desc = "Go to implementation" }))
		vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, vim.tbl_extend("force", o, { desc = "Hover docs" }))
		vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, vim.tbl_extend("force", o, { desc = "Rename symbol" }))
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", o, { desc = "Code action" }))
		vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, vim.tbl_extend("force", o, { desc = "Line diagnostics" }))
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", o, { desc = "Prev diagnostic" }))
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", o, { desc = "Next diagnostic" }))
	end,
})

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", merge_ops(opts, { desc = "Diagnostics (Trouble)" }))
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", merge_ops(opts, { desc = "Buffer diagnostics (Trouble)" }))
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", merge_ops(opts, { desc = "Quickfix (Trouble)" }))

-- Flash
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, merge_ops(opts, { desc = "Flash jump" }))
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, merge_ops(opts, { desc = "Flash treesitter" }))

-- Harpoon
vim.keymap.set("n", "<leader>ha", function() require("harpoon"):list():add() end, merge_ops(opts, { desc = "Harpoon add file" }))
vim.keymap.set("n", "<leader>hh", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, merge_ops(opts, { desc = "Harpoon menu" }))
vim.keymap.set("n", "<leader>1", function() require("harpoon"):list():select(1) end, merge_ops(opts, { desc = "Harpoon file 1" }))
vim.keymap.set("n", "<leader>2", function() require("harpoon"):list():select(2) end, merge_ops(opts, { desc = "Harpoon file 2" }))
vim.keymap.set("n", "<leader>3", function() require("harpoon"):list():select(3) end, merge_ops(opts, { desc = "Harpoon file 3" }))
vim.keymap.set("n", "<leader>4", function() require("harpoon"):list():select(4) end, merge_ops(opts, { desc = "Harpoon file 4" }))

-- Spectre
vim.keymap.set("n", "<leader>sr", function() require("spectre").open() end, merge_ops(opts, { desc = "Find & replace (Spectre)" }))
vim.keymap.set("n", "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, merge_ops(opts, { desc = "Replace current word (Spectre)" }))

-- Folds
vim.keymap.set("n", "<leader>zt", "za", merge_ops(opts, { desc = "Toggle fold" }))
vim.keymap.set("n", "<leader>zT", function()
	if vim.wo.foldlevel > 0 then vim.cmd("normal! zM") else vim.cmd("normal! zR") end
end, merge_ops(opts, { desc = "Toggle all folds" }))

-- Toggle line wrap
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>", merge_ops(opts, { desc = "Toggle line wrap" }))

-- Octo (GitHub PRs)
vim.keymap.set("n", "<leader>gPl", "<cmd>Octo pr list<cr>", merge_ops(opts, { desc = "List PRs" }))
vim.keymap.set("n", "<leader>gPs", "<cmd>Octo pr search<cr>", merge_ops(opts, { desc = "Search PRs" }))
vim.keymap.set("n", "<leader>gPr", "<cmd>Octo review start<cr>", merge_ops(opts, { desc = "Start review" }))
vim.keymap.set("n", "<leader>gPS", "<cmd>Octo review submit<cr>", merge_ops(opts, { desc = "Submit review" }))
vim.keymap.set({ "n", "v" }, "<leader>gPc", "<cmd>Octo comment add<cr>", merge_ops(opts, { desc = "Add review comment" }))

-- Quick commit
vim.keymap.set("n", "<leader>gc", function()
	vim.ui.input({ prompt = "Commit message: " }, function(msg)
		if not msg or msg == "" then return end
		vim.cmd("!git add . && git commit -m " .. vim.fn.shellescape(msg))
	end)
end, merge_ops(opts, { desc = "Git add & commit" }))

-- Git (buffer-local, set on gitsigns attach)
-- Note: actual gitsigns on_attach calls require("config.mappings").gitsigns_on_attach
local M = {}
M.gitsigns_on_attach = function(bufnr)
	local gs = require("gitsigns")
	local o = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set("n", "]h", gs.next_hunk, vim.tbl_extend("force", o, { desc = "Next hunk" }))
	vim.keymap.set("n", "[h", gs.prev_hunk, vim.tbl_extend("force", o, { desc = "Prev hunk" }))
	vim.keymap.set("n", "<leader>gp", gs.preview_hunk, vim.tbl_extend("force", o, { desc = "Preview hunk" }))
	vim.keymap.set("n", "<leader>gs", gs.stage_hunk, vim.tbl_extend("force", o, { desc = "Stage hunk" }))
	vim.keymap.set("n", "<leader>gr", gs.reset_hunk, vim.tbl_extend("force", o, { desc = "Reset hunk" }))
	vim.keymap.set("n", "<leader>gb", gs.blame_line, vim.tbl_extend("force", o, { desc = "Blame line" }))
end
return M
