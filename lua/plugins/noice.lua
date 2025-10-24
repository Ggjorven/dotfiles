require("noice").setup({
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
