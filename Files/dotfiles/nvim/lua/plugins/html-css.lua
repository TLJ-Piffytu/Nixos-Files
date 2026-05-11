return {
	{
		"Jezda1337/nvim-html-css",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("html-css").setup({
				enable_on = { "html", "jsx", "tsx", "vue", "svelte" },
				style_sheets = {
					"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
					-- Add local or remote stylesheets here
				},
			})
		end,
	},
	{
		"brianhuster/live-preview.nvim",
		config = function()
			require("live-preview").setup()
		end,
	}
}
