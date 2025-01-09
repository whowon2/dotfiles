return {
	{ 
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require("mini.statusline").setup()
			require("mini.git").setup()
			require("mini.starter").setup()
			require("mini.pairs").setup()
			require("mini.comment").setup()
			require("mini.icons").setup()
			require("mini.hipatterns").setup()
			require("mini.files").setup()
			require("mini.fuzzy").setup()

			vim.keymap.set("n", "<leader>e", MiniFiles.open(), { desc = "Fil[e]s" })
		end
	}
}
