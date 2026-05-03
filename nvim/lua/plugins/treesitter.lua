return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = {
      ensure_installed = { "lua", "vim", "javascript", "html", "vimdoc", "typescript", "css", "json", "bash", "c", "python", "help", "go" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  }
}
