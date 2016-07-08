## vim:ft=zsh

# Do not read /etc/*
setopt no_global_rcs

# 重複したパスを登録しない
typeset -U path
export PATH="/usr/local/bin:$PATH"

# python
export PATH="/usr/local/share/python:$PATH"
# virtualenvのルートディレクトリ
export WORKON_HOME=$HOME/.virtualenvs
export PIP_RESPECT_VIRTUALENV=true
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# haskell
if [ -s "$HOME/.cabal" ]; then
	export PATH="$HOME/.cabal/bin:$PATH"
fi

# rbenv
if [ -e $HOME/.rbenv ]; then
	export PATH="$HOME/.rbenv/shims:$PATH"
	eval "$(rbenv init -)"
fi

# phpenv
if [ -e $HOME/.phpenv ]; then
	export PATH="$HOME/.phpenv/bin:$PATH"
	eval "$(phpenv init -)"
fi

# haxe
if [ -x "`which haxe`" ]; then
	export HAXE_LIBRARY_PATH="/usr/lib/haxe/std"
fi

# node
if [ -e $HOME/.nodebrew ]; then
	export PATH=$HOME/.nodebrew/current/bin:$PATH
fi
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH

#android
if [ -e $HOME/android-sdk ]; then
	export ANDROID_HOME=$HOME/android-sdk
	export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
fi

#sdkman
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#gradle
if [ -e $HOME/.sdkman/gradle/current ]; then
	export GRADLE_HOME=$HOME/.sdkman/candidates/gradle/current
fi

#

#java
case $(uname) in
	*BSD|Darwin)
		export JAVA_OPTS='-Dfile.encoding=UTF-8 -Dgroovy.source.encoding=UTF-8'
		JAVA8_HOME=`/usr/libexec/java_home -v "1.8" -F`
		if [ $? -eq 0 ]; then
			export JAVA8_HOME
		fi
		;;
	*)
		;;
esac
export HOMEBREW_CASK_OPTS='--appdir=/Applications'
export HOMEBREW_NO_ANALYTICS=1
