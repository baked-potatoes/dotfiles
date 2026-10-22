return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = {
      ensure_installed = { "lua", "vim", "javascript", "html", "vimdoc", "typescript", "css", "json", "bash", "c", "python", "go" },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
  }
}
