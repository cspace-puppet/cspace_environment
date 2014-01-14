# Script to add the value of the TMPDIR environment variable, which holds 
# the location of the system temporary directory on many Unix-like systems,
# as a custom Facter fact.

# See also "Custom Facts":
# http://docs.puppetlabs.com/guides/custom_facts.html
# and "Plugins in Modules"
# http://docs.puppetlabs.com/guides/plugins_in_modules.html

# Note: when running under Ruby 1.8.7, reading the ENV hash yields this error:
# "Warning: importenv is deprecated after Ruby 1.8.1 (no replacement)"
#
# However, the ENV hash is documented as working through at least through Ruby 2.1
# (see http://ruby-doc.org/core-2.1.0/ENV.html), so doing this still appears
# to be safe. Perhaps there may later be a different underlying API call
# for obtaining the values in that hash? 

Facter.add("env_tmpdir".to_sym) do
    setcode do
        ENV['TMPDIR']
    end
end

