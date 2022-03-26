-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/
--
-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>te", ":Telescope <CR>")
map("n", "<leader>fp", ":Telescope media_files <CR>")
map("n", "<leader>q", ":q <CR>")

-- LSP Manual mapping (Default fails)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>")
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>li", ":LspInfo<CR>")
map("n", "<leader>lI", ":LspInstallInfo<CR>")
map("n", "<leader>ll", ":lua vim.lsp.codelens.run()<CR>")
map("n", "<leader>lpd", ":lua require('custom.lsp.peek').Peek('definition')<CR>")
map("n", "<leader>lpt", ":lua require('custom.lsp.peek').Peek('typeDefinition')<CR>")
map("n", "<leader>lpi", ":lua require('custom.lsp.peek').Peek('implementation')<CR>")

-- Refactoring
map("x", "<leader>.", ":'<,'>Telescope lsp_range_code_actions<CR>") --lua vim.lsp.buf.range_code_action()
map("v", "<leader>.", ":'<,'>Telescope lsp_range_code_actions<CR>") --lua vim.lsp.buf.range_code_action()
map("n", "<leader>,", ":lua require('custom.plugins.telescope').code_actions()<CR>")

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
-- map("v", "<A-k>", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
-- map("v", "<A-j>", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map("x", "<A-j>", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
map("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
map("n", "<A-j>", ":move .+1<CR>==", { noremap = true, silent = true })
map("n", "<A-k>", ":move .-2<CR>==", { noremap = true, silent = true })
map("i", "<A-j>", "<Esc>:move .+1<CR>==gi", { noremap = true, silent = true })
map("i", "<A-k>", "<Esc>:move .-2<CR>==gi", { noremap = true, silent = true })

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
map("n", "<leader>v", ":lua require('toggleterm').right_toggle()<CR>", { noremap = true, silent = true })
map("n", "<leader>h", ":lua require('toggleterm').bottom_toggle()<CR>", { noremap = true, silent = true })
map("n", "<leader>gg", ":lua require('toggleterm').gitui_toggle()<CR>", { noremap = true, silent = true })
map("n", "<leader>lg", ":lua require('toggleterm').lazygit_toggle()<CR>", { noremap = true, silent = true })

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
