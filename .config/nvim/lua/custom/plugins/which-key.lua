local M = {}

local which_k = {
  setup = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
  },

  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {
    ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
  },
  mappings = {
    ["q"] = { "<cmd>q<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    [","] = { ":lua require('custom.plugins.telescope').code_actions()<cr>", "Code Actions" },
    ["D"] = { ":lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    ["e"] = { ":NvimTreeFocus <CR>", "Focus File" },
    ["h"] = { ":lua require('toggleterm').bottom_toggle() <CR>", "Horizontal Terminal" },
    ["v"] = { ":lua require('toggleterm').right_toggle() <CR>", "Vertical Terminal" },
    ["p"] = { ":Glow<CR>", "Glow" },
    ["W"] = { ":Telescope terms <CR>", "List and Select Open Terminals" },
    n = {
      name = "Misc and Package Info",
      -- { ":set nu! <CR>", "Toggle Line Number" },
      c = { ":lua require('package-info').hide()<CR>", "Package Info Hide" },
      s = { ":lua require('package-info').show()<CR>", "Package Info Show" },
      d = { ":lua require('package-info').delete()<CR>", "Package Info Delete" },
      u = { ":lua require('package-info').update()<CR>", "Package Info Update" },
      i = { ":lua require('package-info').install()<CR>", "Package Info Install" },
      r = { ":lua require('package-info').reinstall()<CR>", "Package Info Reinstall" },
      p = { ":lua require('package-info').change_version()<CR>", "Package Info Change Version" },
    },
    f = {
      name = "Telescope and Formatting",
      f = { ":Telescope find_files <CR>", "Find Files" },
      b = { ":Telescope buffers <CR>", "Buffers" },
      o = { ":Telescope oldfiles <CR>", "Old Files" },
      w = { ":Telescope live_grep <CR>", "Live Grep" },
      h = { ":Telescope themes <CR>", "Themes" },
      a = { ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find Hidden Files" },
      m = { ":lua vim.lsp.buf.formatting()<CR>", "Find Hidden Files" },
      p = { ":Telescope media_files<CR>", "Find Hidden Files" }
    },
    c = {
      name = "Telescope and Code Actions",
      m = { ":Telescope git_commits <CR>", "Git Commits" },
      a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
      h = { ":lua require('nvchad.cheatsheet').show() <CR>", "Cheatsheet" }
    },
    r = {
      name = "Misc and LSP rename",
      n = { ":set rnu! <CR>", "Toggle Relative Line Numbers" },
      a = { ":lua vim.lsp.buf.rename()<CR>", "LSP Rename" }
    },
    w = {
      name = "Terminal and LSP",
      -- { ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", "Tab Terminal" },
      a = { ":lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder" },
      l = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folders" },
      r = { ":lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder" }
    },
    s = {
      name = "Diagnostic",
      l = { ":lua vim.diagnostics.setloclist()<CR>", "LSP Set Loclist" }
    },
    t = {
      name = "Telescope and Toggle Terminal",
      e = { ":Telescope <CR>", "Telescope" },
      h = { ":Telescope themes <CR>", "Themes" },
      a = { ":ToggleTermToggleAll<CR>", "Toggle All Open Terminals" }
    },
    u = {
      name = "Undo Tree and NvChad Update",
      -- { ":UndotreeShow<CR>", "Undo Tree" },
      u = { ":NvChadUpdate", "Update NvChad" }
    },
    x = {
      name = "",
      -- { ":lua require('core.utils').close_buffer() <CR>", "Close Buffer" },
      d = { ":Trouble document_diagnostics<CR>", "Document Diagnostics" },
      l = { ":Trouble loclist<CR>", "Loclist" },
      w = { ":Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },
      q = { ":Trouble quickfix<CR>", "Quick Fix" },
      x = { ":Trouble<CR>", "Trouble(Pretty Diagnostics)" }
    },
    g = {
      name = "Git and Telescope",
      t = { ":Telescope git_status <CR>", "Git Status" },
      g = { ":lua require('toggleterm').gitui_toggle() <CR>", "Git UI" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
    },

    l = {
      name = "LSP and Lazygit",
      g = { ":lua require('toggleterm').lazygit_toggle() <CR>", "Lazygit" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      p = {
        name = "Peek",
        d = { "<cmd>lua require('custom.lsp.peek').Peek('definition')<cr>", "Definition" },
        t = { "<cmd>lua require('custom.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
        i = { "<cmd>lua require('custom.lsp.peek').Peek('implementation')<cr>", "Implementation" },
      },
    },
  },
}

M.setup = function()
  local which_key = require("which-key")

  which_key.setup(which_k.setup)

  local opts = which_k.opts
  local vopts = which_k.vopts

  local mappings = which_k.mappings
  local vmappings = which_k.vmappings

  which_key.register(mappings, opts)
  which_key.register({
    ["g"] ={
      name = "LSP",
      e = { ":lua vim.diagnostic.open_float()<CR>", "Floating Diagnostics" },
      R = { ":Trouble lsp_references<CR>", "LSP Reference" },
      r = { ":lua vim.lsp.buf.references()<CR>", "LSP References" },
      k = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      i = { ":lua vim.lsp.buf.implementation()<CR>", "LSP Implementation" },
      d = { ":lua vim.lsp.buf.definition()<CR>", "LSP Definitions" },
      D = { ":lua vim.lsp.buf.declaration()<CR>", "LSP Declaration" }
    }
  }, { mode = "n" })
  which_key.register(vmappings, vopts)
end

return M
