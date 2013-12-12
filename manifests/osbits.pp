# Class: cspace_environment::osbits
#
# This class identifies the memory address size of the active operating system
# (with values returned currently expected to be either 64-bit or 32-bit)
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_environment::osbits {

  # Josh Cooper noted: "The fact name hardwaremodel is a bit misleading,
  # and the docs aren’t really clear about whether it’s the OS or CPU ...
  # It’s really reporting on the OS (in the sense that that’s how people
  # use the fact, e.g. to select the appropriate package [for installation])."
  # http://projects.puppetlabs.com/issues/16948#note-2
  
  # Note: assumes values pertinent to systems with Intel/AMD/equivalent CPUs  
  case $::hardwaremodel {
    'x86_64', 'IA64', 'ia64', 'AMD64', 'amd64': {
      $os_bits = '64-bit'
    }
    # Other hardware models following this naming convention,
    # ending in a non-digit character followed by '64'
    /^.*?\D64$/: {
      $os_bits = '64-bit'
    }
    # 'i386', 'i486', 'i586', 'i686' ...
    /^i[3-9]86$/: {
      $os_bits = '32-bit'
    }    
    default: {
      fail( 'Unknown hardware model when attempting to identify OS memory address size' )
    }
  }
  
}
