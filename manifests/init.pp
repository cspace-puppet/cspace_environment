# Class: cspace_environment
#
# This module manages cspace_environment
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
	
	include cspace_environment::tempdir
	
  user {'cspace':
    ensure => present,
    home => '/home/cspace',
    managehome => true,
  }
  
  file {'/etc/profile.d/cspace_environment.sh':
    source => 'puppet:///modules/cspace_environment/cspace_environment.sh'
  }
  
  file {'/usr/local/bin/papply.sh':
    source => 'puppet:///modules/cspace_environment/papply.sh'
  }
  
  exec { 'chmod ugo+x papply.sh':
    cwd     => "/usr/local/bin",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
    require => File["chmod ugo+x papply.sh"]
  }
}
