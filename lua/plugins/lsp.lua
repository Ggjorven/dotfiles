local LSP = {}

local minimumSeverityToShow = vim.diagnostic.severity.WARN
local minimumTextSizeforAutocompletion = 2

local cppVersionFlag = "-std=c++23"
local cppWarningFlag = "-Wall"

---------------------------------------------------------------------------
-- Setups
---------------------------------------------------------------------------
function LSP.mason_lspconfig()
    -- Install clangd for C/C++ highlighting
    require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = { "clangd" } 
    })
end

function LSP.cmp()
    local cmp = require("cmp")

    require("cmp").setup({
        completion = {
            keyword_length = minimumTextSizeforAutocompletion,
            autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        },
        sources = {
            {
                -- Removes __definitions from internal gcc and clang
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
        -- Autocomplete shortcuts
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function LSP.finish()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Diagnostics
    vim.diagnostic.config({
        virtual_text = {
            severity = {
                min = minimumSeverityToShow,
            },
        },
        signs = {
            severity = {
                min = minimumSeverityToShow,
            },
        },
        underline = {
            severity = {
                min = minimumSeverityToShow,
            },
        },
    })

    -- Set up clangd with capabilities
    vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=bundled",
            "--header-insertion=never",
        },
        root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
        settings = {
            clangd = {
                fallbackFlags = { cppVersionFlag, cppWarningFlag },
            },
        },
    })
    vim.lsp.enable('clangd')

    -- Keybindings 
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true })
end

return LSP
