#!/bin/bash

SCRIPTS_PATH=/home/vagrant/scripts

# load our emu configuration environment
. $SCRIPTS_PATH/eqemu_config.sh

# Load up arguments
FETCH_SOURCE=
while true; do
	case "$1" in
		--with-source ) FETCH_SOURCE=true; shift ;;
		-- ) shift; break ;;
		* ) break ;;
	esac
done

# transfer configs
python $SCRIPTS_PATH/eqemu_transfer_configs.py

# fetch source code if we require it
if $FETCH_SOURCE ; then
	$SCRIPTS_PATH/eqemu_fetch_source.sh
else
	$SCRIPTS_PATH/eqemu_setup_source.sh
fi

if [ !-d /home/vagrant/source/EQEmuServer ]; then
	echo "\033[1;91mCould not find source...\033[0m"
	exit 1
fi

# download and install our emu resources
$SCRIPTS_PATH/eqemu_install_resources.sh

# set up the project eq database
$SCRIPTS_PATH/eqemu_setup_database.sh

# build login server
$SCRIPTS_PATH/eqemu_build_loginserver.sh

# build everything else
$SCRIPTS_PATH/eqemu_build_emuserver.sh
