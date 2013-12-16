include stdlib

class { 'cspace_environment::env': }

$env_vars = join( sort ($cspace_environment::env::cspace_env_vars), "\n" )
notice( "env_vars_list=${env_vars}" )
