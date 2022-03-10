local icons = require("custom.icons")

-- Created with figlet
-- vim.g.dashboard_custom_header = {
-- " ████████                           ██            ",
-- "░██░░░░░                           ░░             ",
-- "░██        █████   ██████  ██    ██ ██ ██████████ ",
-- "░███████  ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██",
-- "░██░░░░  ░██  ░░ ░██   ░██░░██ ░██ ░██ ░██ ░██ ░██",
-- "░██      ░██   ██░██   ░██ ░░████  ░██ ░██ ░██ ░██",
-- "░████████░░█████ ░░██████   ░░██   ░██ ███ ░██ ░██",
-- "░░░░░░░░  ░░░░░   ░░░░░░     ░░    ░░ ░░░  ░░  ░░ "
-- }

vim.g.dashboard_session_directory = '~/.config/nvim/sessions'
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
  a = {description = {icons.fileNoBg ..     'Find File          '}, command = 'Telescope find_files hidden=true'},
  b = {description = {icons.t ..            'Find Word          '}, command = 'Telescope live_grep'},
  c = {description = {icons.fileCopy ..     'Recents            '}, command = 'Telescope oldfiles hidden=true'},
  d = {description = {icons.timer ..        'Load Last Session  '}, command = 'SessionLoad'},
  e = {description = {icons.container ..    'Sync Plugins       '}, command = 'PackerSync'},
  f = {description = {icons.container ..    'Install Plugins    '}, command = 'PackerInstall'},
  g = {description = {icons.vim ..          'Settings           '}, command = 'edit $MYVIMRC'},
  h = {description = {icons.container ..    'Exit               '}, command = 'exit'},
}

-- vim.g.dashboard_preview_command = 'cat'
-- vim.g.dashboard_preview_pipeline = 'lolcat'
-- vim.g.dashboard_preview_file = path to logo file like
-- ~/.config/nvim/neovim.cat
-- vim.g.dashboard_preview_file_height = 12
-- vim.g.dashboard_preview_file_width = 80
