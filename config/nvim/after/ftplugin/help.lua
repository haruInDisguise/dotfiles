local setlocal = vim.opt_local

setlocal.expandtab = true
setlocal.textwidth = 78
setlocal.tabstop = 4
setlocal.shiftwidth = 4
setlocal.number = true
setlocal.relativenumber = true

vim.keymap.set("n", "<c-j>", "<cmd>helpclose<cr>", {})

