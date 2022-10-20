local M = {}

-- Settings

-- Enable (broadcasting) snippet capability for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities
M.settings = {}

return M
