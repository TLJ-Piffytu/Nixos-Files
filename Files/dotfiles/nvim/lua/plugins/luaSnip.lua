return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets"
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip").config.set_config({
			ext_opts = {
				[require("luasnip.util.types").insertNode] = {
					active = {
						hl_group = "LuasnipInsertNodeActive",
					},
					passive = {
						hl_group = "LuasnipInsertNodePassive",
					},
				},

				[require("luasnip.util.types").choiceNode] = {
					active = {
						hl_group = "LuasnipChoiceNodeActive",
					},
					passive = {
						hl_group = "LuasnipChoiceNodePassive",
					},
				},
			},
		})
	end
}
