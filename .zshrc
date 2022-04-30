# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias wetha='curl -s "http://wttr.in/~Dar-es-salaam" | head -n 38'
alias zenji='curl -s "http://wttr.in/~Zanzibar" | head -n 38'

alias pgadmin='cd ~/adminer ; nohup php -S 127.0.0.1:3066 &>logs & ; brave-browser 127.0.0.1:3066 & ; cd'

# alias lampp='sudo /opt/lampp/./manager-linux-x64.run'
alias lampp="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY /opt/lampp/manager-linux-x64.run &"

alias please="sudo"
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"

alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'

alias py='python3'
alias py2='python2'

alias c="clear"
alias q="exit"
alias aptclean="sudo apt clean ; sudo apt autoclean ; sudo apt autoremove"
alias aptupd="sudo apt update"
alias aptupg="sudo apt upgrade"
alias aptinstall="sudo apt install"
alias aptremove="sudo apt remove"

# Dotbare config
export DOTBARE_DIR="$HOME/.dotfiles"
export DOTBARE_TREE="$HOME"

# Markdown reader
mdr () {
  pandoc $1 | lynx -stdin
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

bgnotify_threshold=4  ## set your own notification threshold

function bgnotify_formatted {
  ## $1=exit_status, $2=command, $3=elapsed_time
  [ $1 -eq 0 ] && title="Done." || title="Tha Hell.."
  bgnotify "$title -- after $3 s" "$2";
}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#-------- ZSH Shell Only {{{
#------------------------------------------------------
# ignore duplicates from ~/.zsh_history
setopt histignoredups
cfg-zsh-history() { $EDITOR $HISTFILE ;}
# }}}

# Path to your oh-my-zsh installation.
  export ZSH=/home/dev/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="random"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
zsh-autosuggestions
zsh-completions
zsh-syntax-highlighting
dotbare
bgnotify
sudo
pipenv
zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

# Dotbare completions
_dotbare_completion_cmd

# User configuration
# disable zsh autocorrect
unsetopt correct_all

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

#		ZSH Stuff
#======================================================
#-------- Commands {{{
#------------------------------------------------------
# Show dots if tab compeletion is taking long to load
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

#}}}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias copy="rsync -rP"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send -u low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# open file with default program base on extension
# Ex: 'alias -s avi=mplayer' makes 'file.avi' execute 'mplayer file.avi'
alias -s {avi,flv,mkv,mp4,mpeg,mpg,ogv,wmv}=$PLAYER
alias -s {flac,mp3,ogg,wav}=$MUSICER
alias -s {gif,GIF,jpeg,JPEG,jpg,JPG,png,PNG}="background $IMAGEVIEWER"
alias -s {djvu,pdf,ps}="background $READER"
alias -s txt=$EDITOR
alias -s epub="background $EBOOKER"
alias -s {cbr,cbz}="background $COMICER"
# might conflict with emacs org mode
alias -s {at,ch,com,de,net,org}="background $BROWSER"

alias ls='exa --icons --color=automatic --color-scale -F'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --git-ignore'

function mkcd() {
	command mkdir -p $1 && cd $1
}

# Fucking irritating, had to script
function psvn() {
  git stash
  gsr
  git stash pop
}

export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:/usr/lib/dart/bin"

# Adding Go home and bin to path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH="$PATH:$HOME/flutter/bin"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Fix NVM path error
export NODE_PATH=$NODE_PATH:`npm root -g`

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Opt-out of DOTNET Telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# Cargo installation
export PATH="$HOME/.cargo/bin:$PATH"

# Deta
export PATH="$HOME/.deta/bin:$PATH"

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

. $HOME/z/z.sh

eval "$(pipenv --completion)"

export ERL_AFLAGS="-kernel shell_history enabled"

PATH="/home/dev/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/dev/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dev/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dev/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dev/perl5"; export PERL_MM_OPT;

[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh
[ -f ~/.emoji-cli/fuzzy-emoji-zle.zsh ] && source ~/.emoji-cli/fuzzy-emoji-zle.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/home/dev/.ghcup/env" ] && source "/home/dev/.ghcup/env" # ghcup-env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$PATH:/opt/mssql-tools/bin"
. "$HOME/.cargo/env"
fpath+=${ZDOTDIR:-~}/.zsh_functions
