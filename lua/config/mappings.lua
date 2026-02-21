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

--vim.keymap.set("n", "<Leader>er", "<cmd> e . <CR>", merge_ops( opts, { desc = "Open Oil at project root"}))
--vim.keymap.set("n", "<Leader>e", "<cmd>edit %:p:h<CR>", merge_ops(opts, {desc = "Open Oil in PWD"}))
