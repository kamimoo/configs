set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim
set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=(brew --prefix openssl@1.1)
set -x GPG_TTY (tty)

# fisherman

if status is-interactive && ! functions -q fisher
    curl -sL https://git.io/fisher | source && fisher update
end

# android
if test -e $HOME/Library/Android/sdk
	set -x ANDROID_HOME $HOME/Library/Android/sdk
	set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools
end

# dart
if test -x /usr/local/bin/dart
	set -x PATH $PATH $HOME/.pub-cache/bin
end

# Homebrew
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -x HOMEBREW_NO_ANALYTICS 1


# Go
if test -x $HOME/go
	set -x GOPATH $HOME/go
	set -x PATH $PATH $GOPATH/bin
end

# Python3
if test -x $HOME/Library/Python/3.7/bin/pip
	set -x PATH $PATH $HOME/Library/Python/3.7/bin
end

# Java on Android Studio

if test -e /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
	set -x PATH $PATH /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin
	set -x JAVA_HOME /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
end

# asdf
source (brew --prefix asdf)/asdf.fish

# alias
alias g git

# GitHub CLI
eval (gh completion -s fish| source)


# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true
