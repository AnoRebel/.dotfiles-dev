-- local plugin_settings = require("core.utils").load_config().plugins
return {
  {
    "glepnir/dashboard-nvim",
    config = function()
      require("custom.plugins.dashboard")
    end
  },
  {
    "williamboman/nvim-lsp-installer",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("custom.lsp.installer")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = {
      "nvim-treesitter"
    }
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    after = {
      "nvim-treesitter"
    }
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim"
  },
  {
    "MunifTanjim/eslint.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    }
  },
  {
    "MunifTanjim/prettier.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    }
  },
  {
    "David-Kunz/cmp-npm",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("custom.plugins.cmp-npm")
    end
  },
  {
    "hrsh7th/cmp-calc",
    after = "cmp-path"
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    after = "cmp-calc"
  },
  {
    "onsails/lspkind-nvim"
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("custom.plugins.trouble")
    end
  },
  {
    "mattn/emmet-vim"
  },
  {
    "tpope/vim-surround"
  },
  {
    "mbbill/undotree"
  },
  {
    "simrat39/symbols-outline.nvim"
  },
  -- {
  --   "mg979/vim-visual-multi"
  -- },
  {
    "SmiteshP/nvim-gps",
    config = function()
      require("custom.plugins.gps")
    end,
    after = "nvim-treesitter"
  },
  {
    "folke/lsp-colors.nvim"
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  },
  {
    "nvim-lua/popup.nvim"
  },
  {
    "nvim-lua/plenary.nvim"
  },
  {
      "nvim-telescope/telescope-media-files.nvim",
      after = "telescope.nvim",
      config = function()
         require("telescope").setup {
            extensions = {
               media_files = {
                  filetypes = { "png", "webp", "jpg", "jpeg" },
               },
               -- fd is needed
            },
         }
         require("telescope").load_extension "media_files"
      end,
   },
   {
     "stevearc/dressing.nvim",
     requires = "MunifTanjim/nui.nvim",
     config = function()
       require("custom.plugins.dressing")
     end
   },
   {
     "ellisonleao/glow.nvim",
     cmd = "Glow"
   },
   {
     "sindrets/diffview.nvim",
     requires = "nvim-lua/plenary.nvim",
     -- config = function()
     --   require("custom.plugins.diffview")
     -- end
   },
   {
     "folke/zen-mode.nvim",
     config = function()
       require("custom.plugins.zen")
     end,
   },
   {
     "folke/twilight.nvim",
     config = function()
       require("twilight").setup {}
     end,
     -- disable = not EcoVim.plugins.zen.enabled
   },
   {
    "karb94/neoscroll.nvim",
     opt = true,
     config = function()
        require("neoscroll").setup()
     end,
     -- lazy loading
     setup = function()
       require("core.utils").packer_lazy_load "neoscroll.nvim"
     end,
  },
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("custom.plugins.package-info")
    end
  }
}
