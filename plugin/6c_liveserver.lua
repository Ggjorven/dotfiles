vim.pack.add({
	{
		src = "https://git.barrettruth.com/barrettruth/live-server.nvim",
		name = "live-server"
	}
})

----------------------------------------------
-- Configuration
----------------------------------------------
vim.g.live_server = {
	port = 3000,
	browser = true,
}
