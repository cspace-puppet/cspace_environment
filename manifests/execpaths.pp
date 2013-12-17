# Class: cspace_environment::osfamily
#
# Identifies a default set of paths for locating executable files.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_environment::execpaths {

  # Required for the array 'concat()' function used below.
  include stdlib

  # ---------------------------------------------------------
  # Declare paths for finding executable files
  # ---------------------------------------------------------

  # TODO: Consider how best to use existing PATH values from the
  # user's environment, if available.

  $linux_default_exec_paths = [
    '/bin',
    '/usr/bin',
  ]

  # Default executables path for the third-party Homebrew
  # package manager for OS X
  $osx_homebrew_exec_paths = [
    '/usr/local/bin',
  ]
  $osx_default_exec_paths =
    concat( $osx_homebrew_exec_paths, $linux_default_exec_paths )


  # ---------------------------------------------------------
  # Globally set Exec path (optional)
  # ---------------------------------------------------------

  # Uncomment if desired to globally set a default Exec path.
  #
  # This can help prevent errors of the type:
  # '{command} is not qualified and no path was specified.
  # Please qualify the command or specify a path.'
  # where a full path to a command was not specified for
  # an Exec resource, and no 'path' parameter was included.
  # See http://www.puppetcookbook.com/posts/set-global-exec-path.html

  # Exec {
  #   # path => $linux_default_exec_paths
  #   # path => $osx_default_exec_paths
  # }

}
