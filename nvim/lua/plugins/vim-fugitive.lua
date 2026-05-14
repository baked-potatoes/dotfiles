return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gblame" },
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (Fugitive)" },
            { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
            { "<leader>gb", "<cmd>Gblame<cr>", desc = "Git blame" },
        },
    },
}
