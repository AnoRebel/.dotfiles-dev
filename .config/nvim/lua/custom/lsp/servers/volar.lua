local M = {}

-- Auto-install
local lsp_installer_servers = require'nvim-lsp-installer.servers'

local ok, vue = lsp_installer_servers.get_server("volar")
if ok then
    if not vue:is_installed() then
        vue:install()
    end
end

-- Settings

M.filetypes = {
  "vue",
  "javascript",
}

return M
