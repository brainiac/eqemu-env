#!/bin/bash

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
