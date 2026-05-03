return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon add file" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon menu" })

    vim.keymap.set("n", "<leader>q", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon slot 1" })

    vim.keymap.set("n", "<leader>w", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon slot 2" })

    vim.keymap.set("n", "<leader>e", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon slot 3" })

    vim.keymap.set("n", "<leader>r", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon slot 4" })
    vim.keymap.set("n", "<leader>hr", function()
        harpoon:list():clear()
        print("Harpoon cleared")
    end, { desc = "Clear Harpoon list" })
    vim.keymap.set("n", "<leader>h", function()
        local harpoon = require("harpoon")
        harpoon:list():remove()
        print("Removed current file from Harpoon")
    end, { desc = "Harpoon remove current file" })
end,
}
