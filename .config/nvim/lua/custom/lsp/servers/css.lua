local M = {}

-- Auto-install

local lsp_installer_servers = require'nvim-lsp-installer.servers'

local ok, cssls = lsp_installer_servers.get_server("cssls")
if ok then
    if not cssls:is_installed() then
        cssls:install()
    end
end

-- Enable (broadcasting) snippet capability for completion
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Settings
M.settings = {}
M.capabilities = capabilities

return M
