# Class: cspace_environment::env_java_home
#
# Manages the default value for the JAVA_HOME environment variable,
# used during the build and deployment of a CollectionSpace server instance.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

include cspace_environment::env # to add environment variables as Facter facts
include cspace_environment::osfamily

class cspace_environment::env_java_home {
  
  $os_family = $cspace_environment::osfamily::os_family

  # Default JAVA_HOME value varies by platform
  case $os_family {
    RedHat, Debian: {
      notice("java_home_alternatives=${::java_home_alternatives}")
      # See http://www.oracle.com/technetwork/java/javase/install-linux-rpm-137089.html
      $default_oracle_java_home = '/usr/java/latest'
      # The variable below was added as a custom Facter fact via
      # the lib/facter/java_home_alternatives.rb script in this module.
      #
      # If the 'alternatives' system returns the default path to the 'java'
      # executable file, set JAVA_HOME to its relevant parent directory, if present.
      if (
           ($::java_home_alternatives != undef) and
           (! empty($::java_home_alternatives)) and
           (directory_exists($::java_home_alternatives))
         ) {
        $default_java_home        = $::java_home_alternatives
      }
      # Otherwise, use the default directory for Oracle Java installations, if present.
      elsif (directory_exists($default_oracle_java_home)) {
        $default_java_home        = $default_oracle_java_home
      }
      else {
        notice('Could not find suitable value for JAVA_HOME environment variable.')
      }    
    }
    # OS X
    darwin: {
      # The variable below was added as a custom Facter fact via
      # the lib/facter/java_home_osx.rb script in this module.
      $default_java_home          = $::java_home_osx
    }
    # Microsoft Windows
    windows: {
    }
    default: {
    }
  } # end case $os_family
  
  if ( ($::env_java_home != undef) and (! empty($::env_java_home)) ) {
    $java_home = $::env_java_home
  }
  else {
    $java_home = $default_java_home
  }

}
