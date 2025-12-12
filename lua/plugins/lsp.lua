local LSP = {}

local minimumSeverityToShow = vim.diagnostic.severity.WARN
local minimumTextSizeforAutocompletion = 2

local cppVersionFlag = "-std=c++23"
local cppWarningFlag = "-Wall"
local cppFiles = {
	"iostream"
}

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

	-- Add some CPP files
	vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	  pattern = {
		"/usr/include/*",
		"/usr/local/include/*",
		"*.tcc",
	  },
	  callback = function()
		vim.bo.filetype = "cpp"
	  end,
	})

	vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	  callback = function()
		local name = vim.fn.expand("%:t")  -- get the file name
		for _, f in ipairs(cppFiles) do
		  if name == f then
			vim.bo.filetype = "cpp"       -- force filetype
			break
		  end
		end
	  end
	})

	-- Add error jumping commands
	vim.api.nvim_create_user_command("NextError", function()
	  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, {})

	vim.api.nvim_create_user_command("PrevError", function()
	  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, {})

	-- Add keybinds for error jumping
	vim.keymap.set("n", "]e", function()
	  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { desc = "Next Error" })

	vim.keymap.set("n", "[e", function()
	  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { desc = "Previous Error" })
end

return LSP
