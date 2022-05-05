local M = {}

M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

M.setup = function()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end

  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Error", "")
  lspSymbol("Info", "")
  lspSymbol("Hint", "")
  lspSymbol("Warn", "")

  vim.diagnostic.config {
    virtual_text = {
      -- source = "always", -- Or "if_many",
      prefix = "", -- Could be '●', '▎', 'x'
    },
    -- float = {
    --   source = "always", -- Or "if_many",
    -- },
    signs = true,
    underline = true,
    update_in_insert = false,
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded", --single
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded", --single
  })
  -- Fix for Update on Insert
  -- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics,
  --   {
  --       underline = true,
  --       virtual_text = {
  --           spacing = 5,
  --           severity_limit = 'Warning',
  --       },
  --       update_in_insert = true,
  --   }
  -- )

  -- suppress error messages from lang servers
  -- vim.notify = function(msg, log_level)
  --    if msg:match "exit code" then
  --       return
  --    end
  --    if log_level == vim.log.levels.ERROR then
  --       vim.api.nvim_err_writeln(msg)
  --    else
  --       vim.api.nvim_echo({ { msg } }, true, {})
  --    end
  -- end
  -- Manually set nvim-notify
  local status_ok, notify = pcall(require, "notify")
  if status_ok then
    vim.notify = notify
  end
end

return M
