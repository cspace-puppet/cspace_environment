class { 'cspace_environment::osfamily': }

notify { "OS family is ${cspace_environment::osfamily::os_family}": }



