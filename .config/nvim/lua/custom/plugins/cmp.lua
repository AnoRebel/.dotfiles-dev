-- Requires
local lspkind = require("lspkind")
local tabnine = require("cmp_tabnine.config")
local icons = require("custom.icons")

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
        return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
        return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- Utils
local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- Setup
local source_mapping = {
        buffer      = icons.buffer .. '[BUF]',
        calc        = icons.calculator,
        cmp_tabnine = icons.light .. '[TB9]',
        luasnip     = icons.snippet,
        npm         = icons.terminal .. '[NPM]',
        nvim_lsp    = icons.paragraph .. '[LSP]',
        nvim_lua    = icons.bomb,
        path        = icons.folderOpen2,
        treesitter  = icons.tree,
        zsh         = icons.terminal .. '[ZSH]',
}

cmp.setup {
        snippet = {
                expand = function(args)
                        luasnip.lsp_expand(args.body)
                end
        },

        mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                },
                ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                                cmp.select_next_item()
                        elseif luasnip.expandable() then
                                luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                        elseif check_backspace() then
                                fallback()
                        else
                                fallback()
                        end
                end, {
                        "i",
                        "s",
                }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                                cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                        else
                                fallback()
                        end
                end, {
                        "i",
                        "s",
                }),
        }),

        formatting = {
                format = function(entry, vim_item)
                        vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
                        local menu = source_mapping[entry.source.name]
                        local maxwidth = 50

                        if entry.source.name == 'cmp_tabnine' then
                                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                                        menu = menu .. '[' .. entry.completion_item.data.detail .. ']'
                                end
                        end

                        vim_item.menu = menu
                        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

                        return vim_item
                end
        },

        -- You should specify your *installed* sources.
        sources = {
                { name = 'nvim_lsp' },
                { name = 'npm' },
                { name = 'cmp_tabnine', max_item_count = 3 },
                { name = 'buffer', keyword_length = 5 },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'calc' },
                { name = 'nvim_lua' },
        },

        confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
        },

        window = {
                documentation = {
                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
        },

        experimental = {
                native_menu = false,
                ghost_text = true,
        }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
                { name = 'buffer' }
        }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
                { name = 'path' }
        }, {
                { name = 'cmdline' }
        })
})

tabnine:setup({
        max_lines                = 1000;
        max_num_results          = 3;
        sort                     = true;
        show_prediction_strength = true;
        run_on_every_keystroke   = true;
        snipper_placeholder      = '..';
        ignored_file_types       = {};
})
