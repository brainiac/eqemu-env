#!/bin/bash

set SERVERPATH=/home/vagrant/server

ulimit -c unlimited

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SERVERPATH

cd $SERVERPATH
rm -f $SERVERPATH/logs/*.log

if [ -e EQEmuLoginServer ]; then
	echo "Starting login server..."
	./EQEmuLoginServer 2>&1 > $SERVERPATH/logs/login.log &

	echo "Waiting about 5 seconds before starting world server..."
	sleep 5

	echo "Starting world server..."
	./world 2>&1 > $SERVERPATH/logs/world.log &

	echo "Waiting 10 seconds before starting the zones via launcher..."
	sleep 10

	./eqlaunch zone 2>&1 > $SERVERPATH/logs/zones.log &

	echo "The server is mostly ready... give it a couple of minutes"
	echo "to load stuff form the databases for the zones so users"
	echo "can start logging in."
fi
