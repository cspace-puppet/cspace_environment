class { 'cspace_environment::tempdir': }

notify { "Temporary directory is ${cspace_environment::tempdir::system_temp_directory}": }
