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
    nvimtree = function () require("custom.plugins.nvimtree").setup() end,
    feline = function() require("custom.plugins.feline").setup() end,
    telescope = function () require("custom.plugins.telescope").setup() end,
    gitsigns = function () require("custom.plugins.gitsigns").setup() end,
    lspconfig = function () require("custom.lsp.config").setup() end,
    nvim_cmp = "custom.plugins.cmp",
  },
  install = userPlugins,
}

return M
