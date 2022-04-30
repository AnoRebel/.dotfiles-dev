-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/
--
-- MAPPINGS
require "custom.mappings"

-- NOTE: the 4th argument in the map function is be a table i.e options but its most likely un-needed so dont worry about it

-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1 -- 0 | 1

-- local api = vim.api
-- local folding = require("custom.folding")
-- local current_window = api.nvim_get_current_win()
--
-- api.nvim_set_option("nofoldenable", true)
-- api.nvim_set_option("foldlevel", 99)
-- api.nvim_set_option("fillchars", "fold:\\")
-- api.nvim_set_option('foldtext', folding.CustomFoldText())
-- api.nvim_win_set_option(current_window, 'foldmethod', "expr")
-- api.nvim_win_set_option(current_window, 'foldepxr', folding.GetPotionFold(api.nvim_eval("v:lnum")))
