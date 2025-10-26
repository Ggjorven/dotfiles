local dap = {}

---------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------
function dap.dap_virtual_text()
    require('nvim-dap-virtual-text').setup({
        
    })
end

function dap.mason_dap()
    require('mason-nvim-dap').setup({
		ensure_installed = { "cppdbg" },
		automatic_installation = true,
		handlers = {
			function(config)
				require("mason-nvim-dap").default_setup(config)
			end,
		}, 
    })
end

function dap.dapui()
    require('dapui').setup({
        
    })
end

---------------------------------------------------------------------------
-- Logic
---------------------------------------------------------------------------
function dap.finish()
	local ui = require("dapui")	

	-- Configurations
	require("dap").configurations = {
		c = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = false,
				MIMode = "lldb",
			},
			{
				name = "Attach to lldbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "lldb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/lldb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		},
	}

	-- Making the UI open on debugging
	vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

	require("dap").listeners.before.attach.dapui_config = function()
		ui.open()
	end
	require("dap").listeners.before.launch.dapui_config = function()
		ui.open()
	end
	require("dap").listeners.before.event_terminated.dapui_config = function()
		ui.close()
	end
	require("dap").listeners.before.event_exited.dapui_config = function()
		ui.close()
	end

	-- Keymappings
	vim.keymap.set("n", "<leader>dt", require("dap").toggle_breakpoint, { desc = "Toggle Breakpoint", noremap = true, silent = true })
	vim.keymap.set("n", "<leader>dc", require("dap").continue,          { desc = "Continue",          noremap = true, silent = true })
	vim.keymap.set("n", "<leader>di", require("dap").step_into,         { desc = "Step Into",         noremap = true, silent = true })
	vim.keymap.set("n", "<leader>do", require("dap").step_over,         { desc = "Step Over",         noremap = true, silent = true })
	vim.keymap.set("n", "<leader>du", require("dap").step_out,          { desc = "Step Out",          noremap = true, silent = true })
	vim.keymap.set("n", "<leader>dr", require("dap").repl.open,         { desc = "Open REPL",         noremap = true, silent = true })
	vim.keymap.set("n", "<leader>dl", require("dap").run_last,          { desc = "Run Last",          noremap = true, silent = true })
	vim.keymap.set("n", "<leader>db", require("dap").list_breakpoints,  { desc = "List Breakpoints",  noremap = true, silent = true })
	vim.keymap.set("n", "<leader>de", function()
	  require("dap").set_exception_breakpoints({ "all" })
	end, { desc = "Set Exception Breakpoints", noremap = true, silent = true })

	vim.keymap.set("n", "<leader>dq", function()
	  require("dap").terminate()
	  require("dapui").close()
	  require("nvim-dap-virtual-text").toggle()
	end, { desc = "Terminate Debugger", noremap = true, silent = true })
end

return dap

