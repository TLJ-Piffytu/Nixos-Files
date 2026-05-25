return {
	{
		'maxmx03/fluoromachine.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			local fm = require 'fluoromachine'
			local colors = nil

			fm.setup {
				glow = false,
				theme = 'retrowave',
				transparent = true,

				colors = function (c)
					colors = c
					return {}
				end,

				overrides = {
					['@type'] = { italic = false, bold = true },
					['@function'] = { italic = false, bold = false },
					['@comment'] = { italic = true },
					['@keyword'] = { italic = false },
					['@constant'] = { italic = false, bold = true },
					['@variable'] = { italic = false },
					['@field'] = { italic = true },
					['@parameter'] = { italic = true },
				}
			}

			vim.cmd.colorscheme 'fluoromachine'

			vim.api.nvim_set_hl(0, "LuasnipInsertNodeActive", {
				sp = colors.cyan,
				bold = true,
			})

			vim.api.nvim_set_hl(0, "LuasnipInsertNodePassive", {
				bg = colors.bgdark,
			})
		end
	}
}
