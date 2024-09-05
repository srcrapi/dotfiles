local colorscheme = "catppuccin-mocha"

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not is_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found")
	return
end

local function setLineNumberColors()
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#444550" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#3362b2", bold = true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#444550" })
end

setLineNumberColors()
