return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
				end,
			})

			vim.lsp.config('lua_ls', {
				capabilities = capabilities,
				settings = {
					Lua = {
						format = {
							enable = true,
							defaultConfig = {
								indent_style = 'tab',
							},
						},
					},
				},
			})
			vim.lsp.config('pyright', {
				capabilities = capabilities
			})
			vim.lsp.enable('lua_ls', 'pyright')
		end,
	},
}
