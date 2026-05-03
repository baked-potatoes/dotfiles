return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",

    keys = {
      {
        "<leader>u",
        function()
          local was_open = vim.fn.bufwinnr("undotree") ~= -1

          vim.cmd.UndotreeToggle()

          -- focus only when opening
          if not was_open then
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "undotree" then
                vim.api.nvim_set_current_win(win)
                break
              end
            end
          end
        end,
        desc = "UndoTree toggle",
      },
    },

    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffAutoOpen = 1
    end,
  },
}
