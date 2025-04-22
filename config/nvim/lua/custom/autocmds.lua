vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Hightlight yanked text",
  callback = function()
    vim.hl.on_yank { timeout = 400, on_visual = true, higroup = "Substitute" }
  end,
})
