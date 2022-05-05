local M = {}

local termin = {
  -- size can be a number or function which is passed the current terminal
  size = 20, -- function(term)
    -- if term.direction == "horizontal" then
      -- return 25
    -- elseif term.direction == "vertical" then
      -- return vim.o.columns * 0.4
    -- end
  -- end,
  -- open_mapping = [[<c-t>]], -- [[<c-`]]
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  -- terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float' | 'tab',
  direction = "tab",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = "curved",
    -- width = <value>,
    -- height = <value>,
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  -- Add executables on the config.lua
  -- { exec, keymap, name}
  -- lvim.builtin.terminal.execs = {{}} to overwrite
  -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
  execs = {
    -- { "gitui", "<leader>gg", "GitUI", "float" },
  },
}

local Terminal = require("toggleterm.terminal").Terminal

local floatTerm = Terminal:new({
  hidden = true,
  direction = "float",
  float_opts = {
    border = "curved"
  },
})

local bottomTerm = Terminal:new({
  hidden = true,
  direction = "horizontal",
})

local rightTerm = Terminal:new({
  hidden = true,
  direction = "vertical",
})

local lazyGit =
    Terminal:new(
    {
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved"
      },
    }
)

local gitUi =
    Terminal:new(
    {
      cmd = "gitui",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved"
      },
    }
)

M.setup = function()
  local terminal = require("toggleterm")

  terminal.setup(termin)

  terminal.float_toggle = function()
    floatTerm:toggle()
  end
  terminal.lazygit_toggle = function()
    lazyGit:toggle()
  end
  terminal.gitui_toggle = function()
    gitUi:toggle()
  end

  terminal.bottom_toggle = function ()
    bottomTerm:toggle(termin.size)
  end
  terminal.right_toggle = function ()
    rightTerm:toggle(vim.o.columns * 0.25)
  end

  for i, exec in pairs(termin.execs) do
    local opts = {
      cmd = exec[1],
      keymap = exec[2],
      label = exec[3],
      -- NOTE: unable to consistently bind id/count <= 9, see #2146
      count = i + 100,
      direction = exec[4] or termin.direction,
      size = termin.size,
    }

    M.add_exec(opts)
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    vim.notify("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.", "DEBUG")
    return
  end

  local wk_status_ok, wk = pcall(require, "whichkey")
  if not wk_status_ok then
    return
  end
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "n" })
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "t" })
end

M._exec_toggle = function(opts)
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(termin.size, opts.direction)
end

return M
