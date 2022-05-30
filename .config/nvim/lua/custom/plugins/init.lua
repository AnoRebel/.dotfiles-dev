return {
  -- Overridden
  ["goolord/alpha-nvim"] = {
    disable = false,
    config = function()
      require "plugins.configs.alpha"
    end,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },

    config = function()
      require("custom.plugins.nvimtree")
    end,
  },
  ["feline-nvim/feline.nvim"] = {
    after = "nvim-web-devicons",
    config = function()
      require("custom.plugins.feline")
    end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    requires = { { "nvim-lua/plenary.nvim" } },
    cmd = "Telescope",

    config = function()
      require("custom.plugins.telescope")
    end,
  },
  ["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = function()
      require("custom.plugins.gitsigns").setup()
    end,
    setup = function()
      require("core.utils").packer_lazy_load "gitsigns.nvim"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    module = "lspconfig",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "nvim-lspconfig"
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
      end, 0)
    end,
    config = function()
      require("custom.lsp.config").setup()
    end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require("custom.plugins.treesitter")
    end,
  },
  ["b0o/schemastore.nvim"] = {},
  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "custom.plugins.cmp"
    end,
  },
  --
  ["nathom/filetype.nvim"] = {},
  ["glepnir/dashboard-nvim"] = {
    config = function()
      require("custom.plugins.dashboard")
    end
  },
  ["antoinemadec/FixCursorHold.nvim"] = {},
  ["williamboman/nvim-lsp-installer"] = {
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("custom.lsp.installer")
    end
  },
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
      require("telescope").load_extension("flutter")
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

    after = "cmp-path"
  },
  ["hrsh7th/cmp-buffer"] = {

    requires = "hrsh7th/nvim-cmp"
  },
  ["hrsh7th/cmp-cmdline"] = {

    requires = "hrsh7th/nvim-cmp"
  },
  ["tzachar/cmp-tabnine"] = {

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    after = "cmp-calc"
  },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = {},
  ["dmitmel/cmp-cmdline-history"] = {},
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
  ["folke/lsp-colors.nvim"] = {},
  ["nacro90/numb.nvim"] = {

    config = function()
      require("numb").setup()
    end
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {

    run = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end
  },
  ["xiyaowong/telescope-emoji.nvim"] = {

    config = function()
      require("telescope").load_extension("emoji")
    end
  },
  ["nvim-lua/popup.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {},
  ["nvim-telescope/telescope-media-files.nvim"] = {

    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("media_files")
    end,
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
    -- lazy loading
    setup = function()
      require("core.utils").packer_lazy_load "neoscroll.nvim"
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
  ["dstein64/nvim-scrollview"] = {

    config = function()
      require("scrollview").setup()
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
  ["j-hui/fidget.nvim"] = {

    config = function()
      require("fidget").setup {}
    end
  }
}
