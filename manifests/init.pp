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
	
	# ---------------------------------------------------------
	# Identify the system temporary directory
	# ---------------------------------------------------------
	
	# The environment variables below have been added as custom Facter facts
	# via the lib/facter/env.rb script in this module.
	
	$tmpdir = $env_tmpdir # Unix, Linux, and OS X
	$temp = $env_temp # Microsoft Windows
	notify { "Unix/Linux/OS X TMPDIR is ${tmpdir}": }
	notify { "Windows TEMP is ${temp}": }
	
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
	notify { "Temporary directory is ${system_temp_directory}": }

}
