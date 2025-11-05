local mason = {}

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function mason.mason()
    require('mason').setup({
        
    })
end

function mason.tools()
	require('mason-tool-installer').setup({
		-- ensure_installed = { "lazygit" }
	})
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function mason.finish()
    
end

return mason
