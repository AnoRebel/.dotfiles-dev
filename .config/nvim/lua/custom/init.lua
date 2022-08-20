-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/
--
-- MAPPINGS
require "custom.mappings"

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

vim.cmd("au BufEnter * silent! setlocal foldlevel=99") -- Trying to fix ufo closing all folds on escape insert mode

-- Don't autocomment new lines
local bcon, _ = pcall(vim.api.nvim_get_autocmds, { group = "MyCursorLineGroup" })
if not bcon then
  vim.api.nvim_create_augroup("MyCursorLineGroup", {})
end
vim.api.nvim.nvim_create_autocmd("WinEnter", {
  group = "MyCursorLineGroup",
  pattern = "*",
  desc = "Hide cursor line on inactive windows",
  command = "setlocal cursorline",
})
vim.api.nvim.nvim_create_autocmd("WinLeave", {
  group = "MyCursorLineGroup",
  pattern = "*",
  desc = "Hide cursor line on inactive windows",
  command = "setlocal nocursorline",
})
