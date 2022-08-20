local map = vim.keymap.set
local opts = { silent = true, noremap = true };
local function amap(mode, lhs, rhs)
  local mapd = vim.tbl_filter(function (x)
                  return x.lhs == lhs end, vim.api.nvim_get_keymap(mode))[1]
  if not mapd then return end
  map(mode, lhs, mapd.rhs..rhs)
end

map("n", "<leader>te", ":Telescope <CR>", opts)
map("n", "<leader>fp", ":Telescope media_files <CR>", opts)
map("n", "<leader>q", ":q <CR>", opts)

amap("n", "n", ":Beacon<CR>")
amap("n", "N", ":Beacon<CR>")
amap("n", "*", ":Beacon<CR>")
amap("n", "#", ":Beacon<CR>")

map("n", "zR", require("ufo").openAllFolds)
map("n", "zM", require("ufo").closeAllFolds)

-- LSP
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", function ()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
map("n", "<leader>li", ":LspInfo<CR>", opts)
map("n", "<leader>lI", ":Mason<CR>", opts)
map("n", "<leader>ll", ":lua vim.lsp.codelens.run()<CR>", opts)
map("n", "<leader>lpd", ":lua require('custom.lsp.peek').Peek('definition')<CR>", opts)
map("n", "<leader>lpt", ":lua require('custom.lsp.peek').Peek('typeDefinition')<CR>", opts)
map("n", "<leader>lpi", ":lua require('custom.lsp.peek').Peek('implementation')<CR>", opts)

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
map("n", "<leader>lb", ":Gitsigns toggle_current_line_blame<CR>");

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
map("n", "<F8>", ":SymbolsOutline<CR>", opts)

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
map("n", "<leader>ta", ":ToggleTermToggleAll<CR>", opts)
map("n", "<leader>v", ":lua require('toggleterm').right_toggle()<CR>", opts)
map("n", "<leader>h", ":lua require('toggleterm').bottom_toggle()<CR>", opts)
map("n", "<leader>gg", ":lua require('toggleterm').gitui_toggle()<CR>", opts)
map("n", "<leader>lg", ":lua require('toggleterm').lazygit_toggle()<CR>", opts)

-- Misc
map("i", "jk", "<ESC>", { silent = true, noremap = true })
map("n", "<C-a>", "ggVG<CR>", opts)
map("i", "<C-a>", "<ESC>ggVG<CR>", opts)
-- map("v", "<C-h>", ":%s/'<,'>/<>/gc")
-- Resize
map("n", "<A-Up>", ":resize +2<CR>", opts)
map("n", "<A-Down>", ":resize -2<CR>", opts)
map("n", "<A-Left>", ":vertical resize +2<CR>", opts)
map("n", "<A-Right>", ":vertical resize -2<CR>", opts)
