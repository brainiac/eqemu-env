#!/bin/sh

# Builds and configures the login server

SOURCE_PATH=/home/vagrant/source/EQEmuServer

if [ ! -e $SOURCE_PATH ]; then
	echo "\033[1;91mCould not find emu source. Make sure it is checked out\033[0m"
	exit 1
fi

cd $SOURCE_PATH

if [ ! -d build ]; then
	mkdir build
fi

echo
echo "\033[1;92mRunning CMake...\033[0m"

# build just the login server
cd build
cmake .. -DEQEMU_BUILD_LOGIN=ON

if [ "$?" -ne 0 ]; then
	echo "\033[1;91mRunning CMake on EQEmuServer failed.\033[0m"
	exit 1
fi

for target in EMuShareMem world zone ucs queryserv eqlaunch
do
	echo "\033[1;92mBuilding $target...\033[0m"
	make $target

	if [ "$?" -ne 0 ]; then
		echo "\033[1;91mBuilding $target failed.\033[0m"
		exit 1
	fi
done

echo
echo "\033[1;92mInstalling binaries and configuration...\033[0m"

cd /home/vagrant/server

for file in libEMuShareMem.so world zone eqlaunch ucs queryserv
do
	if [ -f /home/vagrant/server/$file ]; then
		unlink /home/vagrant/server/$file
	fi

	if [ -f $SOURCE_PATH/build/Bin/$file ]; then
		cp -f -v $SOURCE_PATH/build/Bin/$file $file
	fi
done

cp -f -v $SOURCE_PATH/utils/patches/*.conf .

echo "\033[1;92mDone\033[0m"
