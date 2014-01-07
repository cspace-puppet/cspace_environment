# Class: cspace_environment::user
#
# Manages the server admin user account for a CollectionSpace server instance.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

include cspace_environment::env
include cspace_environment::osfamily
include stdlib # for file_line

class cspace_environment::user ( $user_acct_name = 'cspace' ) {

  $os_family = $cspace_environment::osfamily::os_family
  $env_vars  = $cspace_environment::env::cspace_env # hash
  
  # FIXME: Need to specify initial passwords for these user accounts.
  # See requirements for each OS here:
  # http://docs.puppetlabs.com/references/latest/type.html#user-attribute-password

  case $os_family {
    # Supported Linux OS families
    RedHat, Debian: {
      user { 'Ensure Linux user account':
        ensure     => present,
        name       => $user_acct_name,
        comment    => 'CollectionSpace server admin',
        home       => "/home/${user_acct_name}",
        managehome => true,
        system     => false,
        # FIXME: Verify that this ID is unused
        uid        => '595',
        shell      => '/bin/bash',
      }
      
      file { 'Write environment variables to profile for CollectionSpace admin user':
        path    => "/home/${user_acct_name}/.profile",
        owner   => $user_acct_name,
        group   => $user_acct_name,
        mode    => '0644',
        content => template('cspace_environment/profile.erb'),
        require => User[ 'Ensure Linux user account' ],
      }
      
      # Since under the bash shell, the .bash_profile file will be read in
      # preference to the .profile file, source the latter from the former
      # See https://www.gnu.org/software/bash/manual/bashref.html#Bash-Startup-Files
      
      file { 'Ensure presence of bash profile file':
        path    => "/home/${user_acct_name}/.bash_profile",
        require => User[ 'Ensure Linux user account' ],
      }

      file_line { 'Source profile from within bash profile':
        path    => "/home/${user_acct_name}/.bash_profile",
        line    => 'source $HOME/.profile',
        require => User[ 'Ensure presence of bash profile file' ],
      }
    }
    # OS X
    darwin: {
      user { 'Ensure OS X user account':
        ensure   => present,
        name     => $user_acct_name,
        home     => "/Users/${user_acct_name}",
        system   => false,
        # FIXME: Verify that this ID is unused
        # possibly via 'dscl . -list /Users UniqueID'
        #
        # From experimentation, uid may need to be >= 501
        # for home directory creation to succeed.
        # 'system => false' doesn't appear to be sufficient
        # to ensure a uid is assigned in that range.
        uid      => '595',
        shell    => '/bin/bash',
      }
      # See Nigel Kersten's remarks on creating OS X home directories:
      # https://groups.google.com/d/msg/puppet-users/dykZSWMqO9w/BsiGsGp0gyYJ
      #
      # Note: the user's home directory is not automatically removed when the
      # account is removed by setting 'ensure => absent' in the 'user' resource
      # above. And OS X's 'directoryservice' provider does not support the
      # 'managehome' attribute that would automatically remove it.
      exec { 'Create home directory for OS X user':
        command => "/usr/sbin/createhomedir -c -u ${user_acct_name}",
        # Check first if the home directory already exists.
        unless  => "/bin/test -d /Users/${user_acct_name}",
        require => User[ 'Ensure OS X user account' ]
      }
    }
    # Microsoft Windows
    windows: {
    }
    default: {
    }
  }

}
