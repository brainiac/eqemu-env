# Provides configuration defaults for the eqemu development server
# Make sure that whatever defaults are given here match the Vagrantfile configuration

# Hostname of the vm
export EQEMU_VM_HOSTNAME=eqemu-dev

# Username used by the vm
export EQEMU_VM_USERNAME=vagrant

# internal IP Address of the vm (host only)
export EQEMU_VM_INT_IP=`ifconfig eth0 | grep "inet addr:" | awk -F: '{ print $2 }' | awk '{ print $1 }'`

# external IP Address of the vm (bridged)
export EQEMU_VM_EXT_IP=`ifconfig eth1 | grep "inet addr:" | awk -F: '{ print $2 }' | awk '{ print $1 }'`

# Location of the root (home) directory
export EQEMU_HOME=/home/vagrant

# Name of the shared scripts folder within the vm
export EQEMU_VM_SCRIPTS_SHARE=setup_scripts

# root password of the mysql installation
export EQEMU_MYSQL_ROOTPW=password

# username and password for eqemu MYSQL user
export EQEMU_MYSQL_USERNAME=eqemu
export EQEMU_MYSQL_PASSWORD=eqemupw

# name of the database to use for the emulator
export EQEMU_MYSQL_DATABASE=peqdb

# Admin user name and password
export EQEMU_ADMIN_USERNAME=admin
export EQEMU_ADMIN_PASSWORD=password

# Short and long name for the server
export EQEMU_SERVER_SHORTNAME=eqemudev
export EQEMU_SERVER_LONGNAME="EQEmu Development Environment"

# a Random value to use for key
export EQEMU_RANDOM_KEY=`head /dev/urandom -c256 | tr -dc A-Za-z0-9_`
