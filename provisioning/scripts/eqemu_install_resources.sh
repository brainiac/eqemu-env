
echo "Installing EQEmu Resources..."

#
# Prepare everything by making necessary directories
#
mkdir -p /home/vagrant/server/logs
mkdir -p /home/vagrant/source
mkdir -p /home/vagrant/server/maps
mkdir -p /home/vagrant/server/quests
mkdir -p /home/vagrant/server/plugins

pushd /home/vagrant/source

# get the most recent copies of items, quests, maps, etc
if [ ! -e peqdatabase ]; then
	echo "Downloading Database"
	svn co http://projecteqdb.googlecode.com/svn/trunk/peqdatabase
fi

if [ ! -e quests ]; then
	echo "Downloading Quests"
	svn co http://projecteqquests.googlecode.com/svn/trunk/quests
fi

if [ ! -e Maps ]; then
	echo "Downloading Maps"
	svn co http://eqemumaps.googlecode.com/svn/trunk/Maps
fi

if [ ! -e alloclone-eoc-read-only ]; then
	echo "Downloading AllaClone"
	svn co http://allaclone-eoc.googlecode.com/svn/trunk/ allaclone-eoc-read-only
fi

# This next part should probably be broken out into another script so we can
# run it again later...

# Now copy from the source directories to the SERVER directories as necessary
echo "Installing Maps"
cp -r /home/vagrant/source/Maps/* /home/vagrant/server/maps/

echo "Installing Quests"
cp -r /home/vagrant/source/quests/* /home/vagrant/server/quests/
#chmod --recursive ugo+rwx /home/vagrant/server/quests/

cp -r /home/vagrant/source/quests/plugins/* /home/vagrant/server/plugins/
#chmod --recursive ugo+rwx /home/vagrant/server/plugins/

# TODO: Setup login server sources?
