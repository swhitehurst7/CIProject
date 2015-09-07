
#Create a static ipaddress for the master
masterIP = '10.50.15.13'

# A configuration blueprint for all machines that are provisioned
Vagrant.configure("2") do |o|

	#setting up the box
	o.vm.box = "ubuntu/trusty64"

	# Creating a public network; autoassigning ipaddresses

	
	# Anything in the puppet file is synced with /opt/puppet 
	o.vm.synced_folder "puppet", "/opt/puppet" 
	
	o.vm.provider "virtualbox" do |vb|
	vb.memory = 2056
	vb.cpus = 2
end

	
o.vm.provision "puppet" do |puppet|
	
	# sets the master fqdn
	#puppet.puppet_server = "master.netbuilder.private"
	
	# sets the agent fqdn
	#puppet.puppet_node = "agent001.netbuilder.private"
	puppet.manifests_path = "puppet/manifests"
	puppet.module_path = "puppet/modules"
	
	# specifies the site.pp file
	puppet.manifest_file = "site.pp"
end



o.vm.define "Master" do |master|
	
	# master.vm.box = "ubuntu/trusty64"
	master.vm.network :public_network, ip: masterIP
	master.vm.hostname = "master"
		
end


#o.vm.define "Agent001" do |agent001|

	# setting the agent as a public network
	# agent001.vm.network :public_network, ip: agentIP


	#agent001.vm.box = "ubuntu/trusty64" 


	#agent001.vm.hostname = "agent001"
#end
end
