vim.pack.add({
	{
		src = "https://github.com/mfussenegger/nvim-dap",
		name = "dap",
	},
	{
		src = "https://github.com/theHamsta/nvim-dap-virtual-text",
		name = "dap-virtual-text",
	},
	{
		src = "https://github.com/igorlfs/nvim-dap-view",
		name = "dap-view",
	}
})

----------------------------------------------
-- Setup
----------------------------------------------
require("nvim-dap-virtual-text").setup({
})

require("dap-view").setup({
	winbar = {
		show = true,
		sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
        -- Must be one of the sections declared above
        default_section = "console",
		base_sections = {
			breakpoints = { label = "Breakpoints", keymap = "B" },
			scopes = { label = "Scopes", keymap = "S" },
			exceptions = { label = "Exceptions", keymap = "E" },
			watches = { label = "Watches", keymap = "W" },
			threads = { label = "Threads", keymap = "T" },
			repl = { label = "REPL", keymap = "R" },
			sessions = { label = "Sessions", keymap = "K" },
			console = { label = "Console", keymap = "C" },
		},
	}
})

----------------------------------------------
-- Configuration
----------------------------------------------
local dap = require("dap")

-- C/C++
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.exepath("codelldb"),
        args = { "--port", "${port}" },
    },
}
dap.configurations.cpp = {
    {
        name    = "Launch (codelldb)",
        type    = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd            = "${workspaceFolder}",
        stopOnEntry    = false,
        args           = {},
    },
    {
        name      = "Attach to process",
        type      = "codelldb",
        request   = "attach",
        pid       = require("dap.utils").pick_process,
        cwd       = "${workspaceFolder}",
    },
}
dap.configurations.c = dap.configurations.cpp

-- RUST
dap.configurations.rust = {
    {
        name    = "Launch (codelldb)",
        type    = "codelldb",
        request = "launch",
        program = function()
            -- Tries to find the binary from `cargo metadata`
            local meta = vim.fn.system("cargo metadata --no-deps --format-version 1")
            local ok, decoded = pcall(vim.json.decode, meta)
            if ok and decoded.target_directory then
                local name = decoded.packages[1].targets[1].name
                return decoded.target_directory .. "/debug/" .. name
            end
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd         = "${workspaceFolder}",
        stopOnEntry = false
    },
}

----------------------------------------------
-- Keymaps
----------------------------------------------
vim.keymap.set("n", "<leader>dt", "<cmd>DapViewToggle<cr>", { desc = "Open debugger" })
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "Continue (or start) debugger" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<cr>", { desc = "Watch variable" })
vim.keymap.set("n", "<leader>dx", "<cmd>DapTerminate<cr>", { desc = "Stop debugger" })
