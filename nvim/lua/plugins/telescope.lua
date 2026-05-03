return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    keys = {
      -- files
      {
        "<leader>pf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Project Files",
      },

      -- git files
      {
          "<C-p>",
          function()
              local ok = pcall(require("telescope.builtin").git_files)
              if not ok then
                  require("telescope.builtin").find_files()
              end
          end,
          desc = "Git Files",
      },

      -- grep (your style, preserved)
      {
        "<leader>ps",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Project Search",
      },

      -- 🔥 keymaps picker (replaces which-key)
      {
        "<leader>fk",
        function()
          require("telescope.builtin").keymaps({
            layout_strategy = "horizontal",
            layout_config = { preview_width = 0.5 },
          })
        end,
        desc = "Find Keymaps",
      },
    },

    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules" },

          -- layout
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          sorting_strategy = "ascending",

          -- visuals
          winblend = 10,

          border = true,
          borderchars = {
              "━", "┃", "━", "┃",
              "┏", "┓", "┛", "┗",
          },

          -- icons
          prompt_prefix = "   ",
          selection_caret = "➤ ",
        },
      })

      telescope.load_extension("fzf")

      -- 🎨 Rose Pine Moon highlight fixes
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#6e6a86", bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
    end,
  },
}
