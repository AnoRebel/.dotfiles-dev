local present, nvimtree = pcall(require, "nvim-tree")

if not present then
   return
end

local function start_telescope(telescope_mode)
  local node = nvimtree.lib.get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

local function telescope_find_files(_)
  start_telescope "find_files"
end
local function telescope_live_grep(_)
  start_telescope "live_grep"
end

-- globals must be set prior to requiring nvim-tree to function
local g = vim.g

g.nvim_tree_add_trailing = 1 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 1
g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" } -- default = ":~", prev = ":t"
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "", -- "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "★",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
}

local options = {
  disable_netrw = true,
  hijack_netrw = true,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  hijack_cursor = false,
  update_cwd = false,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 200,
  },
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "C", action = "cd" },
        { key = "v", action = "vsplit" },
        { key = "h", action = "split" },
        { key = "tf", action = "telescope_find_files", action_cb = telescope_find_files },
        { key = "tg", action = "telescope_live_grep", action_cb = telescope_live_grep },
      },
    },
  },
  filters = {
    custom = { "node_modules", ".cache" },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
}

nvimtree.setup(options)
