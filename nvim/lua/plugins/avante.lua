return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- IMPORTANT: never set "*"
  build = vim.fn.has("win32") ~= 0
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",

    -- optional but recommended
    "hrsh7th/nvim-cmp",
    "zbirenbaum/copilot.lua",

    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },

  opts = {
    provider = "copilot", -- easiest setup
  },

  keys = {
    { "<leader>aa", function() require("avante.api").ask() end, desc = "Avante Ask", mode = { "n", "v" } },
    { "<leader>ae", function() require("avante.api").edit() end, desc = "Avante Edit", mode = "v" },
    { "<leader>ar", function() require("avante.api").refresh() end, desc = "Avante Refresh" },
  },
}
