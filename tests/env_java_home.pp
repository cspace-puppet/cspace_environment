include cspace_environment::env_java_home
include cspace_environment::osfamily
include stdlib

# class { 'cspace_environment::env_java_home': }

$default_home = $cspace_environment::env_java_home::default_java_home
notice( "Default value of JAVA_HOME environment variable is ${default_home}" )
