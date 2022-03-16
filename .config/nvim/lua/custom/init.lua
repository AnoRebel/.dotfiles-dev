-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>te", ":Telescope <CR>")
map("n", "<leader>fp", ":Telescope media_files <CR>")
map("n", "<leader>q", ":q <CR>")

-- Refactoring
map("x", "<leader>.", ":'<,'>Telescope lsp_range_code_actions<CR>") --lua vim.lsp.buf.range_code_action()
map("v", "<leader>.", ":'<,'>Telescope lsp_range_code_actions<CR>") --lua vim.lsp.buf.range_code_action()

-- Trouble (Better Diagnostics and Errors)
map("n", "<leader>xx", ":Trouble<CR>", {silent = true, noremap = true})
map("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", {silent = true, noremap = true})
map("n", "<leader>xd", ":Trouble document_diagnostics<CR>", {silent = true, noremap = true})
map("n", "<leader>xl", ":Trouble loclist<CR>", {silent = true, noremap = true})
map("n", "<leader>xq", ":Trouble quickfix<CR>", {silent = true, noremap = true})
map("n", "gR", ":Trouble lsp_references<CR>", {silent = true, noremap = true})

-- Move lines Up and Down
-- map("x", "<C-Up>", ":move '<-2<CR>gv-gv", { noremap = true })
-- map("x", "<C-Down>", ":move '>+1<CR>gv-gv", { noremap= true })
map("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })

-- Save file by CTRL-S
map("i", "<C-s>", "<ESC> :w<CR>", { noremap = true, silent = true })
-- map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Keep visual mode indenting
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Make word uppercase
map("n", "<A-u>", "viwU<ESC>", { noremap = true })
map("i", "<A-u>", "<ESC>viwUi", { noremap = true })

-- Undo Tree
map("n", "<leader>u", ":UndotreeShow<CR>", { noremap = true })

-- Symbol Outline
map("n", "<F8>", ":SymbolsOutline<CR>")

-- Glow
map("n", "<leader>p", ":Glow<CR>")

-- NOTE: the 4th argument in the map function is be a table i.e options but its most likely un-needed so dont worry about it
