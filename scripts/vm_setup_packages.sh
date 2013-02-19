#!/bin/bash

echo
echo "Updating system packages"
echo

# Update system's packages
if [ ! -e /home/vagrant/.system-updated ]; then
	echo "Updating the system's package references. This can take a few minutes..."
	sudo apt-get -y update
	sudo apt-get -y install perl
	sudo apt-get -y install cmake
	sudo apt-get -y install subversion gcc g++ cpp libio-stringy-perl
	sudo apt-get -y install zlib-bin zlibc unzip make
	sudo apt-get -y install libperl-dev
	sudo apt-get -y install python python-pip

	# for convenience...
	sudo apt-get -y install vim
	sudo apt-get -y install gdb

	su -c "touch /home/vagrant/.system-updated" vagrant
fi
