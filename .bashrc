# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

alias wetha='curl -s "http://wttr.in/~Dar-es-salaam" | head -n 38'
alias chuga='curl -s "http://wttr.in/~Arusha" | head -n 38'

alias pgadmin='cd ~/adminer ; nohup php -S 127.0.0.1:3066 &>logs & ;
brave-browser 127.0.0.1:3066 & ; cd'

alias lampp='sudo /opt/lampp/./manager-linux-x64.run'
# alias lampp="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY/opt/lampp/manager-linux-x64.run &"

alias py='python3'
alias py2='python2'

alias bashrc='nvim ~/.bashrc'

alias please="sudo"
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"

alias c="clear"
alias q="exit"
alias aptclean="sudo apt clean ; sudo apt autoclean ; sudo apt autoremove"
alias aptupd="sudo apt update"
alias aptupg="sudo apt upgrade"
alias aptinstall="sudo apt install"
alias aptremove="sudo apt remove"

# Markdown reader
mdr() {
	pandoc $1 | lynx -stdin
}

# User Functions
mkcd() {
	command mkdir -p $1 && cd $2
}

#
# # ex - archive extractor
# # usage: ex <file>
ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

#[[ $- == *i* ]] && source $HOME/ble.sh/out/ble.sh --noattach

# Path to your oh-my-bash installation.
export OSH=/home/dev/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="agnoster"

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
	git
	composer
	ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
	general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	battery
	progress
)

source $OSH/oh-my-bash.sh

# User configuration

if [ -f /etc/bash.command-not-found ]; then
	. /etc/bash.command-not-found
fi

source <(kitty + complete setup bash)

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

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

alias copy='rsync -rP'
alias alert='notify-send -u low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# open file with default program base on extension
# Ex: 'alias -s avi=mplayer' makes 'file.avi' execute 'mplayer file.avi'
#alias -s {avi,flv,mkv,mp4,mpeg,mpg,ogv,wmv}=$PLAYER
#alias -s {flac,mp3,ogg,wav}=$MUSICER
#alias -s {gif,GIF,jpeg,JPEG,jpg,JPG,png,PNG}="background $IMAGEVIEWER"
#alias -s {djvu,pdf,ps}="background $READER"
#alias -s txt=$EDITOR
#alias -s epub="background $EBOOKER"
#alias -s {cbr,cbz}="background $COMICER"
#alias -s {cbr,cbz}="background $COMICER"
# might conflict with emacs org mode
#alias -s {at,ch,com,de,net,org}="background $BROWSER"

alias ls='exa --icons --color=automatic --color-scale -F'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:/usr/lib/dart/bin"

# Adding Go home and bin to path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH="$PATH:$HOME/flutter/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Opt-out of DOTNET Telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Fix NVM path error
export NODE_PATH=$NODE_PATH:$(npm root -g)

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

PATH="/home/dev/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="/home/dev/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="/home/dev/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"/home/dev/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=/home/dev/perl5"
export PERL_MM_OPT

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "/home/dev/.ghcup/env" ] && source "/home/dev/.ghcup/env" # ghcup-env

export PATH="$PATH:/opt/mssql-tools/bin"
. "$HOME/.cargo/env"
source ~/.bash_completion/alacritty
export PATH=$PATH:/home/dev/.spicetify
