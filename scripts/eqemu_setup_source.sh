#!/bin/bash

# Set up source from the host environment
HOST_SOURCE=/home/vagrant/source/host-env/source

if [ -d $HOST_SOURCE ]; then
	if [ -h /home/vagrant/source/EQEmuServer ]; then
		echo "Unlinking old folder"
		unlink /home/vagrant/source/EQEmuServer
	elif [ -e /home/vagrant/source/EQEmuServer ]; then
		echo "Expected symlink for EQEmuServer, but it was something else"
		exit 1
	fi

	if [ -e $HOST_SOURCE/Source ]; then
		echo "Found source at $HOST_SOURCE/Source"
		ln -s $HOST_SOURCE/Source /home/vagrant/source/EQEmuServer
	elif [ -e $HOST_SOURCE/EQEmuServer ]; then
		echo "Found source at $HOST_SOURCE/EQEmuServer"
		ln -s $HOST_SOURCE/EQEmuServer /home/vagrant/source/EQEmuServer
	else
		echo "Not sure what your source folder is called. Try 'Source' or 'EQEmuServer'"
	fi
else
	echo "Couldn't find host-provided source directory"
fi
