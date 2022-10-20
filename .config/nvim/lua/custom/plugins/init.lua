local icons = require("custom.icons")

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

return {
  -- Overridden
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    config = function()
      require("custom.plugins.nvimtree")
    end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    config = function()
      require("custom.plugins.telescope")
    end,
  },
  ["lewis6991/gitsigns.nvim"] = {
    config = function()
      require("custom.plugins.gitsigns").setup()
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require("custom.lsp.installer")
    end,
  },
  -- ["WhoIsSethDaniel/toggle-lsp-diagnostics.nvim"] = {
  --   config = function ()
  --     require("toggle_lsp_diagnostics").init()
  --   end
  -- },
  ["nvim-treesitter/nvim-treesitter"] = {
    config = function()
      require("custom.plugins.treesitter")
    end,
  },
  ["b0o/schemastore.nvim"] = {},
  ["hrsh7th/nvim-cmp"] = {
    override_options = {
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'cmp_tabnine', max_item_count = 3 },
        { name = 'buffer', keyword_length = 5 },
        { name = 'path' },
        { name = 'npm' },
        { name = 'calc' },
        { name = 'nvim_lua' },
      },
      formatting = {
        format = function(entry, vim_item)
          local lspkind = require("lspkind")
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
    },
  },
  ["williamboman/mason.nvim"] = {
    event = { "BufEnter" },
    -- event = { "VimEnter", "BufEnter", "BufWinEnter" },
    config = function()
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
    end
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    requires = {"williamboman/mason.nvim", "neovim/nvim-lspconfig"},
  },
  -- ["WhoIsSethDaniel/mason-tool-installer.nvim"] = {},
  --
  ["nathom/filetype.nvim"] = {},
  ["glepnir/dashboard-nvim"] = {
    config = function()
      require("custom.plugins.dashboard")
    end
  },
  ["antoinemadec/FixCursorHold.nvim"] = {},
  ["RRethy/vim-illuminate"] = {},
  ["DanilaMihailov/beacon.nvim"] = {},
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = {
      "nvim-treesitter"
    }
  },
  ["RRethy/nvim-treesitter-textsubjects"] = {
    after = {
      "nvim-treesitter"
    }
  },
  ["nvim-treesitter/nvim-treesitter-refactor"] = {
    after = {
      "nvim-treesitter"
    }
  },
  ["romgrk/nvim-treesitter-context"] = {
    config = function()
      require("treesitter-context").setup {}
    end,
  },
  ["windwp/nvim-ts-autotag"] = {

    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  ["rmagatti/goto-preview"] = {

    config = function()
      require('goto-preview').setup {}
    end
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},
  ["p00f/nvim-ts-rainbow"] = {},
  ["kevinhwang91/nvim-bqf"] = {

    ft = "qf",
    config = function()
      require("bqf").setup()
    end
  },
  ["rcarriga/nvim-notify"] = {

    config = function()
      require("custom.plugins.notify").setup()
    end,
    event = "BufRead",
  },
  ["akinsho/toggleterm.nvim"] = {

    event = "BufWinEnter",
    config = function()
      require("custom.plugins.terminal").setup()
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {

    requires = "nvim-lua/plenary.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end
  },
  ["akinsho/flutter-tools.nvim"] = {

    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("flutter-tools").setup {}
      -- require("telescope").load_extension("flutter")
    end
  },
  ["b0o/incline.nvim"] = {
    after = { "nvim-web-devicons" },
    config = function ()
      local get_icon_color = require("nvim-web-devicons").get_icon_color
      local get_buf_option = vim.api.nvim_buf_get_option

      local diagnostic_map = {}
      diagnostic_map[vim.diagnostic.severity.ERROR] = { "✗", guifg = "red" }
      diagnostic_map[vim.diagnostic.severity.WARN] = { "", guifg = "orange" }
      diagnostic_map[vim.diagnostic.severity.INFO] = { "", guifg = "green" }
      diagnostic_map[vim.diagnostic.severity.HINT] = { "", guifg = "blue" }

      local function get_highest_diagnostic_severity(diagnostics)
        local highest_severity = 100
        for _, diagnostic in ipairs(diagnostics) do
          local severity = diagnostic.severity
          if severity < highest_severity then
            highest_severity = severity
          end
        end
        return highest_severity
      end

      local function get_status(filename)
        local diagnostics = vim.diagnostic.get()
        if vim.tbl_count(diagnostics) > 0 then
          local highest_severity = get_highest_diagnostic_severity(diagnostics)
          return diagnostic_map[highest_severity]
        else
          local filetype_icon, color = get_icon_color(filename)
          return { filetype_icon, guifg = color }
        end
      end
      require("incline").setup({
        debounce_threshold = { falling = 500, rising = 250 },
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          local status = get_status(filename)
          local modified = get_buf_option(props.buf, "modified") and "⦁" or ""
          return {
            status,
            { " " },
            { filename },
            { " " },
            { modified, guifg = "orange" },
          }
        end,
      })
    end
  },
  ["ThePrimeagen/refactoring.nvim"] = {

    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("refactoring").setup({})
    end
  },
  ["MunifTanjim/eslint.nvim"] = {

    requires = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    },
    -- config = function()
    --   require("custom.plugins.eslint")
    -- end
  },
  ["MunifTanjim/prettier.nvim"] = {

    requires = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    },
    -- config = function()
    --   require("custom.plugins.prettier")
    -- end
  },
  ["David-Kunz/cmp-npm"] = {

    requires = {
      "nvim-lua/plenary.nvim"
    },
    after = "nvim-cmp",
    config = function()
      require("custom.plugins.cmp-npm")
    end
  },
  ["hrsh7th/cmp-calc"] = {
    after = "nvim-cmp",
  },
  ["hrsh7th/cmp-buffer"] = {
    after = "nvim-cmp",
    requires = "hrsh7th/nvim-cmp"
  },
  ["hrsh7th/cmp-cmdline"] = {
    after = "nvim-cmp",
    requires = "hrsh7th/nvim-cmp"
  },
  ["tzachar/cmp-tabnine"] = {
    opt = true,
    after = "nvim-cmp",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp"
  },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = {
    after = "nvim-cmp",
  },
  ["dmitmel/cmp-cmdline-history"] = {
    after = "nvim-cmp",
  },
  ["onsails/lspkind-nvim"] = {},
  ["folke/trouble.nvim"] = {

    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("custom.plugins.trouble")
    end
  },
  ["windwp/nvim-spectre"] = {

    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("spectre").setup()
    end
  },
  ["folke/todo-comments.nvim"] = {

    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  -- ["folke/which-key.nvim"] = {
  --
  --   config = function()
  --     require("custom.plugins.which-key").setup()
  --   end,
  --   event = "BufWinEnter",
  -- },
  ["TimUntersberger/neogit"] = {

    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup {}
    end
  },
  ["akinsho/git-conflict.nvim"] = {

    config = function()
      require("git-conflict").setup()
    end
  },
  ["rhysd/committia.vim"] = {},
  ["yardnsm/vim-import-cost"] = {

    run = "npm install --production"
    -- AutoRun
    -- augroup import_cost_auto_run
    --   autocmd!
    --   autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
    --   autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
    --   autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
    -- augroup END
  },
  -- [
  --   "github/copilot.vim" -- :Copilot setup
  -- ],
  ["mattn/emmet-vim"] = {},
  ["tpope/vim-surround"] = {},
  ["mbbill/undotree"] = {},
  ["simrat39/symbols-outline.nvim"] = {},
  -- [
  --   "mg979/vim-visual-multi"
  -- ],
  ["SmiteshP/nvim-gps"] = {
    config = function()
      require("custom.plugins.gps")
    end,
    after = "nvim-treesitter"
  },
  -- ["feline-nvim/feline.nvim"] = {
  --   after = {"nvim-gps", "package-info.nvim"},
  --   config = function ()
  --     local gps = require("nvim-gps")
  --     local package = require("package-info")
  --     local location = {
  --       provider = function()
  --         return gps.get_location()
  --       end,
  --       enabled = function()
  --         return gps.is_available()
  --       end,
  --     }
  --     local package_info = {
  --       provider = function()
  --         return package.get_status()
  --       end,
  --     }
  --     require("feline").winbar.setup({
  --       -- components = {
  --       --   active = {
  --       --     {
  --       --       location,
  --       --     },
  --       --     {},
  --       --     {
  --       --       package_info,
  --       --     }
  --       --   }
  --       -- },
  --     })
  --   end
  -- },
  ["folke/lsp-colors.nvim"] = {},
  ["nacro90/numb.nvim"] = {

    config = function()
      require("numb").setup()
    end
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {

    run = "make",
    -- config = function()
    --   require("telescope").load_extension("fzf")
    -- end
  },
  ["xiyaowong/telescope-emoji.nvim"] = {

    -- config = function()
    --   require("telescope").load_extension("emoji")
    -- end
  },
  ["nvim-lua/popup.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {},
  ["nvim-telescope/telescope-media-files.nvim"] = {

    after = "telescope.nvim",
    -- config = function()
    --   require("telescope").load_extension("media_files")
    -- end,
  },
  ["stevearc/dressing.nvim"] = {

    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("custom.plugins.dressing")
    end
  },
  ["ellisonleao/glow.nvim"] = {

    cmd = "Glow"
  },
  ["sindrets/diffview.nvim"] = {

    requires = "nvim-lua/plenary.nvim",
    -- config = function()
    --   require("custom.plugins.diffview")
    -- end
  },
  ["folke/zen-mode.nvim"] = {

    config = function()
      require("custom.plugins.zen")
    end,
  },
  ["folke/twilight.nvim"] = {

    config = function()
      require("twilight").setup {}
    end,
  },
  ["karb94/neoscroll.nvim"] = {
    opt = true,
    config = function()
      require("neoscroll").setup()
    end,
  },
  ["vuki656/package-info.nvim"] = {

    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("custom.plugins.package-info")
    end
  },
  -- ["lukas-reineke/virt-column.nvim"] = {
  --   config = function()
  --     vim.opt.colorcolumn = "120"
  --     vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  --       pattern = "*",
  --       command = "highlight clear colorColumn",
  --       desc = "Clear colorcolumn",
  --     })
  --     require("virt-column").setup()
  --   end
  -- },
  ["kevinhwang91/nvim-hlslens"] = {
    config = function ()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
          else
            indicator = ''
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= '' then
              text = ('[%s %d/%d]'):format(indicator, idx, cnt)
            else
              text = ('[%d/%d]'):format(idx, cnt)
            end
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
          else
            text = ('[%s %d]'):format(indicator, idx)
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
      })
    end,
  },
  ["petertriho/nvim-scrollbar"] = {
    after = { "nvim-hlslens" },
    config = function()
      require("scrollbar").setup({
        handlers = {
          search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
        },
      })
      require("scrollbar.handlers.search").setup()
    end
  },
  ["lambdalisue/suda.vim"] = {

    config = function()
      -- vim.g.suda#prompt = 'Password: '
      vim.g.suda_smart_edit = 1 -- Automate
    end
  },
  ["kosayoda/nvim-lightbulb"] = {

    config = function()
      -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      require("nvim-lightbulb").setup {}
    end
  },
  ["kevinhwang91/nvim-ufo"] = {
    requires = "kevinhwang91/promise-async",
  },
  ["j-hui/fidget.nvim"] = {

    config = function()
      require("fidget").setup {
        text = { spinner = "moon" }
      }
    end
  }
}
