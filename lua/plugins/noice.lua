local noice = {}

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function noice.noice()
    require('noice').setup({
        cmdline = {
            view = "cmdline_popup",
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 2,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
        },
    })
end

function noice.notify()
    require('notify').setup({

    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function noice.finish()
    vim.notify = require("notify")
end

return noice