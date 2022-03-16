-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
M.ui = {
   theme = "tokyonight",
}

local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
  status = {
    alpha = true,
    colorizer = true,
  },
  default_plugin_config_replace = {
    -- feline = "custom.plugins.feline", -- "setup",
    nvim_cmp = "custom.plugins.cmp",
    nvimtree = {
      git = {
        enable = true,
      },
    }
  },
  install = userPlugins,
}

return M
