local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
    "savq/paq-nvim";
    "tpope/vim-commentary";
    "lewis6991/gitsigns.nvim";
    "nvim-lua/plenary.nvim";

    "neovim/nvim-lspconfig";

    -- cmp
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-nvim-lua";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-nvim-lsp-document-symbol";
    "L3MON4D3/LuaSnip";
    "saadparwaiz1/cmp_luasnip";
    "tamago324/cmp-zsh";
    "ray-x/lsp_signature.nvim";

    -- latex
    "lervag/vimtex";
    -- "dense-analysis/ale"'

    "ellisonleao/glow.nvim";
    {"ms-jpq/chadtree", branch="chad"};


    "nvim-treesitter/nvim-treesitter";
    "nvim-treesitter/playground";

    "nvim-telescope/telescope.nvim";
    "norcalli/nvim-colorizer.lua";
    -- "sirver/ultisnips";
    "tweekmonster/startuptime.vim";


    -- debuggers
    "mfussenegger/nvim-dap";
    "rcarriga/nvim-dap-ui";

    -- probation
    "AckslD/nvim-neoclip.lua"; -- figure out how to integrate this
    "mfussenegger/nvim-dap";
    "numtostr/FTerm.nvim";


    "folke/twilight.nvim";
    "folke/zen-mode.nvim";
    "folke/which-key.nvim";

    -- color themes
    -- TODO: find or configure telescope to select colorscheme
    "sainnhe/gruvbox-material";
    "sainnhe/sonokai";
    "sainnhe/edge";
    "sainnhe/everforest";
    "glepnir/zephyr-nvim";
    "folke/tokyonight.nvim";

}

-- Enable plugins
require'colorizer'.setup()
require'gitsigns'.setup()

-- Treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
      enable = false,
    -- enable = true,              -- false will disable the whole extension
   additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
      enable = false,
    -- enable = true,
    keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
    }
  },
  indent = {
      enable = true,
      -- enable = false,
      disable = {"python"}
  }
}


-- CHADtree
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap('n', '<leader>t', ":CHADopen<cr>", opts)
-- nnoremap <leader>l <cmd>call setqflist([])<cr>



-- telescope

-- require('neoclip').setup()
keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)


-- Fterm
require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

-- Example keybindings
local silent = { noremap = true, silent = true }
keymap('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', silent)
keymap('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', silent)


require("zen-mode").setup(
{
  window = {
    backdrop = 0.90, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
})

-- what is this?
-- local wk = require("which-key")

