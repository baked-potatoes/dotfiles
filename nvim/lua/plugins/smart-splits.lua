return {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    lazy = false,
    keys = {
        -- Navigate Neovim splits / tmux panes
        { "<M-h>", function() require("smart-splits").move_cursor_left() end },
        { "<M-j>", function() require("smart-splits").move_cursor_down() end },
        { "<M-k>", function() require("smart-splits").move_cursor_up() end },
        { "<M-l>", function() require("smart-splits").move_cursor_right() end },

        -- Resize Neovim splits / tmux panes
        { "<C-M-h>", function() require("smart-splits").resize_left(5) end },
        { "<C-M-j>", function() require("smart-splits").resize_down(5) end },
        { "<C-M-k>", function() require("smart-splits").resize_up(5) end },
        { "<C-M-l>", function() require("smart-splits").resize_right(5) end },
    },
    dependencies = {
        {
            "smart-splits-nvim/backend-tmux",
            main = "smart-splits-backend-tmux",
        },
    },

    opts = {
        ignored_buftypes = { "quickfix", "prompt" },
        mux = {
            backend = vim.env.TMUX and "smart-splits-backend-tmux" or nil
        },
        move = {
            at_edge = "stop",
        },
        resize = {
            amount = 5,
        },
    },
}
