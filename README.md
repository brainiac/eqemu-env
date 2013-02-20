
Summary
=======

This is a development environment for the EQEmulator project based on Ubuntu 12.04 (Precise Pangolin 32bit). It will set up everything required to run an eqemu development server.

Requirements
------------

* Vagrant: http://www.vagrantup.com
* Virtualbox 


Usage
-----

There are two options for setup. You can either provide the source on the host, which will allow you to edit source on your host machine, or you can fetch the source from the repository from within the vm.

The first option is better for people who like to write code. The second option is for everybody else.


### Providing source from the host

You need to check out your source and put it in a specific location

    $ mkdir source; cd source
	$ git clone http://github.com/EQEmu/Server.git

Then you can start the VM as usual:

    $ vagrant up

Once the VM is up and running, you can then ssh into the vm and start the environment construction:

    $ vagrant ssh
    
    $ scripts/eqemu_initial_setup.sh


### Starting the VM without providing source

In this case, the VM will download its own source.

    $ vagrant up

Once the VM is up and running, you can then ssh into the vm and start the environment construction:

    $ vagrant ssh

	$ scripts/eqemu_initial_setup.sh --with-source

the argument --with-source tells the setup script that it needs to provide source. Otherwise it will try to use the source provided in the above steps, and will fail if it is not present.

### Using the VM

After the initial setup, you might want to rebuild source:

#### Rebuilding Source

Binaries and configuration are built and delivered to /home/vagrant/server. You can rebuild the binaries from source using the following commands:

    scripts/eqemu_build_emuserver.sh
	scripts/eqemu_build_loginserver.sh

Or, for convenience:

	./build.sh

Will build the server minus login server.

#### Running the server

A couple convenience scripts exist:

    ./startup.sh

Will start the loginserver, the world server, and eqlaunch + zone servers

    ./killall.sh

Will kill all the servers.

Logs are written to server/logs


