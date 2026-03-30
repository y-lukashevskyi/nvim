local M = {}

function M.get()
	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype

	if ft == "neo-tree" then
		return ""
	end

	local path = vim.fn.expand("%:p")
	local parts = vim.split(path, "/", { trimempty = true })
	local n = #parts

	local filename = parts[n] or vim.fn.expand("%:t")
	local dir = n >= 3 and table.concat({ parts[n - 2], parts[n - 1] }, "/") or (n >= 2 and parts[n - 1] or "")

	local icon, hl = "", nil
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if ok then
		local ext = vim.fn.expand("%:e")
		icon, hl = devicons.get_icon(parts[n], ext, { default = true })
		icon = icon .. " "
	end

	local modified = vim.bo[buf].modified and " %#DiagnosticWarn#●" or ""

	local dir_part = dir ~= "" and "  %#Comment#" .. dir or ""

	return " %#" .. (hl or "Normal") .. "#" .. icon .. "%#Normal#" .. filename .. modified .. dir_part
end

return M
