require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")

local status_ok, lsp_installer_servers = pcall(require, 'nvim-lsp-installer.servers')
if status_ok then
  for _, server in ipairs {
    "bashls",
    "cssls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "volar",
  } do
    local ok, server_name = lsp_installer_servers.get_server(server)
    if ok then
      if not server_name:is_installed() then
        server_name:install()
      end
    end
  end
end

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status_ok then
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = require('custom.lsp.servers.bash').settings,
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  capabilities = require('custom.lsp.servers.css').capabilities,
  settings = require('custom.lsp.servers.css').settings,
}

lspconfig.eslint.setup {
  root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
  on_attach = function(client, bufnr)
    -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
    -- the resolved capabilities of the eslint server ourselves!
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  handlers = handlers,
  settings = require('custom.lsp.servers.eslint').settings,
}

lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = require('custom.lsp.servers.graphql').settings,
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  capabilities = require('custom.lsp.servers.html').capabilities,
  settings = require('custom.lsp.servers.html').settings,
}

lspconfig.jsonls.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  handlers = handlers,
  settings = require('custom.lsp.servers.json').settings,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  filetypes = require("custom.lsp.servers.pyright").settings,
}

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = require("custom.lsp.servers.lua").settings,
}

-- lspconfig.tailwindcss.setup {
--   capabilities = require('lsp.servers.tsserver').capabilities,
--   filetypes = require('lsp.servers.tailwindcss').filetypes,
--   handlers = handlers,
--   init_options = require('lsp.servers.tailwindcss').init_options,
--   on_attach = require('lsp.servers.tailwindcss').on_attach,
--   settings = require('lsp.servers.tailwindcss').settings,
-- }

lspconfig.tsserver.setup {
  capabilities.textDocument.completion.completionItem.snippetSupport = true,
  capabilities.textDocument.completion.completionItem.preselectSupport = true,
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true,
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true,
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true,
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true,
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } },
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end,
  handlers = handlers,
}

lspconfig.volar.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  handlers = handlers,
  filetypes = require("custom.lsp.servers.volar").filetypes,
}

-- (How to) Customize the options passed to the server
-- if server.name == "tsserver" then
--     opts.root_dir = function() ... end
--     opts.on_attach = function(client, bufnr) ... end
-- end

-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
vim.cmd [[ do User LspAttachBuffers ]]
