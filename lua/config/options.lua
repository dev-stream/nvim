-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.backup = false
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- LF not CRLF
vim.opt.fileformats = "unix,dos"
vim.opt.swapfile = false -- Currently trying other vim Distros

if vim.env.MSYSTEM == "UCRT64" then
  -- msys2 posix environment !!
  vim.opt.shell = "bash"
  vim.opt.shellcmdflag = "--login -c" -- `-i` interactive gives issues while installing plugins.

  -- Tested `which bash` and `ll` custom `ls` alias in ~/.bashrc
  vim.opt.shellxquote = "("
  vim.opt.shellxescape = "^"

  vim.opt.shellquote = ""
  vim.opt.shellpipe = "2>&1| tee"
  vim.opt.shellredir = ">%s 2>&1"
  vim.opt.shellslash = true -- Unfortunately it gives issues with the Obsidian plugin
end
