# Class: master::config
#
# This module manages puppetserver bootstrap and configuration
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class master::config {

  assert_private()

  file { $master::params::service_config_file:
    ensure  => $master::params::service_enable,
    mode    => '0644',
    content => template('master/puppetserver-config.erb')
  }


}