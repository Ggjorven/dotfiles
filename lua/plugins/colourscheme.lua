local colourscheme = { theme = 'nord' }

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function colourscheme.nord()

end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function colourscheme.finish()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme(colourscheme.theme)
end

return colourscheme
