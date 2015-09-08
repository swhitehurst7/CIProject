In order for the Vagrant Up command to work you must ensure there is a Puppet folder within the Project folder containing the modules and manifests folder inside it. It is within the manifests folder that the site.pp has to be touced into in order for vagrant to provision the machine correctly. Below is the file structure expected:

ProjectFolder	>  Puppet   >   Modules
		            >   Manifests  >  site.pp


###################   Install Agent   #####################

To install the agent make sure you download the Vagrantfile present in the 'Vagrant' branch.
