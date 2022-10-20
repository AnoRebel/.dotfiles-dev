local M = {}

-- Enable (broadcasting) snippet capability for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Settings
M.settings = {}
M.capabilities = capabilities

return M
