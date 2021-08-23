" be iMproved, required
if &compatible
  set nocompatible
endif


" ----------------------------------------------------------------------------
"   Colors
" ----------------------------------------------------------------------------
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'


" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------
" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Git
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" Fuzzy file finder
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }

" Misc
"Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Yggdroot/indentLine'

" Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/badwolf'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'machakann/vim-highlightedyank'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'zenorocha/dracula-theme', { 'rtp': 'vim/' }

" Fuzzy finders
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" General helpers
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle'}
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'henrik/vim-indexed-search'
Plug 'itchyny/calendar.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Code Helpers
Plug 'neomake/neomake'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'spf13/vim-autoclose'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'yardnsm/vim-import-cost', { 'do': 'yarn install' }
Plug 'mbbill/undotree'
Plug 'ap/vim-css-color'
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
" Html
Plug 'rstacruz/sparkup', {'rtp': '/vim'}

" Vue
Plug 'leafOfTree/vim-vue-plugin'

" Terminal
Plug 'voldikss/vim-floaterm'

" No distraction
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Completions and Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'roxma/nvim-yarp'
endif
Plug 'dense-analysis/ale'
"Plug 'codota/tabnine-vim'

call plug#end()


" ----------------------------------------------------------------------------
"   Persistent Undo
" ----------------------------------------------------------------------------
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
	silent !mkdir ~/.vim/backups > /dev/null 2>&1
	set undodir=~/.vim/backups
	set undofile
endif

" ----------------------------------------------------------------------------
"   Filetype shenanigans
" ----------------------------------------------------------------------------
"filetype off                  " required
filetype plugin indent on
" To ignore plugin indent changes, instead use:
filetype plugin on
filetype indent on


" ----------------------------------------------------------------------------
"   Setting defaults
" ----------------------------------------------------------------------------
syntax on
" Use system clipboard
set clipboard+=unnamedplus
set mouse=a
set number
set relativenumber
set autoread
set autoindent
set copyindent
set smartindent
set shiftwidth=4
set ignorecase
set hlsearch
set incsearch
set smartcase
set t_Co=256
set smarttab
set expandtab
set tabstop=4
set hidden
set showmode
set showcmd
set cursorline
" set cursorcolumn
set wildmode=longest,list,full
set backspace=indent,eol,start
set encoding=UTF-8
set laststatus=2
set termguicolors
set splitbelow splitright
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
set errorformat=%f:%l:%c:%*\d:%*\d:%*\s%m
" Give more space for displaying messages.
set cmdheight=2
" (default is 4000 ms = 4 s) leads to noticeable delays
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

hi clear SignColumn


" ----------------------------------------------------------------------------
"   Airline (with Powerline fonts)
" ----------------------------------------------------------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline_detect_paste=1
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.crypt = '🔒'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let airline#extensions#coc#error_symbol = '✘:'
let airline#extensions#coc#warning_symbol = ':'
let g:airline#extensions#hunks#coc_git = 1
let airline#extensions#neomake#error_symbol = '✘:'
let airline#extensions#neomake#warning_symbol = ':'


" ----------------------------------------------------------------------------
"   Status line (Custom statusline)
" ----------------------------------------------------------------------------
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
  let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%f'])
  let g:airline_section_c = airline#section#create(['filetype'])
  let g:airline_section_x = airline#section#create(['%P'])
  let g:airline_section_y = airline#section#create(['%B'])
  let g:airline_section_z = airline#section#create_right(['%l', '%c'])
endfunction
"autocmd VimEnter * call AirlineInit()
"call airline#themes#badwolf#refresh()


" ----------------------------------------------------------------------------
"   Linting (with ALE)
" ----------------------------------------------------------------------------
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_balloons = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = {
\   'sh': ['language_server'],
\   'javascript': ['eslint'],
\   'json': ['jsonlint'],
\   'python': ['pyls','mypy']
\}
let g:ale_fixers = {
\    '*': ['trim_whitespace'],
\    'javascript': ['prettier', 'eslint'],
\    'json': ['prettier'],
\    'python': ['black']
\}


