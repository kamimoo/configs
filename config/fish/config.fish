set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim

# fisherman

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# android
if test -e $HOME/Library/Android/sdk
	set -x ANDROID_HOME $HOME/Library/Android/sdk
	set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools
end

# flutter
if test -e $HOME/Library/flutter
	set -x PATH $PATH $HOME/Library/flutter/bin
end

# Homebrew
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -x HOMEBREW_NO_ANALYTICS 1

# direnv
if test -x /usr/local/bin/direnv
	eval (direnv hook fish)
end

# nodenv
if test -x /usr/local/bin/nodenv
	status --is-interactive; and source (nodenv init -|psub)
	set -x PATH $PATH $HOME/.nodenv/shims
end

# Go
if test -x $HOME/go
	set -x GOPATH $HOME/go
	set -x PATH $PATH $GOPATH/bin
end

# Python3
if test -x $HOME/Library/Python/3.7/bin/pip
	set -x PATH $PATH $HOME/Library/Python/3.7/bin
end
