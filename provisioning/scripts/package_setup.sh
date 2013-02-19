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

	su -c "touch /home/vagrant/.system-updated" vagrant
fi

# Update shared memory configuration
echo 
echo "Updating Shared Memory Configuration"
echo
sudo cp /etc/sysctl.conf /etc/sysctl.conf.original
grep -v "kernel.shm" /etc/sysctl.conf | grep -v "Added by provisioning" > /etc/sysctl.conf.new
sudo mv /etc/sysctl.conf.new /etc/sysctl.conf

sudo echo "# Added by provisioning for eqemu" >> /etc/sysctl.conf
sudo echo "kernel.shmmax = 134217728" >> /etc/sysctl.conf
sudo echo "kernel.shmall = 65536" >> /etc/sysctl.conf

