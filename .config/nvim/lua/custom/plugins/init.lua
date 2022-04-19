-- local plugin_settings = require("core.utils").load_config().plugins
return {
        {
                "glepnir/dashboard-nvim",
                config = function()
                        require("custom.plugins.dashboard")
                end
        },
        {
                "antoinemadec/FixCursorHold.nvim"
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
                "rcarriga/nvim-notify",
                config = function()
                        require("custom.plugins.notify").setup()
                end,
                event = "BufRead",
        },
        {
                "akinsho/toggleterm.nvim",
                event = "BufWinEnter",
                config = function()
                        require("custom.plugins.terminal").setup()
                end,
        },
        {
                "jose-elias-alvarez/null-ls.nvim",
                requires = "nvim-lua/plenary.nvim",
                after = "nvim-lspconfig",
                config = function()
                        require("custom.plugins.null-ls").setup()
                end
        },
        {
                "akinsho/flutter-tools.nvim",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                        require("flutter-tools").setup {}
                        require("telescope").load_extension("flutter")
                end
        },
        {
                "ThePrimeagen/refactoring.nvim",
                requires = {
                        "nvim-lua/plenary.nvim",
                        "nvim-treesitter/nvim-treesitter"
                },
                config = function()
                        require("refactoring").setup({})
                end
        },
        {
                "MunifTanjim/eslint.nvim",
                requires = {
                        "neovim/nvim-lspconfig",
                        "jose-elias-alvarez/null-ls.nvim"
                },
                -- config = function()
                --   require("custom.plugins.eslint")
                -- end
        },
        {
                "MunifTanjim/prettier.nvim",
                requires = {
                        "neovim/nvim-lspconfig",
                        "jose-elias-alvarez/null-ls.nvim"
                },
                -- config = function()
                --   require("custom.plugins.prettier")
                -- end
        },
        {
                "David-Kunz/cmp-npm",
                requires = {
                        "nvim-lua/plenary.nvim"
                },
                after = "nvim-cmp",
                config = function()
                        require("custom.plugins.cmp-npm")
                end
        },
        {
                "hrsh7th/cmp-calc",
                after = "cmp-path"
        },
        {
                "hrsh7th/cmp-buffer",
                requires = "hrsh7th/nvim-cmp"
        },
        {
                "hrsh7th/cmp-cmdline",
                requires = "hrsh7th/nvim-cmp"
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
                "windwp/nvim-spectre",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                        require("spectre").setup()
                end
        },
        {
                "folke/todo-comments.nvim",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                        require("todo-comments").setup {
                                -- your configuration comes here
                                -- or leave it empty to use the default settings
                                -- refer to the configuration section below
                        }
                end
        },
        {
                "folke/which-key.nvim",
                config = function()
                        require("custom.plugins.which-key").setup()
                end,
                event = "BufWinEnter",
        },
        {
                'TimUntersberger/neogit',
                requires = 'nvim-lua/plenary.nvim',
                config = function()
                        require("neogit").setup {}
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
                run = "make",
                config = function()
                        require("telescope").load_extension("fzf")
                end
        },
        {
                "xiyaowong/telescope-emoji.nvim",
                config = function()
                        require("telescope").load_extension("emoji")
                end
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
                        require("telescope").load_extension("media_files")
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