" ----------------------------------------------------------------------------
"   Autocomplete (Deoplete and COC.nvim)
" ----------------------------------------------------------------------------
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

let g:deoplete#enable_at_startup = 1
let g:coc_explorer_global_presets = {
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }


" ----------------------------------------------------------------------------
"   Neomake
" ----------------------------------------------------------------------------
call neomake#configure#automake('nrwi', 500)

let g:neomake_python_enabled_makers = ['black', 'mypy']
let g:neomake_list_height = 5
" let g:neomake_verbose = 3
let g:neomake_warning_sign = {
  \ 'text': '▲',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '✘',
  \ 'texthl': 'ErrorMsg',
  \ }


" ----------------------------------------------------------------------------
"   NerdTree
" ----------------------------------------------------------------------------
" Sync open file with NERDTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeIgnore = ['^node_modules$']
" This line is needed to avoid error
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExactMatchHighlightColor = {}
let g:NERDTreePatternMatchHighlightColor = {}
" Sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['css'] = s:blue
" Sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange
" Sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red


" ----------------------------------------------------------------------------
"   NerdCommenter
" ----------------------------------------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDToggleCheckAllLines = 1


" ----------------------------------------------------------------------------
"   FZF
" ----------------------------------------------------------------------------
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

let g:fzf_layout = { 'down': '~40%' }
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }
"let g:fzf_layout = { 'window': '10new' }
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = 'right:60%'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" ----------------------------------------------------------------------------
"   Autocmds
" ----------------------------------------------------------------------------
" Autosave
autocmd FocusLost * silent! wa
" :W sudo saves the file (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
" Autoresize splits on window resizing
autocmd VimResized * wincmd =
" Automatically reload vimrc when it's saved
autocmd BufWritePost .vimrc so ~/.vimrc
" auto open on vim open
autocmd StdinReadPre * let s:std_in=1
" Auto open Startify and Nerdtree on empty buffer
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | endif
" Auto close Nerdtree on open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"autocmd CursorHold * silent call CocActionAsync('doHover')
" Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Highlight currently open buffer in NERDTree
"autocmd BufEnter * call SyncTree()
" File type shenanigans
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd FileType sh,cucumber,ruby,yaml,zsh,vim setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType php,python setlocal shiftwidth=4 tabstop=4 expandtab
" See `:h fo-table` for details of formatoptions `t` to force wrapping of text
autocmd FileType python,ruby,go,sh,javascript setlocal textwidth=79 formatoptions+=t
autocmd Bufread,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?
" Startify and Goyo fix
autocmd BufEnter *
       \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
       \   let t:startify_new_tab = 1 |
       \   Startify |
       \ endif
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
" Git checkout branch helper
function! s:changebranch(branch)
  execute 'Git checkout ' . a:branch
  call feedkeys("i")
endfunction
function! s:gitCheckoutRef(ref)
  execute('Git checkout ' . a:ref)
  " call feedkeys("i")
endfunction
function! s:gitListRefs()
  let l:refs = execute("Git for-each-ref --format='\\%(refname:short)'"
  " jump the first line, its a git command
  return split(l:refs, '\r\n*')[1:]
endfunction
command! -bang Gbranch call fzf#run({
      \ 'source': 'git branch -a --no-color | grep -v "^\* " ',
      \ 'sink': function('s:changebranch')
      \ })
command! -bang Grefs call fzf#run({
      \ 'source': s:gitListRefs(),
      \ 'sink': function('s:gitCheckoutRef'),
      \ 'dir':expand('%:p:h')
      \ })


" ----------------------------------------------------------------------------
"   Limelight (for Goyo)
" ----------------------------------------------------------------------------
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Default: 0.5
let g:limelight_default_coefficient = 0.7


