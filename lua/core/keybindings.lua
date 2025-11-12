-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', { noremap = true, silent = true }) -- copy
vim.keymap.set({'n', 'x'}, 'gp', '"+P', { noremap = true, silent = true }) -- paste

-- Saving
-- Insert mode: exit insert mode, then save
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Normal mode: just save
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Visual mode (optional, if you want to save while text is selected)
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })

-- Moving text
-- Normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Visual mode
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Indent/unindent with Tab and Shift-Tab 
-- Normal mode
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })

-- Visual mode
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true })

-- Make delete not yank into register/clipboard
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('x', 'd', '"_d', { noremap = true })
