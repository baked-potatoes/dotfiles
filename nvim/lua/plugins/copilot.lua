return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "copilotlsp-nvim/copilot-lsp", -- optional; only needed for NES
  },
  config = function()
    require("copilot").setup({
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = "<C-j>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      nes = {
        enabled = false,
      },
    })
  end,
}
