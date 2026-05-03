vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Movement (shared with tmux via vim-tmux-navigator)
vim.keymap.set("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true })

-- Resize (MATCH tmux: Alt + Shift + hjkl)
vim.keymap.set("n", "<C-M-h>", "<cmd>vertical resize -5<CR>", { silent = true })
vim.keymap.set("n", "<C-M-l>", "<cmd>vertical resize +5<CR>", { silent = true })
vim.keymap.set("n", "<C-M-j>", "<cmd>resize +5<CR>", { silent = true })
vim.keymap.set("n", "<C-M-k>", "<cmd>resize -5<CR>", { silent = true })
