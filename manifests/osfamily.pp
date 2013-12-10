# Class: cspace_environment::osfamily
#
# This class identifies the operating system family
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_environment::osfamily {

  # ---------------------------------------------------------
  # Identify OS platform
  # ---------------------------------------------------------

  # When running in standalone mode, identify the operating system (OS) family
  # on this host.
  #
  # The $::osfamily fact was introduced with Facter 1.6.1. If it's not present,
  # the following is a workaround used in Puppet Labs' MySQL module; see
  # http://jenkner.org/blog/2013/03/27/use-osfamily-instead-of-operatingsystem/

  if ! $::osfamily {
    case $::operatingsystem {
      'RedHat', 'Fedora', 'CentOS', 'Scientific', 'SLC', 'Ascendos',
      'CloudLinux', 'PSBM', 'OracleLinux', 'OVS', 'OEL': {
        $os_family = 'RedHat'
      }
      'ubuntu', 'debian': {
        $os_family = 'Debian'
      }
      'SLES', 'SLED', 'OpenSuSE', 'SuSE': {
        $os_family = 'Suse'
      }
      'Solaris', 'Nexenta': {
        $os_family = 'Solaris'
      }
      default: {
        $os_family = $::operatingsystem
      }
    }
    } else {
      $os_family = $::osfamily
    }
}
