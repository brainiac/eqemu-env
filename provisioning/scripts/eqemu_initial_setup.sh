#!/bin/bash

su -c "/home/vagrant/setup_scripts/eqemu_install_resources.sh" vagrant
su -c "/home/vagrant/setup_scripts/eqemu_setup_database.sh" vagrant

