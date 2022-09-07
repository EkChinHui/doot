-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      -- ["<tab>"] = cmp.mapping {
      --     i = cmp.config.disable,
      --     c = function(fallback)
      --       fallback()
      --     end,
      -- },
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'zsh'      },
      { name = 'nvim_lsp' },
      { name = 'path'     },
      { name = 'luasnip'  },
     -- For ultisnips user.

      -- { name = 'ultisnips' },

      { name = 'buffer', keyword_length = 5 },
    }
})

require'lsp_signature'.setup({
    bind=true,
    handler_opts={
        border="rounded"
    }
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Setup lspconfig.
-- require('lspconfig')[%YOUR_LSP_SERVER%].setup {
--     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }

-- PYTHON
require'lspconfig'.pyright.setup{}
-- autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

-- C
require'lspconfig'.clangd.setup{
-- capabilities = default capabilities, with offsetEncoding utf-8
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    -- root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
}

-- LATEX
require'lspconfig'.texlab.setup({
    -- cmd = { "texlab" },
    -- filetypes = { "tex", "bib" },
    -- root_dir = function(fname)
    --       return util.root_pattern '.latexmkrc'(fname) or util.find_git_ancestor(fname)
    --     end,
    -- settings = {
    --   texlab = {
    --     auxDirectory = ".",
    --     bibtexFormatter = "texlab",
    --     build = {
    --       args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
    --       executable = "latexmk",
    --       forwardSearchAfter = false,
    --       onSave = false
    --     },
    --     chktex = {
    --       onEdit = false,
    --       onOpenAndSave = false
    --     },
    --     diagnosticsDelay = 300,
    --     formatterLineLength = 80,
    --     forwardSearch = {
    --       args = {}
    --     },
    --     latexFormatter = "latexindent",
    --     latexindent = {
    --       modifyLineBreaks = false
    --     }
    --   }
    -- },
    -- single_file_support = true
})


local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end


-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Rust
require'lspconfig'.rls.setup{}

-- Ruby
require'lspconfig'.solargraph.setup{}

--emmet
require'lspconfig'.emmet_ls.setup{
  filetypes = {"html", "css", "erb", "htmlerb", "hmtl.erb", ".html.erb", "eruby"}
}

-- tsserver
require'lspconfig'.tsserver.setup{
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
}


