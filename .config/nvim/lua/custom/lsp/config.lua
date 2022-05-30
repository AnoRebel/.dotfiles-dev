local M = {}
-- local map = require("core.utils").map

M.setup = function()
  -- Diagnostic config

  vim.diagnostic.config({
    float = {
      format = function(diagnostic)
        if not diagnostic.source or not diagnostic.user_data.lsp.code then
          return string.format('%s', diagnostic.message)
        end

        if diagnostic.source == 'eslint' then
          return string.format('%s [%s]', diagnostic.message, diagnostic.user_data.lsp.code)
        end

        return string.format('%s [%s]', diagnostic.message, diagnostic.source)
      end
    },
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  })

  -- UI

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Manually set nvim-notify
  local status_ok, notify = pcall(require, "notify")
  if status_ok then
    vim.notify = notify
  end

  -- use lsp formatting if it's available (and if it's good)
  -- otherwise, fall back to null-ls
  local preferred_formatting_clients = "eslint_d"
  local fallback_formatting_client = "null-ls"

  -- prevent repeated lookups
  local buffer_client_ids = {}

  _G.formatting = function(bufnr)
    bufnr = tonumber(bufnr) or vim.api.nvim_get_current_buf()

    local selected_client
    if buffer_client_ids[bufnr] then
      selected_client = vim.lsp.get_client_by_id(buffer_client_ids[bufnr])
    else
      for _, client in ipairs(vim.lsp.buf_get_clients(bufnr)) do
        if vim.tbl_contains(preferred_formatting_clients, client.name) then
          selected_client = client
          break
        end

        if client.name == fallback_formatting_client then
          selected_client = client
        end
      end
    end

    if not selected_client then
      return
    end

    buffer_client_ids[bufnr] = selected_client.id

    local params = vim.lsp.util.make_formatting_params()
    -- vim.lsp.buf_request(bufnr, "textDocument/formatting", { textDocument = { uri = vim.uri_from_bufnr(bufnr) } }, function(err, res)
    selected_client.request("textDocument/formatting", params, function(err, res)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        vim.notify("global.lsp.formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
        return
      end

      if res then
        vim.lsp.util.apply_text_edits(res, bufnr, selected_client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("silent noautocmd update")
        end)
      end
    end, bufnr)
  end
end

-- LSP Manual mapping (Default fails)
-- New setup mappings are different
-- map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
-- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
-- map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
-- map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
-- map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
-- map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
-- map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
-- map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
-- map("n", "<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>")
-- map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")
-- map("n", "<leader>li", ":LspInfo<CR>")
-- map("n", "<leader>lI", ":LspInstallInfo<CR>")
-- map("n", "<leader>ll", ":lua vim.lsp.codelens.run()<CR>")
-- map("n", "<leader>lpd", ":lua require('custom.lsp.peek').Peek('definition')<CR>")
-- map("n", "<leader>lpt", ":lua require('custom.lsp.peek').Peek('typeDefinition')<CR>")
-- map("n", "<leader>lpi", ":lua require('custom.lsp.peek').Peek('implementation')<CR>")

-- LSP settings (for overriding per client)
-- Load servers (They will be automatically installed after next "Sync plugins" launch)
-- Check installed servers by :LspInstallInfo

-- require('lsp.servers.bash')
-- require('lsp.servers.css')
-- require('lsp.servers.eslint')
-- require('lsp.servers.graphql')
-- require('lsp.servers.html')
-- require('lsp.servers.json')
-- require('lsp.servers.lua')
-- require('lsp.servers.pyright')
-- require('lsp.servers.tailwind')
-- require('lsp.servers.tsserver')
-- require('lsp.servers.volar')

return M
