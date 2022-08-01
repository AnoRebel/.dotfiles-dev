-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/
--
-- MAPPINGS
require "custom.mappings"

vim.cmd("au BufEnter * silent! setlocal foldlevel=99") -- Trying to fix ufo closing all folds on escape insert mode
