-- Install clangd for C/C++ highlighting
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = { "clangd" } 
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  signs = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})

-- Autocomplete
local cmp = require("cmp")

cmp.setup({
  completion = {
    keyword_length = 3,
    autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
  },
  sources = {
    {
      name = 'nvim_lsp',
      max_item_count = 8,
      entry_filter = function(entry)
        local label = entry:get_completion_item().label
        return not label:match("^__") and not label:match("^operator")
      end,
    },
    { name = 'buffer', max_item_count = 5 },
    { name = 'path', max_item_count = 3 },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
})

-- Set up clangd with capabilities
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=bundled",
    "--header-insertion=never",
  },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
  settings = {
    clangd = {
      fallbackFlags = { "-std=c++23", "-Wall" },
    },
  },
})

-- Keybindings 
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true })
