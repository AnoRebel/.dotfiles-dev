set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if !has('nvim')
	set ttymouse=xterm2
endif

