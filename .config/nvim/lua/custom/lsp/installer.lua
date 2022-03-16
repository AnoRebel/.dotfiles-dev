local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"}),
}

lsp_installer.on_server_ready(function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if status_ok then
      capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end

    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
    }

    if server.name == "bash" then
      opts.settings = require('custom.lsp.servers.bash').settings
    end

    if server.name == "cssls" then
      opts.capabilities = require('custom.lsp.servers.css').capabilities
      opts.settings = require('custom.lsp.servers.css').settings
    end

    if server.name == "eslint" then
        opts.root_dir = require"lspconfig".util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json")
        opts.on_attach = function (client, bufnr)
            -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
            -- the resolved capabilities of the eslint server ourselves!
            client.resolved_capabilities.document_formatting = true
            on_attach(client, bufnr)
        end
        opts.settings = require('custom.lsp.servers.eslint').settings
    end

    if server.name == "graphql" then
      opts.settings = require('custom.lsp.servers.graphql').settings
    end

    if server.name == "html" then
      opts.capabilities = require('custom.lsp.servers.html').capabilities
      opts.settings = require('custom.lsp.servers.html').settings
    end

    if server.name == "jsonls" then
      opts.settings = require('custom.lsp.servers.json').settings
    end

    if server.name == "pyright" then
      opts.filetypes = require("custom.lsp.servers.pyright").settings
    end

    if server.name == "sumneko_lua" then
      opts.settings = require("custom.lsp.servers.lua").settings
    end

    if server.name == "tsserver" then
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.preselectSupport = true
      capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          'documentation',
          'detail',
          'additionalTextEdits',
        }
      }
      opts.capabilities = capabilities
      opts.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
      end
    end

    if server.name == "volar" then
      opts.filetypes = require("custom.lsp.servers.volar").filetypes
    end

    -- (How to) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    --     opts.on_attach = function(client, bufnr) ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
