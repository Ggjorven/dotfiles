local colourscheme = { theme = 'tokyonight' }

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function colourscheme.tokyonight()
    require(colourscheme.theme).setup({
        
    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function colourscheme.finish()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme(colourscheme.theme)
end

return colourscheme