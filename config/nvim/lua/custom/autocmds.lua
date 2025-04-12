vim.api.nvim_create_augroup("custom", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = "custom",
  desc = "Hightlight yanked text",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { timeout = 400, on_visual = true }
  end,
})
