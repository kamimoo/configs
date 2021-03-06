## vim:ft=zsh

export LANG=ja_JP.UTF-8
export EDITOR=vim
#export PYTHONPATH=/usr/lib/python2.6/

# Show VCS information
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%c%u(%r)-(%b)"
zstyle ':vcs_info:git:*' actionformats "%c%u(%r)-(%b)|%a"
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "?"
zstyle ':vcs_info:*' enable git

function _update_vcs_info_msg() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
setopt prompt_subst

autoload -U colors
colors
case ${UID} in
	0)
	PROMPT="%B%F{cyan}%m:%n%#%f%b "
	PROMPT2="%B%F{cyan}%_#%fb "
	;;
	*)
	PROMPT="%F{cyan}[%m]:%n%%%f%1(v|%F{green}%1v%f|) "
	PROMPT2="%F{cyan}%_%%%f "
	;;
esac

case ${TERM} in
	screen*)
		RPROMPT="%F{black}%K{yellow}[%~]%k%f"
	;;
	*)
		RPROMPT="%F{yellow}[%~]%f"
	;;
esac

SPROMPT="%F{cyan}%r is correct? [n,y,a,e]:%f "


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
[[ -x "`which gdircolors`" ]] && eval `gdircolors`
[[ -x "`which dircolors`" ]] && eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*:default' menu select=2

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
HISTSIZE=100000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# alias
case $(uname) in
	*BSD|Darwin)
		if [ -x "`which gls`" ]; then
			alias ls="gls --color=auto"
		fi
		;;
	*)
		alias ls='ls --color=auto'
		;;
esac

alias la="ls -lhF"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

# functions


#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/kamimoo/.gvm/bin/gvm-init.sh" ]] && source "/Users/kamimoo/.gvm/bin/gvm-init.sh"
