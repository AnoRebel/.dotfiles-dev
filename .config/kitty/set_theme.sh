#!/usr/bin/env bash

[[ $# -ne 1 ]] && echo "Syntax: $(basename $0) kitty_theme.conf" && exit 1

# check theme dir or if wal
# so pass in atom.conf
themes="$(find ~/.config/kitty/themes -name "*conf" |
awk -F"/" '{print $NF}' |
tr '[A-Z]' '[a-z]' | sed 's/.conf//')"
themes="$themes wal"

replace_scheme_in_conf(){ 
  if [[ "$1" == "wal" ]]; then
    sed -i '' "s|include.*conf|include ~/.cache/wal/colors-kitty.conf|" ~/.config/kitty/kitty.conf
  else
    [[ $(ls "~/.config/kitty/themes/$1.conf" 2> /dev/null | wc -l) -eq 0 ]] && echo "~/.config/kitty/themes/$1.conf doesn't exist" && exit 1
    sed -i '' "s|include.*conf|include ~/.config/kitty/themes/$1.conf|" ~/.config/kitty/kitty.conf
  fi
}

[[ $themes =~ $1 ]] && replace_scheme_in_conf $1 && kitty @ set-colors --all --configured ~/.config/kitty/kitty.conf

# theme="$(echo $1 | sed 's|$HOME|~|')"
# themes=($(ls -1 ~/.cache/wal/colors-kitty.conf ~/.config/kitty/themes/* | sed "s|$HOME|~|"))
# num=$(( $RANDOM % ${#themes[@]} ))
# new="${themes[$num]}"
# sed -i '' "s|include.*conf|include $new|" ~/.config/kitty/kitty.conf
# kitty @ set-colors --all --configured ~/.config/kitty/kitty.conf
