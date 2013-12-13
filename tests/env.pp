class { 'cspace_environment::env': }

notify{ "env_vars_list=${cspace_environment::env::cspace_env_vars}": }
