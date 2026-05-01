return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      actions = {
        open_file = {
	  quit_on_open = false,
	  resize_window = true,
	},
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
      update_focused_file = {
        enable = true,
	update_root = false,
      }
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1
          and vim.bo.filetype == "NvimTree" then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
