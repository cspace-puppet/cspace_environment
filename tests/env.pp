include stdlib

class { 'cspace_environment::env': }

$env_vars = join( sort ($cspace_environment::env::cspace_env_vars), "\n" )
notice( "CollectionSpace-relevant environment variables consist of:\n${env_vars}" )
