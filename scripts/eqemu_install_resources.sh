#!/bin/sh

. /home/vagrant/scripts/eqemu_config.sh

#
# Prepare everything by making necessary directories
#
mkdir -p $EQEMU_HOME/server/logs
mkdir -p $EQEMU_HOME/source
mkdir -p $EQEMU_HOME/server/Maps
mkdir -p $EQEMU_HOME/server/quests
mkdir -p $EQEMU_HOME/server/plugins

cd $EQEMU_HOME/source

# get the most recent copies of items, quests, maps, etc

if [ ! -e quests ]; then
	echo
	echo "\033[1;92mDownloading Quests...\033[0m"
	svn co http://projecteqquests.googlecode.com/svn/trunk/quests
fi

echo
echo "\033[1;92mInstalling Quests...\033[0m"
cp -r $EQEMU_HOME/source/quests/* $EQEMU_HOME/server/quests/
rm -rf $EQEMU_HOME/server/quests/plugins

cp -r $EQEMU_HOME/source/quests/plugins/* $EQEMU_HOME/server/plugins/

if [ ! -e Maps ]; then
	echo
	echo "\033[1;92mDownloading Maps...\033[0m"
	svn co http://eqemumaps.googlecode.com/svn/trunk/Maps
fi

# Now copy from the source directories to the SERVER directories as necessary
echo
echo "\033[1;92mInstalling Maps...\033[0m"
cp -r $EQEMU_HOME/source/Maps/* $EQEMU_HOME/server/Maps/

