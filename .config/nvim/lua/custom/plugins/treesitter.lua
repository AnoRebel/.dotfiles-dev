local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local default = {
  ensure_installed = {
    "lua",
    "vim",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  context_commentstring = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}

local M = {}
M.setup = function(override_flag)
  if override_flag then
    default = require("core.utils").tbl_override_req("nvim_treesitter", default)
  end
  ts_config.setup(default)
end

return M
