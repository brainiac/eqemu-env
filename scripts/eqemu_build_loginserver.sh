#!/bin/sh

# Builds and configures the login server

SOURCE_PATH=/home/vagrant/source/EQEmuServer

if [ ! -e $SOURCE_PATH ]; then
	echo "\033[1;91mCould not find login source. Make sure it is checked out\033[0m"
	exit 1
fi

cd $SOURCE_PATH

if [ ! -f dependencies/libcryptopp.a -o ! -f dependencies/libEQEmuAuthCrypto.a ]; then
	echo
	echo "\033[1;92mFetching login crypto libraries...\033[0m"
	wget http://projecteqemu.googlecode.com/files/ubuntu_LoginServerCrypto_x86.zip

	rm -rf depedencies
	mkdir dependencies
	unzip -d dependencies ubuntu_LoginServerCrypto_x86.zip
	rm ubuntu_LoginServerCrypto_x86.zip
fi

if [ ! -d build ]; then
	mkdir build
fi

echo
echo "\033[1;92mBuilding loginserver...\033[0m"

# build just the login server
cd build
cmake .. -DEQEMU_BUILD_LOGIN=ON

if [ "$?" -ne 0 ]; then
	echo "\033[1;91mRunning CMake on EQEmuServer failed.\033[0m"
	exit 1
fi

make loginserver

if [ "$?" -ne 0 ]; then
	echo "\033[1;91mBuilding loginserver failed.\033[0m"
	exit 1
fi

echo
echo "\033[1;92mInstalling binaries and configuration...\033[0m"

if [ -e "/home/vagrant/server/loginserver" ]; then
	unlink /home/vagrant/server/loginserver
fi

cd /home/vagrant/server
ln -s -v $SOURCE_PATH/build/Bin/loginserver .
cp -fv $SOURCE_PATH/loginserver/login_util/login_opcodes.conf .
cp -fv $SOURCE_PATH/loginserver/login_util/login_opcodes_sod.conf .


echo "\033[1;92mDone\033[0m"
