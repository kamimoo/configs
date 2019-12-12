#!/bin/sh

SHARED_SETTINGS_DIR=${XDG_CONFIG_HOME}/Code

if [ "$(uname)" == 'Darwin' ]; then
	VSCODE_SETTINGS_DIR=~/Library/Application\ Support/Code/User
	
	rm "${VSCODE_SETTINGS_DIR}/settings.json"
	ln -s "${SHARED_SETTINGS_DIR}/settings.json" "${VSCODE_SETTINGS_DIR}/settings.json"
	
	rm "${VSCODE_SETTINGS_DIR}/keybindings.json"
	ln -s "${SHARED_SETTINGS_DIR}/keybindings.json" "${VSCODE_SETTINGS_DIR}/keybindings.json"
fi


# install extentions
cat ${SHARED_SETTINGS_DIR}/extensions | while read line
do
 code --install-extension $line
done

code --list-extensions > ${SHARED_SETTINGS_DIR}/extensions


