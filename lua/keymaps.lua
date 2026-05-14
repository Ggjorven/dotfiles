-- n = Normal = Default mode, navigating
-- i = Insert = Typing text
-- v = Visual + SelectText selected (includes Select mode)
-- x = Visual only text selected (excludes Select mode)

-- Shortcuts
-- vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^') -- Go to left of line -- Replaced by: '^'
-- vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_') -- Go to right of line -- Replaced by: '$'
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>") -- Basically Ctrl + A

-- Basic clipboard interaction
vim.keymap.set({"n", "x"}, "gy", "\"+y", { noremap = true, silent = true }) -- Copy
vim.keymap.set({"n", "x"}, "gp", "\"+P", { noremap = true, silent = true }) -- Paste

-- Saving
-- vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true }) -- Replaced by :w
-- vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true }) -- Replaced by :w
-- vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true }) -- Replaced by :w

-- Moving text
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Indent/unindent with Tab and Shift-Tab 
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Insert mode
-- vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true }) -- Replaced by Normal & Visual mode!

-- Make delete not yank into register/clipboard
-- vim.keymap.set('n', 'd', '"_d', { noremap = true }) -- Removed
-- vim.keymap.set('x', 'd', '"_d', { noremap = true }) -- Removed
