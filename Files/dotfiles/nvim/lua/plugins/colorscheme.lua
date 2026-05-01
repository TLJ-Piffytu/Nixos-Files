return {
    {
        'maxmx03/fluoromachine.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
         local fm = require 'fluoromachine'

         fm.setup {
            glow = false,
            theme = 'retrowave',
            transparent = true,

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
        end
    }
}
