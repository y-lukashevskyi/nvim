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

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8

vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.pumheight = 10

-- Global indent default (filetype overrides below still apply)
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Flash yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restore last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

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

-- Auto-dismiss stale swap files: if the swap is older than the file on disk,
-- it's left over from a crash/kill, so delete it and edit anyway. Genuine
-- conflicts (live instance, or a newer swap with unsaved changes) still prompt.
vim.api.nvim_create_autocmd("SwapExists", {
	callback = function(args)
		local swap_time = vim.fn.getftime(vim.v.swapname)
		local file_time = vim.fn.getftime(args.file)
		if swap_time > -1 and file_time > swap_time then
			vim.v.swapchoice = "d"
		end
	end,
})

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
