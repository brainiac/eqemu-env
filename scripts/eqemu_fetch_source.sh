#!/bin/sh

# Fetch source code from github
# put the source code in a separate location because we might have had source
# provided to us by a share from the host
SOURCE_PATH=/home/vagrant/source/EQEmuServer
CLONE_PATH=/home/vagrant/source/EQEmuServer_Source

# not sure what to do if already exists
if [ ! -d $CLONE_PATH ]; then
	echo
	echo "\033[1;92mCloning source repository...\033[0m"
	git clone http://github.com/EQEmu/Server.git $CLONE_PATH
fi

if [ ! -e $SOURCE_PATH ]; then
	ln -s $CLONE_PATH $SOURCE_PATH
fi
