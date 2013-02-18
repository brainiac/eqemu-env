
Vagrant::Config.run do |config|
	config.vm.box = "precise32"

	# Enable and configure the chef solo provisioner
	config.vm.provision :chef_solo do |chef|
		
		# we're going to download our cookbooks from the web
		chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"

		# Tell chef what recipe to run. In this case, the 'vagrant_main' recipe
		# does all the magic
		chef.add_recipe("vagrant_main")
	end
end

