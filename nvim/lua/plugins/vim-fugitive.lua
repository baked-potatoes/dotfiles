return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gblame" },
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (Fugitive)" },
            { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
            { "<leader>gb", "<cmd>Gblame<cr>", desc = "Git blame" },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "fugitive",
                callback = function(event)
                    vim.keymap.set("n", "q", "<cmd>close<cr>", {
                        buffer = event.buf,
                        silent = true,
                        desc = "Close Fugitive",
                    })
                end,
            })
        end,
    },
}
