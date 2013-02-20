#!/bin/bash

# Update shared memory configuration
echo 
echo "Updating Shared Memory Configuration"
echo

sudo sysctl -w kernel.shmmax=134217728
sudo sysctl -w kernel.shmall=65536
sudo sysctl -p /etc/sysctl.conf
