return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()

      -- add file
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon add file" })

      -- toggle menu
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon menu" })

      -- direct file jumps
      vim.keymap.set("n", "<leader>q", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>w", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>e", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>r", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<leader>hr", function()
	      local harpoon = require("harpoon")
	      harpoon:list():clear()
	      print("Harpoon cleared")
      end, { desc = "Clear Harpoon list" })
      vim.keymap.set("n", "<leader>h", function()
	      local harpoon = require("harpoon")
	      local list = harpoon:list()

	      local file = vim.api.nvim_buf_get_name(0)

	      if file == "" then
		      print("No file to remove")
		      return
	      end

	      list:remove(file)
      end, { desc = "Harpoon remove current file" })
	end,
  },
}