" ----------------------------------------------------------------------------
"   Startify
" ----------------------------------------------------------------------------
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
    let bookmarks = systemlist("cut -d' ' -f 2 ~/.NERDTreeBookmarks")
    let bookmarks = bookmarks[0:-2] " Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_files_number = 8
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
"let g:startify_disable_at_vimenter = 1
" Specify a session directory
"let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   Files']            },
        \ { 'type': 'dir',       'header': ['   Current: '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
let g:startify_bookmarks = [
            \ { 'v': '~/.vimrc' },
            \ { 'z': '~/.zshrc' },
            \ '~/.bashrc',
            \ '~/Documents/Codes',
            \ '~',
            \ ]


" ----------------------------------------------------------------------------
"   Vim Which Key
" ----------------------------------------------------------------------------
let g:which_key_map =  {}
let g:which_key_sep = '→'
" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function
let g:which_key_map['c'] = [ '<Plug>NERDCommenterToggle'  , 'comment' ]
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['o'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['f'] = [ ':NERDTreeToggle'            , 'nerdtree' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['T'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['g'] = [ 'Goyo'                       , 'zen' ]
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }


" ----------------------------------------------------------------------------
"   Indent Guides + indentLine
" ----------------------------------------------------------------------------
" let g:indentLine_setColors = 0
" let g:indent_guides_guide_size = 1
" let g:indent_guides_color_change_percent = 3
" let g:indent_guides_enable_on_vim_startup = 2


" ----------------------------------------------------------------------------
"   Devicons
" ----------------------------------------------------------------------------
"let g:webdevicons_conceal_nerdtree_brackets = 1
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ''


" ----------------------------------------------------------------------------
"  Telescope
" ----------------------------------------------------------------------------
lua << EOF
require('telescope').setup{
  defaults = {
    prompt_prefix = "$ ",
  }
  --[[extensions = {
    fzf = {
      fuzzy = true,
    }
  }]]
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
EOF

" ----------------------------------------------------------------------------
"   Key maps and remaps
" ----------------------------------------------------------------------------
" findin the right file and opening on it
nnoremap <Leader>f :NERDTreeToggle<Enter>
"nnoremap <silent> <Leader>v :SyncTree()<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" Undo Tree Visualizer
nnoremap <leader>u :UndotreeShow<CR>
" Vim Splits Movement
nnoremap <C-w>Right <C-w>h
nnoremap <C-w>Down <C-w>j
nnoremap <C-w>Up <C-w>k
nnoremap <C-w>Left <C-w>l
" Vim Splits Resize
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Left> :vertical resize -3<CR>
" Vim Splits Toggle
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K
" Buffer navigation
map <leader>bn :bnext<CR>
map <leader>bb :bprevious<CR>
map <leader>bd :bdelete<CR>
" Managing tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
" Better tabbing
vnoremap < <gv
vnoremap > >gv
" Coc Explorer
nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-z> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>
" Move selected lines Up or Down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv
" Neomake Panel Close
nnoremap <Leader>c :lclose<Enter>
" FZF
nnoremap <Leader>o :Files<CR>
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Goyo
noremap <Leader>g :Goyo<CR>
" Float Term
noremap <A-t> :FloatermNew<CR>
noremap <A-r> :FloatermNew ranger<CR>
noremap <A-b> :FloatermNew --wintype=normal --height=6<CR>
" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" Copy the relative path of the current file to the clipboard
nmap <Leader>cf :silent !echo -n % \| xclip<Enter>
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Substitute the word under the cursor.
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" Launch lazygit
nmap <leader>\g :FloatermNew! EDITOR=floaterm zsh -c 'lazygit'; exit<CR>
" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" ----------------------------------------------------------------------------
"  Emmet Trigger Key
" ----------------------------------------------------------------------------
"let g:user_emmet_mode='a'
" let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_leader_key='<TAB>'

" ----------------------------------------------------------------------------
"   Coc Explorer
" ----------------------------------------------------------------------------
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nnoremap <space>ed :CocCommand explorer --preset .vim<CR>
nnoremap <space>ef :CocCommand explorer --preset floating<CR>
nnoremap <space>ec :CocCommand explorer --preset cocConfig<CR>
nnoremap <space>eb :CocCommand explorer --preset buffer<CR>

" List all presets
nnoremap <space>el :CocList explPresets<CR>

" Reveal to current buffer for closest coc-explorer
nnoremap <Leader>er :call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>

" ----------------------------------------------------------------------------
"   Misc commands
" ----------------------------------------------------------------------------
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" For Git Grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" For Rip Grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Custom Rip Grep
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


