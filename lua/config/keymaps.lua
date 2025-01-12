-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- "<C-s>" already mapped to flash.nvim. So it can be used in neo-tree.nvim
-- vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>", { desc = "Save file" }) -- Don't need it

-- Enter command mode
vim.keymap.set({ "n", "v" }, ";", ":", { nowait = true, desc = " ; -> : " })
vim.keymap.set({ "n", "v" }, ":", ";", { nowait = true, desc = " : -> ; " })

-- Visual block mode
vim.keymap.set("n", "<C-q>", "<C-v>", { noremap = true })

-- Copy buffer content
-- :%yank or :%y

-- Visually select pasted or yanked text
vim.keymap.set("n", "gV", "`[v`]", { noremap = true, desc = "Visually select pasted or yanked text" })

-- Don't yank on delete char
vim.keymap.set("n", "x", '"_x', { silent = true })
vim.keymap.set("n", "X", '"_X', { silent = true })
vim.keymap.set("v", "x", '"_x', { silent = true })
vim.keymap.set("v", "X", '"_X', { silent = true })

-- Don't yank on visual paste
vim.keymap.set("v", "p", '"_dP', { silent = true })

vim.keymap.set("i", "<C-b>", "<C-O>^", { desc = "Move Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move End of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move Left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move Right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move Down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move Up" })

-- stylua: ignore
local command_mode_history_next = function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>" end
vim.keymap.set("c", "<C-n>", command_mode_history_next, { expr = true, noremap = true })
vim.keymap.set("c", "<C-j>", command_mode_history_next, { expr = true, noremap = true })
-- stylua: ignore
local command_mode_history_prev = function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>" end
vim.keymap.set("c", "<C-p>", command_mode_history_prev, { expr = true, noremap = true })
vim.keymap.set("c", "<C-k>", command_mode_history_prev, { expr = true, noremap = true })

-- Navigate buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

-- stylua: ignore
if vim.g.neovide then
  local silent = { silent = true, nowait = true, noremap = true }
  vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", silent)
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", silent)
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", silent)
  vim.keymap.set({ "i", "c" }, "<S-Insert>", "<C-R>+", silent)
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"
end
