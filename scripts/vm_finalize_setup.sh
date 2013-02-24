#!/bin/bash

if [ ! -e /home/vagrant/killall.sh ]; then
	ln -s /home/vagrant/scripts/eqemu_kill_all.sh /home/vagrant/killall.sh
fi
if [ ! -e /home/vagrant/startup.sh ]; then
	ln -s /home/vagrant/scripts/eqemu_startup.sh /home/vagrant/startup.sh
fi
if [ ! -e /home/vagrant/build.sh ]; then
	ln -s /home/vagrant/scripts/eqemu_build_emuserver.sh /home/vagrant/build.sh
fi

if [ -d /home/vagrant/source ]; then
	sudo chown vagrant:vagrant source
fi

. /home/vagrant/scripts/eqemu_config.sh

echo
echo "Construction of the VM is now complete. You can now log in by running:"
echo "  vagrant ssh"
echo
echo "To perform a complete initial setup of the eqemu source environment, run:"
echo "  ./scripts/eqemu_initial_setup.sh --with-source"
echo
echo "Server binaries and configuration will be deployed to ./server"
echo
echo "Connect your EverQuest client to the following loginserver:"
echo
echo " * $EQEMU_VM_EXT_IP"
echo
echo "Username: admin"
echo "Password: password"
echo
