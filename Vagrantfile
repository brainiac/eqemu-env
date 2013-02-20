
Vagrant::Config.run do |config|
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	config.vm.host_name = "eqemu-dev"	
	config.vm.network :bridged

	config.vm.share_folder "v-scripts", "/home/vagrant/scripts", "scripts"
	config.vm.share_folder "v-source", "/home/vagrant/source/host-env", "."

	# Enable and configure the chef solo provisioner
	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = "provisioning/chef"
		#chef.log_level = :debug

		chef.run_list = [
			"recipe[apt]",
			"recipe[git]",
			"recipe[openssl]",
			"recipe[mysql]",
			"recipe[mysql::server]",
			"recipe[mysql::client]",
		]

		chef.json.merge!({
			:mysql => {
				:server_root_password => 'password',
				:server_repl_password => 'password',
				:server_debian_password => 'password',
			}
		})
	end

	config.vm.provision :shell, :path => "scripts/vm_setup_packages.sh"
	config.vm.provision :shell, :path => "scripts/vm_configure_shared_mem.sh"
	config.vm.provision :shell, :path => "scripts/vm_finalize_setup.sh"
end
