-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
M.ui = {
  theme = "tokyodark", -- gruvchad
  -- transparency = true,
  theme_toggle = { "tokyonight", "tokyodark" }
}

local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
  user = userPlugins,
}

-- M.mappings = require "custom.mappings"

return M
