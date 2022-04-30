local M = {}

-- M.setup_lsp = function(attach, capabilities)
--    local lspconfig = require "lspconfig"

--    lspconfig.tsserver.setup {
--       on_attach = function(client, bufnr)
--          client.resolved_capabilities.document_formatting = false
--          vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
--       end,
--    }

--    -- lspservers with default config
--    local servers = { "html", "cssls", "bashls", "clangd", "emmet_ls" }

--    for _, lsp in ipairs(servers) do
--       lspconfig[lsp].setup {
--          on_attach = attach,
--          capabilities = capabilities,
--          flags = {
--             debounce_text_changes = 150,
--          },
--       }
--    end
-- end

M.setup = function()
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
      prefix = "",
    },
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
  --   vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  --     vim.lsp.diagnostic.on_publish_diagnostics,
  --     {
  --         underline = true,
  --         virtual_text = {
  --             spacing = 5,
  --             severity_limit = 'Warning',
  --         },
  --         update_in_insert = true,
  --     }
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
