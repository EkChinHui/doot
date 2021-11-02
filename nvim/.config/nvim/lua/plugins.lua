require "paq" {
    "savq/paq-nvim";
    "tpope/vim-commentary";
    "lewis6991/gitsigns.nvim";
    "nvim-lua/plenary.nvim";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/nvim-cmp";
    "neovim/nvim-lspconfig";
    "ellisonleao/glow.nvim";
    {"ms-jpq/chadtree", branch="chad"};
    "nvim-treesitter/nvim-treesitter";
    "nvim-telescope/telescope.nvim";
    "norcalli/nvim-colorizer.lua";
    "sirver/ultisnips";

    -- debuggers
    "mfussenegger/nvim-dap";
    "rcarriga/nvim-dap-ui";

    -- probation
    "AckslD/nvim-neoclip.lua";
    "mfussenegger/nvim-dap";
    "numtostr/FTerm.nvim";


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


    -- to test
    -- "ray-x/lsp_signature.nvim";
}

-- Enable plugins
require'colorizer'.setup()
require'gitsigns'.setup()

local dap = require'dap'
dap.configurations.c = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
-- require'dapui'.setup()

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
   additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
    }
  },
  indent = {
      enable = true
  }
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
       -- For `ultisnips` user.
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

     -- For ultisnips user.
      { name = 'ultisnips' },

      { name = 'buffer' },
    }
})

-- Setup lspconfig.
-- require('lspconfig')[%YOUR_LSP_SERVER%].setup {
--     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }


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
