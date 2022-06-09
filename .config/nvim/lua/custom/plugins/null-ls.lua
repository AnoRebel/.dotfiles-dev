local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {

  -- b.formatting.prettierd.with { filetypes = { "html", "markdown", "css" } },
  b.formatting.deno_fmt,

  -- Lua
  -- b.formatting.stylua,
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  b.diagnostics.markdownlint,
  -- b.diagnostics.tsc,
  -- b.diagnostics.eslint_d,
  -- b.diagnostics.php,
  -- b.diagnostics.zsh,

  -- Formatting
  b.formatting.autopep8,
  b.formatting.black,
  b.formatting.dart_format,
  b.formatting.gofmt,
  b.formatting.isort,
  b.formatting.prettierd,

  -- Code Actions
  b.code_actions.eslint_d,
  b.code_actions.gitsigns,

  -- Hover
  b.hover.dictionary,
}

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
      bufnr = bufnr,
      filter = function(client)
        -- filter out clients that you don't want to use
        return client.name == "null-ls"
      end,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

local M = {}

M.setup = function()
  null_ls.setup {
    debug = true,
    sources = sources,

    -- format on save
    on_attach = function(client, bufnr)
      -- if client.supports_method("textDocument/formatting") then
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
      end
      -- if client.server_capabilities.document_formatting then
      --   vim.cmd([[
      --     augroup LspFormatting
      --       autocmd! * <buffer>
      --       autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      --     augroup END
      --   ]])
      -- end
      -- formatting_sync(nil, 2000)
      -- if client.supports_method("textDocument/formatting") then
      -- -- wrap in an augroup to prevent duplicate autocmds
      -- vim.cmd([[
      --   augroup LspFormatting
      --     autocmd! * <buffer>
      --     autocmd BufWritePost <buffer> lua formatting(vim.fn.expand("<abuf>"))
      --   augroup END
      -- ]])
      -- end
    end,
  }
end

return M
