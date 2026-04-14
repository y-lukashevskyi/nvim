require("config.lazy")
require("config.mappings")

vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = "n-v-c:block-blinkon500,i-ci-ve:ver25-blinkon500,r-cr-o:hor20-blinkon500"

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

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	signs = true,
	float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" } })
	end,
})

vim.opt.updatetime = 300

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.o.winbar = "%{%v:lua.require('config.winbar').get()%}"

vim.api.nvim_create_user_command('Pwf', function()
  local path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  vim.fn.setreg('+', path)
  vim.notify(path, vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('RestartConfig', function()
  vim.cmd('source $MYVIMRC')
  vim.notify('Config reloaded', vim.log.levels.INFO)
end, {})
