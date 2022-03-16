local M = {}

-- Auto-install

local lsp_installer_servers = require'nvim-lsp-installer.servers'

local ok, pyright = lsp_installer_servers.get_server("pyright")
if ok then
    if not pyright:is_installed() then
        pyright:install()
    end
end

-- Settings

M.settings = {}

return M
