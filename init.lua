require("config.lazy")
require("config.mappings")

vim.opt.clipboard = "unnamedplus"

-- Load saved theme or fall back to nord
local theme_file = vim.fn.stdpath("config") .. "/.theme"
local f = io.open(theme_file, "r")
if f then
	local theme = f:read("*l")
	f:close()
	vim.cmd("colorscheme " .. theme)
else
	vim.cmd("colorscheme nord")
end

vim.opt.number = true
vim.opt.relativenumber = true

vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	signs = true,
	float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

vim.opt.updatetime = 300
