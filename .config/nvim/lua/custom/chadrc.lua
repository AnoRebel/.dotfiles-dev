-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
M.ui = {
  theme = "tokyodark", -- gruvchad | tokyonight
  -- transparency = true,
  theme_toggle = { "catppuccin", "tokyodark" }
}

M.plugins = require"custom.plugins"

M.options = {
  user = function()
    --- Folds
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.wo.foldcolumn = "1"
    vim.wo.foldlevelstart = 99 -- Trying to fix ufo closing all folds on escape insert mode
    vim.wo.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.wo.foldenable = true
    ---
    vim.o.guifont = "JetBrainsMono Nerd Font:h11" -- "FiraCode Nerd Font:h11"
    -- vim.g.neovide_transparency = 0.7 -- 0.8
    vim.g.neovide_floating_blur_amount_x = 0.3 -- 2.0
    vim.g.neovide_floating_blur_amount_y = 0.3 -- 2.0
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_cursor_vfx_mode = "railgun" -- "pixiedust" || "torpedo"
    vim.g.neovide_cursor_trail_length = 0.5 -- 0.8
    vim.g.neovide_cursor_animation_length = 0.2 -- 0.13
    vim.g.did_load_filetypes = 1 -- 0 | 1
    vim.g.markdown_fenced_languages = {
      "ts=typescript"
    }
  end,
}

return M
