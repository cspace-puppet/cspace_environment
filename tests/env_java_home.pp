include cspace_environment::osfamily
include stdlib

class { 'cspace_environment::java_home': }

notice( "Value of JAVA_HOME environment variable is ${cspace_environment::java_home}" )
