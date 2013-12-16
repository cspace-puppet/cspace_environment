include stdlib

class { 'cspace_environment::execpaths': }

$linux_default_paths = join( $cspace_environment::execpaths::linux_default_exec_paths, ":" )
$osx_default_paths   = join( $cspace_environment::execpaths::osx_default_exec_paths, ":" )

notice( "Linux default executable path(s) are ${linux_default_paths}" )
notice( "OS X default executable path(s) are ${osx_default_paths}" )

