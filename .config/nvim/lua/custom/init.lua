-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/
--
-- MAPPINGS
local map = require("core.utils").map
local opts = { silent = true, noremap = true }

map("n", "<leader>te", ":Telescope <CR>", opts)
map("n", "<leader>fp", ":Telescope media_files <CR>", opts)
map("n", "<leader>q", ":q <CR>", opts)

-- Flutter tools
map("n", "<leader>tf", ":Telescope flutter <CR>", opts)
map("n", "<leader>to", ":FlutterOutlineToggle<CR>", opts)

-- Todo-comments
map("n", "<leader>tq", ":TodoQuickFix<CR>", opts)
map("n", "<leader>td", ":TodoTelescope<CR>", opts)

-- Trouble (Better Diagnostics and Errors)
map("n", "<leader>xx", ":Trouble<CR>", opts)
map("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", opts)
map("n", "<leader>xd", ":Trouble document_diagnostics<CR>", opts)
map("n", "<leader>xl", ":Trouble loclist<CR>", opts)
map("n", "<leader>xq", ":Trouble quickfix<CR>", opts)
map("n", "gR", ":Trouble lsp_references<CR>", opts)

-- Move lines Up and Down
-- map("x", "<C-Up>", ":move '<-2<CR>gv-gv", { noremap = true })
-- map("x", "<C-Down>", ":move '>+1<CR>gv-gv", { noremap= true })
-- map("v", "<A-k>", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
-- map("v", "<A-j>", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("n", "<A-j>", ":move .+1<CR>==", opts)
map("n", "<A-k>", ":move .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:move .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:move .-2<CR>==gi", opts)

-- Save file by CTRL-S
map("i", "<C-s>", "<ESC> :w<CR>", opts)
-- map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Keep visual mode indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Make word uppercase
map("n", "<A-u>", "viwU<ESC>", { noremap = true })
map("i", "<A-u>", "<ESC>viwUi", { noremap = true })

-- Undo Tree
map("n", "<leader>u", ":UndotreeShow<CR>", { noremap = true })

-- Symbol Outline
map("n", "<F8>", ":SymbolsOutline<CR>")

-- Glow
map("n", "<leader>p", ":Glow<CR>", opts)

-- Term nav
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })
map("i", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
map("i", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
map("i", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
map("i", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })
map("t", "jk", "<C-\\><C-n>", { silent = true })
map("n", "<leader>ta", ":ToggleTermToggleAll<CR>")
map("n", "<leader>v", ":lua require('toggleterm').right_toggle()<CR>", opts)
map("n", "<leader>h", ":lua require('toggleterm').bottom_toggle()<CR>", opts)
map("n", "<leader>gg", ":lua require('toggleterm').gitui_toggle()<CR>", opts)
map("n", "<leader>lg", ":lua require('toggleterm').lazygit_toggle()<CR>", opts)

-- Misc
map("i", "kj", "<ESC>") -- { noremap = true, silent = true }
-- Resize
map("n", "<A-Up>", ":resize +2<CR>")
map("n", "<A-Down>", ":resize -2<CR>")
map("n", "<A-Left>", ":vertical resize +2<CR>")
map("n", "<A-Right>", ":vertical resize -2<CR>")

-- NOTE: the 4th argument in the map function is be a table i.e options but its most likely un-needed so dont worry about it

-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1

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
