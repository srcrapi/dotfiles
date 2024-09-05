return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	requires = { { "nvim-lua/plenary.nvim" } },

	config = function()
		local harpoon = require("harpoon")
		local keymap = vim.keymap

		harpoon:setup()

		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
		keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window" })

		keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end)
		keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		keymap.set("n", "<C-s>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
