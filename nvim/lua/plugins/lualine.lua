return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- ✅ adapts to rose-pine

        icons_enabled = true,

        -- cleaner, modern separators (fits your setup)
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },

        globalstatus = true, -- one statusline (cleaner look)
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1, } },

        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
