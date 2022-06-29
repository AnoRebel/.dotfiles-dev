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

require("base46").load_highlight "nvimtree"

local options = {
  auto_reload_on_write = true,
  hijack_unnamed_buffer_when_opening = false,
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true, -- false
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  hijack_cursor = true,
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
    adaptive_size = true,
    width = 25,
    hide_root_folder = false,
    mappings = {
      custom_only = false,
      list = {
        { key = "C", action = "cd" },
        { key = "v", action = "vsplit" },
        { key = "h", action = "split" },
        { key = "t", action = "tabnew" },
        -- { key = "K", action = "toggle_file_info" },
        { key = "tf", action = "telescope_find_files", action_cb = telescope_find_files },
        { key = "tg", action = "telescope_live_grep", action_cb = telescope_live_grep },
      },
    },
  },
  filesystem_watchers = {
    enable = true,
  },
  filters = {
    custom = { "node_modules", ".cache" },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  renderer = {
    add_trailing = true, -- append a trailing slash to folder names
    highlight_git = true,
    highlight_opened_files = "all", -- "none" | "icon" | "name"
    root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }, -- default = ":~", prev = ":t"
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
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
          arrow_closed = "",
          arrow_open = "",
        },
      },
    },
    indent_markers = {
      enable = true,
    },
    special_files = { "Cargo.toml", "README.md", "Readme.md", "readme.md", "Makefile", "MAKEFILE" } -- " List of filenames that gets highlighted with NvimTreeSpecialFile
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
}

nvimtree.setup(options)
