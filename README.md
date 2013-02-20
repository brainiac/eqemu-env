
This is a development environment for the EQEmulator project based on Ubuntu 12.04 (Precise Pangolin 32bit). It will set up everything required to run an eqemu development server.

If you don't have Vagrant, install that first. Find it at http://www.vagrantup.com
Then do:

    $ vagrant up

Once the VM is up and running, you can then ssh into the vm and start the environment construction:

    $ vagrant ssh
    
    $ scripts/eqemu_initial_setup.sh --with-source

Currently, the --with-source argument is required, but in the future downloading source inside the VM will be optional. Instead, you will be able to provide the source from the host.

The idea is that you can edit the source on your host machine, and build/run the source in the vm.

