-- ! source code in ~/.config/hypr/scripts/color_generation/templates/nvim !

local colorscheme = "sakura"

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not is_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found")
	return
end

local function setLineNumberColors()
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#444550" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#e2c46d", bold = true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#444550" })
end

setLineNumberColors()
