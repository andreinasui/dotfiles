vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting for all buffers
    vim.g.disable_autoformat = true
  else
    vim.b.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
