local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

-- require("base46").load_highlight "syntax"
-- require("base46").load_highlight "treesitter"

local options = {
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "comment",
    "cpp",
    "css",
    "dart",
    "dockerfile",
    "dot",
    "elixir",
    "erlang",
    "go",
    "gomod",
    "graphql",
    "html",
    "http",
    "javascript",
    "json",
    "jsonc",
    "json5",
    "lua",
    "php",
    "prisma",
    "python",
    "regex",
    "rust",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  indent = {
    -- NOTE: This is an experimental feature
    enable = true
  },
  textsubjects = {
    enable = true,
    -- prev_selection = ',', -- (Optional) keymap to select the previous selection
    -- keymaps = {
    --     ['.'] = 'textsubjects-smart',
    --     [';'] = 'textsubjects-container-outer',
    --     ['i;'] = 'textsubjects-container-inner',
    -- },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      -- keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      --   ["af"] = "@function.outer",
      --   ["if"] = "@function.inner",
      --   ["ac"] = "@class.outer",
      --   ["ic"] = "@class.inner",
      -- },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      -- goto_next_start = {
      --   ["]m"] = "@function.outer",
      --   ["]]"] = "@class.outer",
      -- },
      -- goto_next_end = {
      --   ["]M"] = "@function.outer",
      --   ["]["] = "@class.outer",
      -- },
      -- goto_previous_start = {
      --   ["[m"] = "@function.outer",
      --   ["[["] = "@class.outer",
      -- },
      -- goto_previous_end = {
      --   ["[M"] = "@function.outer",
      --   ["[]"] = "@class.outer",
      -- },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      -- peek_definition_code = {
      --   ["<leader>df"] = "@function.outer",
      --   ["<leader>dF"] = "@class.outer",
      -- },
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      -- keymaps = {
      --   smart_rename = "grr",
      -- },
    },
    navigation = {
      enable = true,
      -- keymaps = {
      --   goto_definition = "gnd",
      --   list_definitions = "gnD",
      --   list_definitions_toc = "gO",
      --   goto_next_usage = "<a-*>",
      --   goto_previous_usage = "<a-#>",
      -- },
    },
  },
  highlight = {
    enable = true,
    -- use_languagetree = true,
  },
  context_commentstring = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}

ts_config.setup(options)
