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

-- Spectre
map("n", "<leader>S", ":lua require('spectre').open()<CR>", opts)
-- search current word
map("n", "<leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>", opts)
map("v", "<leader>s", ":lua require('spectre').open_visual()<CR>", opts)
--  search in current file
map("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<CR>", opts)
-- run command :Spectre

-- Trouble (Better Diagnostics and Errors)
map("n", "<leader>xx", ":Trouble<CR>", opts)
map("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", opts)
map("n", "<leader>xd", ":Trouble document_diagnostics<CR>", opts)
map("n", "<leader>xl", ":Trouble loclist<CR>", opts)
map("n", "<leader>xq", ":Trouble quickfix<CR>", opts)
map("n", "gR", ":Trouble lsp_references<CR>", opts)

-- Toggle Line Blame
map("n", "<leader>lb", ":Gitsigns toggle_current_line_blame<CR>", opts);

-- Telescope keymaps
map("n", "<leader>km", ":Telescope keymaps<CR>", opts);

-- GoTo
map("n", "gpd", ":lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true });
map("n", "gpi", ":lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true });
map("n", "gP", ":lua require('goto-preview').close_all_win()<CR>", { noremap = true });
-- Only set if you have telescope installed
map("n", "gpr", ":lua require('goto-preview').goto_preview_references()<CR>", { noremap = true });

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
map("n", "<C-a>", "ggVG<CR>")
map("i", "<C-a>", "<ESC>ggVG<CR>")
-- map("v", "<C-h>", ":%s/'<,'>/<>/gc")
-- Resize
map("n", "<A-Up>", ":resize +2<CR>")
map("n", "<A-Down>", ":resize -2<CR>")
map("n", "<A-Left>", ":vertical resize +2<CR>")
map("n", "<A-Right>", ":vertical resize -2<CR>")
