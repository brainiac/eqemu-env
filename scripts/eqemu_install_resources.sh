#!/bin/sh

. /home/vagrant/setup_scripts/eqemu_config.sh

echo "Installing EQEmu Resources... $EQEMU_HOME"

#
# Prepare everything by making necessary directories
#
mkdir -p $EQEMU_HOME/server/logs
mkdir -p $EQEMU_HOME/source
mkdir -p $EQEMU_HOME/server/maps
mkdir -p $EQEMU_HOME/server/quests
mkdir -p $EQEMU_HOME/server/plugins

cd $EQEMU_HOME/source

# get the most recent copies of items, quests, maps, etc
if [ ! -e peqdatabase ]; then
	echo "Downloading Database"
	svn co http://projecteqdb.googlecode.com/svn/trunk/peqdatabase
fi

if [ ! -e quests ]; then
	echo "Downloading Quests"
	svn co http://projecteqquests.googlecode.com/svn/trunk/quests
fi

if [ ! -e maps ]; then
	echo "Downloading Maps"
	svn co http://eqemumaps.googlecode.com/svn/trunk/Maps maps
fi

if [ ! -e alloclone-eoc-read-only ]; then
	echo "Downloading AllaClone"
	svn co http://allaclone-eoc.googlecode.com/svn/trunk/ allaclone-eoc-read-only
fi

# This next part should probably be broken out into another script so we can
# run it again later...

# Now copy from the source directories to the SERVER directories as necessary
echo "Installing Maps"
cp -r $EQEMU_HOME/source/Maps/* $EQEMU_HOME/server/maps/

echo "Installing Quests"
cp -r $EQEMU_HOME/source/quests/* $EQEMU_HOME/server/quests/

cp -r $EQEMU_HOME/source/quests/plugins/* $EQEMU_HOME/server/plugins/

# TODO: Setup login server sources?
