vim.pack.add({
	-- Language specific
	{
        src = "https://github.com/mfussenegger/nvim-jdtls",
        name = "jdtls",
    },

	-- Debug plugins
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

-- Auto-open view
require("dap").listeners.after.event_initialized["dapui_config"] = function()
    require("dap-view").open()
end

-- Autoclose view
require("dap").listeners.before.event_terminated["dapui_config"] = function()
    require("dap-view").close()
end
require("dap").listeners.before.event_exited["dapui_config"] = function()
    require("dap-view").close()
end

-- JAVA
local bundles = {
    vim.fn.glob(
        vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        true
    ),
}

vim.list_extend(bundles, vim.split(
    vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true),
    "\n", { trimempty = true }
))

require("jdtls").start_or_attach({
    cmd = { "jdtls" },
    root_dir = vim.fs.root(0, { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }),
    settings = {
        java = {},
    },
    init_options = {
        bundles = bundles,
    },
    on_attach = function()
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()  -- auto-discovers main classes
    end,
})

----------------------------------------------
-- Configuration
----------------------------------------------
local dap = require("dap")

-- Adapter
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.exepath("codelldb"),
        args = { "--port", "${port}" },
    },
}

-- C/C++
dap.configurations.cpp = {
    {
        name    = "Launch (codelldb)",
        type    = "codelldb",
        request = "launch",
        program = function()
            local path = vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
            if path == "" or vim.fn.filereadable(path) == 0 then
                vim.notify("Invalid executable: " .. path, vim.log.levels.ERROR)
                return dap.ABORT
            end
            return path
        end,
        args        = {}, -- TODO Arguments parsing somehow without the args appearing before the executable text
        cwd         = "${workspaceFolder}"
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

-- JAVA
dap.configurations.java = {
    {
        name    = "Launch main class",
        type    = "java",
        request = "launch",
        mainClass = function()
            return vim.fn.input("Main class (e.g. com.example.Main): ")
        end,
        projectName = function()
            return vim.fn.input("Project name: ")
        end,
    },
    {
        -- ./gradlew run/test --debug-jvm
        name      = "Attach to Gradle (port 5005)",
        type      = "java",
        request   = "attach",
        hostName  = "localhost",
        port      = 5005,
    },
	{
		name     = "Gradle run --debug-jvm",
		type     = "java",
		request  = "attach",
		hostName = "localhost",
		port     = function()
			local co = coroutine.running()
			local cwd = vim.fn.getcwd()
			local gradlew = cwd .. "/gradlew"

			if vim.fn.filereadable(gradlew) == 0 then
				vim.notify("No gradlew found in " .. cwd, vim.log.levels.ERROR)
				return coroutine.yield()
			end

			vim.notify("Starting Gradle debug build...", vim.log.levels.INFO)

			local resumed = false
			local function check_line(line)
				if not resumed and line:match("Listening for transport dt_socket") then
					resumed = true
					coroutine.resume(co, 5005)
				end
			end

			vim.fn.jobstart({ gradlew, "run", "--debug-jvm" }, {
				cwd = cwd,
				on_stdout = function(_, data)
					for _, line in ipairs(data) do check_line(line) end
				end,
				on_stderr = function(_, data)
					for _, line in ipairs(data) do check_line(line) end
				end,
				on_exit = function(_, code)
					if code ~= 0 and not resumed then
						vim.schedule(function()
							vim.notify("Gradle exited with code " .. code .. " (never became ready)", vim.log.levels.ERROR)
						end)
					end
				end,
			})

			return coroutine.yield()
		end,
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
vim.keymap.set("n", "<leader>dq", "<cmd>DapTerminate<cr>", { desc = "Stop debugger" })
