-- Key Bindings

local keymap = vim.api.nvim_set_keymap
local opts = { noremap=true }
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)

keymap('n', '<c-s>', ':update<CR>', {noremap=true, silent=true})
keymap('v', '<c-s>', '<c-c>:update<CR>', {noremap=true, silent=true})
keymap('i', '<c-s>', '<c-o>:update<CR>', {noremap=true, silent=true})

keymap('n', 'Y', 'y$', opts)

keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', 'J', 'mzJ`z', opts)

-- Shift lines
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)
keymap('i', '<C-j>', '<esc>:m .+1<CR>==a', opts)
keymap('i', '<C-k>', '<esc>:m .-2<CR>==a', opts)
keymap('n', '<leader>j', ':m .+1<CR>==', opts)
keymap('n', '<leader>k', ':m .-2<CR>==', opts)

-- paste last thing yanked not deleted
keymap('n', ',p', '"0p', opts)
keymap('n', ',P', '"0P', opts)

keymap('n', '<leader>z', ':ZenMode<CR>', opts)
