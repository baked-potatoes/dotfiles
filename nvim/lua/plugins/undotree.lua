return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",

    keys = {
      {
        "<leader>u",
        "<cmd>UndotreeToggle<CR>",
        desc = "UndoTree toggle",
      },
    },

    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffAutoOpen = 1
    end,
  },
}
