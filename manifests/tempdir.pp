# Class: cspace_environment::tempdir
#
# Identifies the system temporary directory.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_environment::tempdir {
  
  # FIXME: This is likely not going to return the correct value
  # in a master/agent configuration, when running as 'root'
  # on the agent. See this proposed solution instead:
  # https://ask.puppetlabs.com/question/5373/how-to-reference-a-users-home-directory/?answer=5381#post-id-5381

  # ---------------------------------------------------------
  # Identify the system temporary directory
  # ---------------------------------------------------------

  # The environment variables below have been added as custom Facter facts
  # via the lib/facter/env_tmpdir.rb script in this module.

  $tmpdir = $::env_tmpdir # 'TMPDIR' under Unix, Linux, and OS X
  # $temp   = $::env_temp   # 'TEMP' under Microsoft Windows

  # FIXME: This default/fallback directory is only
  # relevant for most Unix-like systems.  See
  # http://en.wikipedia.org/wiki/Temporary_folder
  # for the fallback temporary director(ies) for Windows.
  $default_temporary_directory = '/tmp'

  if $tmpdir != undef {
    $system_temp_directory = $tmpdir
  }
  elsif $temp != undef {
    $system_temp_directory = $temp
  }
  else {
    $system_temp_directory = $default_temporary_directory
  }

}
