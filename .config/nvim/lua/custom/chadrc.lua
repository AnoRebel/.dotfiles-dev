-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
M.ui = {
  theme = "tokyodark", -- gruvchad | tokyonight
  -- transparency = true,
  theme_toggle = { "catppuccin", "tokyodark" }
}

local icons = require("custom.icons")
local source_mapping = {
  buffer      = icons.buffer .. '[BUF]',
  calc        = icons.calculator,
  cmp_tabnine = icons.light .. '[TB9]',
  luasnip     = icons.snippet,
  npm         = icons.terminal .. '[NPM]',
  nvim_lsp    = icons.paragraph .. '[LSP]',
  nvim_lua    = icons.bomb,
  path        = icons.folderOpen2,
  treesitter  = icons.tree,
  zsh         = icons.terminal .. '[ZSH]',
}

M.plugins = {
  override = {
    ["hrsh7th/nvim-cmp"] = {
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'cmp_tabnine', max_item_count = 3 },
        { name = 'buffer', keyword_length = 5 },
        { name = 'path' },
        { name = 'npm' },
        { name = 'calc' },
        { name = 'nvim_lua' },
      },
      formatting = {
        format = function(entry, vim_item)
          local lspkind = require("lspkind")
          vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
          local menu = source_mapping[entry.source.name]
          local maxwidth = 50

          if entry.source.name == 'cmp_tabnine' then
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
              menu = menu .. '[' .. entry.completion_item.data.detail .. ']'
            end
          end

          vim_item.menu = menu
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

          return vim_item
        end
      },
    },
  },
  user = require "custom.plugins",
}

M.options = {
  user = function()
    vim.g.did_load_filetypes = 1 -- 0 | 1
  end,
}

return M
