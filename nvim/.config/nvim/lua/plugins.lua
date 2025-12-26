return {

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- LSP
  {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'hrsh7th/cmp-nvim-lsp'},
  {"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	build = "make install_jsregexp"
  };
  {'saadparwaiz1/cmp_luasnip'};
  {'hrsh7th/nvim-cmp',
      dependencies = { "rafamadriz/friendly-snippets" }
  };
  {'hrsh7th/cmp-buffer'};
  {'hrsh7th/cmp-path'};


  {
      'barrett-ruth/live-server.nvim',
      build = 'npm add -g live-server',
      cmd = { 'LiveServerStart', 'LiveServerStop' },
      config = true
  };
  'nvim-treesitter/nvim-treesitter',
  "folke/which-key.nvim",
}
