-- General Settings

local set = vim.opt

vim.g.mapleader = ' '
set.termguicolors = true
set.wrap = false
set.ruler = true
set.colorcolumn = "80"
set.hlsearch = false
set.incsearch = true
set.splitbelow = true
set.splitright = true
set.smarttab = true
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.showmode = false
set.number = true
set.relativenumber = true
set.errorbells = false
set.hidden = true
set.swapfile = false
set.undodir="~/.config/undodir"
set.completeopt = "menu,menuone,noselect"
set.mouse = "a"
set.tabstop=4
set.softtabstop=4
set.shiftwidth=4
set.cmdheight = 2
set.scrolloff=10
set.updatetime = 50
vim.cmd("colorscheme gruvbox-material")
set.clipboard="unnamedplus"
vim.g.loaded_matchparen = 1
-- vim.g.clipboard = {
--     'name': 'myClipboard',
--     'copy': { 
--        '+': ['', 'load-buffer', '-'],
--        '*': ['tmux', 'load-buffer', '-'],
    -- },
--     'paste': {
--        '+': ['tmux', 'save-buffer', '-'],
--        '*': ['tmux', 'save-buffer', '-'],
--     },
--     'cache_enabled': 1,
-- }
