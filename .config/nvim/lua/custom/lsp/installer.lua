local lspconfig = require("lspconfig")

require("mason").setup({
  ui = {
  border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "dartls",
    "denols",
    "dotls",
    "emmet_ls",
    "eslint",
    "gopls",
    "graphql",
    "html",
    "intelephense",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "sqlls",
    "tailwindcss",
    "tsserver",
    "volar",
  },
  automatic_installation = false,
})

local foldHandler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- if client.supports_method "textDocument/signatureHelp" then
  --     vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
  --        pattern = "*",
  --        group = vim.api.nvim_create_augroup("LspSignature", {}),
  --        callback = function()
  --           vim.lsp.buf.signature_help()
  --        end,
  --     })
  --  end
  require "illuminate".on_attach(client)
  require("ufo").setup({ fold_virt_text_handler = foldHandler })

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
local stats_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if stats_ok then
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = require('custom.lsp.servers.css').capabilities,
  settings = require('custom.lsp.servers.css').settings,
}

lspconfig.dartls.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
}

-- lspconfig.denols.setup {
--   on_attach = on_attach,
--   handlers = handlers,
--   capabilities = capabilities,
-- }

lspconfig.dotls.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
}

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
}

lspconfig.eslint.setup {
  root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
  on_attach = function(client, bufnr)
    -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
    -- the server capabilities of the eslint server ourselves!
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  handlers = handlers,
  settings = require('custom.lsp.servers.eslint').settings,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = require('custom.lsp.servers.html').settings,
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

lspconfig.jsonls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
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
}

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
}

require("custom.lsp.servers.tailwind")
-- lspconfig.tailwindcss.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   handlers = handlers,
-- }

lspconfig.tsserver.setup {
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true,
  -- capabilities.textDocument.completion.completionItem.preselectSupport = true,
  -- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true,
  -- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true,
  -- capabilities.textDocument.completion.completionItem.deprecatedSupport = true,
  -- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true,
  -- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } },
  -- capabilities.textDocument.completion.completionItem.resolveSupport = {
  --   properties = {
  --     'documentation',
  --     'detail',
  --     'additionalTextEdits',
  --   }
  -- },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  handlers = handlers,
}

lspconfig.volar.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
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
