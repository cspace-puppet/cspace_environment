# Class: cspace_environment
#
# Manages environment values pertinent to a CollectionSpace server instance.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_environment {
    

  
  	# Create a (currently placeholder) set of CollectionSpace
	# server-related environment variables for all users.
	
	# file { 'Create global environment variables':
	# 	path   => '/etc/profile.d/cspace_environment.sh'
	# 	source => 'puppet:///modules/cspace_environment/cspace_environment.sh'
	# }
  
    # Create a convenience shell script for launching Puppet
	# and running the main CollectionSpace site.pp manifest.
	# file { 'Create Puppet CollectionSpace launch script':
	# 	path   => '/usr/local/bin/papply.sh',
	# 	source => 'puppet:///modules/cspace_environment/papply.sh',
	# 	mode   => 'ugo+rx',
	# }
	
}
