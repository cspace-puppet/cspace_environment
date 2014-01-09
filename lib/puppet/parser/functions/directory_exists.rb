# Function to identify whether a directory exists, given its path

# See also "Custom Functions":
# http://docs.puppetlabs.com/guides/custom_functions.html
# and "Plugins in Modules"
# http://docs.puppetlabs.com/guides/plugins_in_modules.html

module Puppet::Parser::Functions
  newfunction(:directory_exists) do |args|
    dirpath = args[0]
    if File.exists?(dirpath) && File.directory?(dirpath)
      returnval = true
    else
      returnval = false
    end
    returnval
  end
end
