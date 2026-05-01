return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		priority = 1000,
		config = function()
			require("nvim-treesitter.config").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = { "lua", "python", "javascript", "typescript" },
			})
		end,
	},
}
