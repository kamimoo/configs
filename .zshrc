export LANG=ja_JP.UTF-8
export EDITOR=vim
#export PYTHONPATH=/usr/lib/python2.6/

autoload -U colors
colors
case ${UID} in
	0)
	PROMPT="%B%{${fg[cyan]}%}%m:%n%#%{${reset_color}%}%b "
	PROMPT2="%B%{${fg[cyan]}%}%_#%{${reset_color}%}b "
	;;
	*)
	PROMPT="%{${fg[cyan]}%}[%m]:%n%%%{${reset_color}%} "
	PROMPT2="%{${fg[cyan]}%}%_%%%{${reset_color}%} "
	;;
esac

case ${TERM} in
	screen*)
	RPROMPT="%{${fg[black]}${bg[yellow]}%}[%~]%{${reset_color}%}"
	;;
	*)
	RPROMPT="%{${fg[yellow]}%}[%~]%{${reset_color}%}"
	;;
esac

SPROMPT="%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "


# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd - [tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no beep sound when complete list diplayed
#
setopt nolistbeep

# keybind
bindkey -v

# completion
autoload -U compinit
compinit
eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
	precmd() {
		echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac

# historycal backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

# alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# functions

# python
# virtualenvのルートディレクトリ
export WORKON_HOME=$HOME/.virtualenvs
export PIP_RESPECT_VIRTUALENV=true
source /usr/local/bin/virtualenvwrapper.sh

