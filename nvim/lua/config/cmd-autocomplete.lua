-- enable command-line completion menu
vim.opt.wildmenu = true

-- how completion behaves while typing
vim.opt.wildmode = "longest:full,full"

-- optional but recommended tweaks
vim.opt.wildignorecase = true   -- case-insensitive matching
vim.opt.wildignore = { "*.o", "*.obj", "*.pyc", "node_modules/*" }

vim.opt.wildoptions = "pum" -- popup menu instead of statusline list
